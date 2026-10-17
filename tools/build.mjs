#!/usr/bin/env node
// Builds the generated parts of the repo from catalog.json and scripts/:
//   docs/index.html  the single-page site, with every script embedded (works offline, even from file://)
//   README.md        the script tables between the <!-- scripts:start/end --> markers
//
//   node tools/build.mjs           regenerate
//   node tools/build.mjs --check   fail if the generated files are out of date (used by CI)
//
// No dependencies; needs Node 18+.

import { existsSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join, posix } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const check = process.argv.includes('--check');

const errors = [];
const fail = (msg) => errors.push(msg);

// Normalise line endings so the output is identical whatever the checkout's autocrlf setting is.
const toLF = (s) => s.replace(/\r\n?/g, '\n');
const toCRLF = (s) => toLF(s).replace(/\n/g, '\r\n');
const read = (p) => readFileSync(join(root, p), 'utf8');

// ---------------------------------------------------------------- load and validate

const catalog = JSON.parse(read('catalog.json'));

function listScriptFiles(dir) {
  const out = [];
  for (const e of readdirSync(join(root, dir), { withFileTypes: true })) {
    const p = posix.join(dir, e.name);
    if (e.isDirectory()) out.push(...listScriptFiles(p));
    else out.push(p);
  }
  return out;
}

const onDisk = listScriptFiles('scripts').map((p) => p.slice('scripts/'.length));
const categoryIds = new Set(catalog.categories.map((c) => c.id));
const cataloged = new Set();
const required = new Set();

for (const s of catalog.scripts) {
  const where = `catalog.json: ${s.file}`;
  if (cataloged.has(s.file)) fail(`${where} is listed twice`);
  cataloged.add(s.file);
  if (!s.file.endsWith('.bat')) fail(`${where} must be a .bat file`);
  if (!existsSync(join(root, 'scripts', s.file))) fail(`${where} does not exist in scripts/`);
  if (!categoryIds.has(s.file.split('/')[0])) fail(`${where} is in a folder with no matching category`);
  if (!s.title) fail(`${where} has no title`);
  if (!s.description) fail(`${where} has no description`);
  for (const r of s.requires ?? []) {
    required.add(r);
    if (!existsSync(join(root, 'scripts', r))) fail(`${where} requires ${r}, which does not exist`);
  }
}
for (const f of onDisk) {
  if (f.endsWith('.bat') && !cataloged.has(f)) fail(`scripts/${f} is not listed in catalog.json`);
  else if (!f.endsWith('.bat') && !required.has(f)) fail(`scripts/${f} is not a .bat and no script lists it under "requires"`);
}
if (errors.length) {
  console.error(errors.map((e) => `error: ${e}`).join('\n'));
  process.exit(1);
}

// ---------------------------------------------------------------- shape the data

const scripts = catalog.scripts.map((s) => ({
  file: s.file,
  category: s.file.split('/')[0],
  name: s.file.split('/').pop(),
  title: s.title,
  description: s.description,
  admin: s.admin === true,
  note: s.note ?? '',
  requires: s.requires ?? [],
}));

const usedCategories = catalog.categories.filter((c) => scripts.some((s) => s.category === c.id));

const files = {};
for (const f of [...cataloged, ...required].sort()) files[f] = toCRLF(read(`scripts/${f}`));

const data = { site: catalog.site, categories: usedCategories, scripts, files };

// ---------------------------------------------------------------- docs/index.html

// "<" can't appear raw inside a <script> block (think "</script>" or "<!--"), so write it as a JSON escape.
const json = JSON.stringify(data).replaceAll('<', '\\u003c');
const template = toLF(read('site/template.html'));
const marker = '/*__CATALOG__*/null';
if (!template.includes(marker)) {
  console.error(`error: site/template.html is missing the ${marker} placeholder`);
  process.exit(1);
}
const html = template.replace(marker, () => json).replace('__TITLE__', () => catalog.site.title);

// ---------------------------------------------------------------- README.md tables

const startTag = '<!-- scripts:start -->';
const endTag = '<!-- scripts:end -->';
const readmeOld = toLF(read('README.md'));
const a = readmeOld.indexOf(startTag);
const b = readmeOld.indexOf(endTag);
if (a < 0 || b < a) {
  console.error(`error: README.md needs ${startTag} and ${endTag} markers`);
  process.exit(1);
}
const esc = (s) => s.replaceAll('|', '\\|');
const tables = usedCategories.map((c) => {
  const rows = scripts
    .filter((s) => s.category === c.id)
    .map((s) => `| [\`${s.name}\`](scripts/${s.file}) | ${esc(s.description)}${s.admin ? ' **Needs admin.**' : ''} |`);
  return [`### ${c.title}`, '', c.blurb, '', '| Script | What it does |', '|---|---|', ...rows].join('\n');
});
const readmeNew = `${readmeOld.slice(0, a + startTag.length)}\n\n${tables.join('\n\n')}\n\n${readmeOld.slice(b)}`;

// ---------------------------------------------------------------- write or check

const outputs = [
  ['docs/index.html', html],
  ['README.md', readmeNew],
];

let stale = 0;
for (const [path, next] of outputs) {
  const current = existsSync(join(root, path)) ? toLF(read(path)) : null;
  if (current === next) {
    console.log(`up to date  ${path}`);
  } else if (check) {
    console.error(`out of date ${path}`);
    stale++;
  } else {
    writeFileSync(join(root, path), next);
    console.log(`wrote       ${path}`);
  }
}
if (check && stale) {
  console.error('\nRun "node tools/build.mjs" and commit the result.');
  process.exit(1);
}
console.log(`\n${scripts.length} scripts, ${Object.keys(files).length} files embedded, ${usedCategories.length} categories.`);
