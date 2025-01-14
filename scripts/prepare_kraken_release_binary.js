require('./tasks');
const chalk = require('chalk');
const { series } = require('gulp');
const os = require('os');

let buildTasks = [
  'sdk-clean',
  'compile-polyfill',
  'build-android-kraken-lib',
];

if (os.platform() == 'win32') {
  buildTasks.push(
    'patch-windows-symbol-link-for-android'
  );
} else {
  buildTasks.push(
    'macos-dylib-clean',
    'build-darwin-kraken-lib',
    'ios-framework-clean',  
    'build-ios-kraken-lib',
  );
}

series(buildTasks)((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(chalk.green('Success.'));
  }
});
