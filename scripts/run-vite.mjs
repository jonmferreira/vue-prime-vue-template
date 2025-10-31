#!/usr/bin/env node
import './node-crypto-hash-polyfill.mjs';
const viteBinPath = new URL('../node_modules/.bin/vite', import.meta.url);

await import(viteBinPath.href);
