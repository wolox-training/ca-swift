ca-swift iOS
----------------

Application that manages book reservations for the library that Wolox has on the 2nd floor, implemented for Carolina Arcos training

# Project info & resources

* **Technical Leader**: Daniela Riesgo - daniela.riesgo@wolox.com.ar

  * [Trello board](https://trello.com/c/L0RIt3qM/16-wbooks): Project issues and current status.
  * [Google Drive](https://drive.google.com/open?id=0B0bbTjmKxmYsVVdxMkRTMVNmdnM): Design resources and assets.


# Setup

## Create a GitHub access token
You will also need to create a GitHub access token for the bootstrap script. Check [this](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) tutorial on how to do that.
The boostrap script requires GitHub credentials to be able to download private dependencies.

## Configure CarthageCache

This project uses [CarthageCache](https://github.com/guidomb/carthage_cache) to cache Carthage's build folder and speed up total build time. The boostrap script will [try](https://github.com/guidomb/ios-scripts#carthage-cache) to generate the `.carthage-cache.yml` file. It will prompt you for the AWS credentials and region. Ask the project's manager to generate a set of crendetials before bootstrapping the project. If you don't configure CarthageCache the boostrap script will tell Carthage to download and build all dependencies.

## Bootstrap project

After setting up the required accounts from all third party service, run the following commands:

```
git clone https://github.com/wolox-training/ca-swift.git
cd WBooks
script/bootstrap
open WBooks.xcodeproj
```

If any of the previous commands fail please submit an [issue](https://github.com/wolox-training/ca-swift/issues/new) specifying the command output, OS X version and XCode version.

## Scripts

Inside the `script` folder there are several scripts to facilitate the development process. For up to date documentation of this scripts check [this](http://github.com/guidomb/ios-scripts) repository. The most relevant scripts are:

  * `script/bootstrap`: Bootstraps the project for the first time.
  * `script/test`: Runs the project's tests
  * `script/update`: Updates the project's dependencies.

# Guidelines

Please before adding any code read the [pull request template](./pull_request_template.md) on how to submit a pull request with the proper format to be able to be merged upstream and also the [coding guidelines](https://github.com/Wolox/ios-style-guide) that must be followed.
