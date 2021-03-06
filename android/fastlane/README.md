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
## Android
### android getNextBuildNumber
```
fastlane android getNextBuildNumber
```

### android getBuildNameFromPubspec
```
fastlane android getBuildNameFromPubspec
```

### android build_android
```
fastlane android build_android
```

### android push_to_ps_internal
```
fastlane android push_to_ps_internal
```

### android promote_to_alpha
```
fastlane android promote_to_alpha
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
