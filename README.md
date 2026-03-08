# task_manager

A new Flutter project.

## Mobile CI/CD (GitHub Actions)

This repo now includes a workflow at `.github/workflows/mobile-build.yml` that:
- Builds and uploads Android release APK (Kotlin-based Android module)
- Builds and uploads unsigned iOS `.app` zip
- Builds and uploads signed iOS IPA when signing secrets are configured

### Triggers
- Push to `main`
- Push tags matching `v*`
- Pull requests to `main`
- Manual run with `workflow_dispatch`

### Required iOS secrets (for IPA export)
Set these in GitHub repository settings under **Settings -> Secrets and variables -> Actions**:
- `IOS_CERTIFICATE_P12_BASE64` (base64 of your signing `.p12`)
- `IOS_CERTIFICATE_PASSWORD` (password for the `.p12`)
- `IOS_PROVISIONING_PROFILE_BASE64` (base64 of your `.mobileprovision`)
- `IOS_TEAM_ID` (Apple Developer Team ID)

### Optional iOS secrets
- `IOS_BUNDLE_ID` (default in workflow: `com.example.taskManager`)
- `IOS_EXPORT_METHOD` (default: `ad-hoc`, can be `app-store`, `ad-hoc`, `enterprise`, or `development`)

### Create base64 values locally
```bash
base64 -i /path/to/cert.p12 | pbcopy
base64 -i /path/to/profile.mobileprovision | pbcopy
```

Paste the copied value into the corresponding GitHub secret.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
