# moments-ios

[![Build Status](https://travis-ci.com/lagoueduCol/iOS-linyongjian.svg?branch=main)](https://travis-ci.com/lagoueduCol/iOS-linyongjian)
[![Language](https://img.shields.io/badge/language-Swift%205.3-orange.svg)](https://swift.org)
[![License](https://img.shields.io/github/license/lagoueduCol/moments-ios.svg?style=flat)](https://github.com/lagoueduCol/moments-ios/blob/main/LICENSE)

## Environment setup

Please download Xcode from Mac AppStore and follow this doc [Environment setup](https://github.com/JakeLin/moments-ios/wiki/Environment-setup) to setup the environment.

After that, run the following commands:

```shell
$ bundle exec pod install
$ open Moments.xcworkspace 
```

### Automation

If you'd like to run the automation steps on your local machine, make sure your create a file called `local.keys` and put all the keys in as below:

```
CI_BUILD_NUMBER=10 # Change it every time when running the build locally
APP_STORE_CONNECT_API_CONTENT=<App Store Connect API for an App Manager>
FIREBASE_API_TOKEN=<Firebase API token for App Distribution>
GITHUB_API_TOKEN=<GitHub API token for accessing the private repo for certificates and provisioning profiles>
MATCH_PASSWORD=<Password for certificates for App signing on GitHub private repo>
```

And run `$ source local.keys` After that, you can follow the steps in [.travis.yml](https://github.com/lagoueduCol/iOS-linyongjian/blob/main/.travis.yml) to run the automations locally
