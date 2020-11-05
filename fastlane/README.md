fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios tests
```
fastlane ios tests
```
Run unit tests
### ios lint_code
```
fastlane ios lint_code
```
Lint code
### ios format_code
```
fastlane ios format_code
```
Lint and format code
### ios sort_files
```
fastlane ios sort_files
```
Sort Xcode project files
### ios archive_internal
```
fastlane ios archive_internal
```
Creates an archive of the Internal app for testing
### ios archive_appstore
```
fastlane ios archive_appstore
```
Creates an archive of the Production app with Appstore distribution

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
