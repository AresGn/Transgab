#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔍 Validating build output...');

// Check if build directory exists
const buildDir = path.join(process.cwd(), 'build');
if (!fs.existsSync(buildDir)) {
  console.error('❌ Build directory not found!');
  process.exit(1);
}

// Check if index.html exists
const indexPath = path.join(buildDir, 'index.html');
if (!fs.existsSync(indexPath)) {
  console.error('❌ index.html not found in build directory!');
  process.exit(1);
}

// Check if static directory exists
const staticDir = path.join(buildDir, 'static');
if (!fs.existsSync(staticDir)) {
  console.error('❌ Static directory not found!');
  process.exit(1);
}

// Check for JS files
const jsDir = path.join(staticDir, 'js');
if (!fs.existsSync(jsDir)) {
  console.error('❌ JS directory not found!');
  process.exit(1);
}

const jsFiles = fs.readdirSync(jsDir).filter(file => file.endsWith('.js'));
if (jsFiles.length === 0) {
  console.error('❌ No JS files found!');
  process.exit(1);
}

// Check for CSS files
const cssDir = path.join(staticDir, 'css');
if (!fs.existsSync(cssDir)) {
  console.error('❌ CSS directory not found!');
  process.exit(1);
}

const cssFiles = fs.readdirSync(cssDir).filter(file => file.endsWith('.css'));
if (cssFiles.length === 0) {
  console.error('❌ No CSS files found!');
  process.exit(1);
}

console.log('✅ Build validation successful!');
console.log(`📁 Build directory: ${buildDir}`);
console.log(`📄 JS files: ${jsFiles.length}`);
console.log(`🎨 CSS files: ${cssFiles.length}`);
console.log('🚀 Ready for deployment!');
