# task_manager

A new Flutter project.

## Mobile CI/CD (GitHub Actions)

This repo includes a workflow at `.github/workflows/mobile-build.yml` that:
- Builds and uploads Android release APK (Kotlin-based Android module)
- Builds and uploads unsigned iOS `.app` zip

### Triggers
- Push to `main`
- Push tags matching `v*`
- Pull requests to `main`
- Manual run with `workflow_dispatch`

### Artifacts
After a successful workflow run, you can download:
- **APK**: `app-release-apk-{run_number}` (Android)
- **iOS App**: `runner-unsigned-app-{run_number}` (unsigned .app bundle)

To find artifacts:
1. Go to **Actions** tab on GitHub
2. Click on a completed workflow run
3. Scroll to **Artifacts** section at the bottom
4. Download your build

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
