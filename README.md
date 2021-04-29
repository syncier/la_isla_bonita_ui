# la_isla_Bonita_ui

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configure GitHub Actions pipeline

1. Create a new Google Service account and API key.  
- Use the [Fastlane](https://docs.fastlane.tools/getting-started/android/setup/#collect-your-google-credentials)  
- or Google documentation to
[create service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating)
and [service account keys](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys)

2. Create a new `GooglePlay publish` Environment in the [GitHub repo settings](https://github.com/syncier/la_isla_bonita_ui/settings/environments)
and add the following `Environment secrets` to this environment
```
JK_ALIAS
JK_PASSWORD
JK_STORE_FILE
JK_STORE_PASSWORD
KEY_PATH
SUPPLY_JSON_KEY_DATA
```

| Variable | Description |
| --- | --- |
| JK_PASSWORD| Java keystore password |
| JK_STORE_FILE| Base64 encoded keystore file `openssl base64 -A -in lib_key.jks` |
| JK_ALIAS | Key alias in keystore `key` |
| JK_STORE_PASSWORD | Key password in keystore |
| SUPPLY_JSON_KEY_DATA | Google Service account key without new line characters `cat playstore_upload.json \| tr -d '\n'` |
| KEY_PATH | Path to the keystore file inside the GitHub actions `lib_key.jks` |
