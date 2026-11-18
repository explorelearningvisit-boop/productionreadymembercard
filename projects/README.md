# Project workspace isolation

This repository is the standalone Flutter project **BAD GYM Member Intelligence**.

## Local workspace convention (Windows)
Keep independent applications in sibling folders, never inside one shared Flutter root:

```text
Projects/
  BAD_GYM_Member_Intelligence/   # clone of this repository
  <Next_Project_Name>/           # its own repository and toolchain
```

For this project:
- Repository: `explorelearningvisit-boop/productionreadymembercard`
- Branch: `chatgpt/member-intelligence-mobile-rebuild`
- Flutter root: repository root (contains `pubspec.yaml`)
- Release/QA APK: `build/app/outputs/flutter-apk/app-release.apk`
- CI artifact prefix: `bad-gym-member-intelligence-android-`

Do not copy another project's `build/`, `pubspec.yaml`, package ID, signing files or APK into this project. Another app must have its own sibling folder/repository, unique Android applicationId, workflow artifact prefix and output directory. Keep secrets out of source control.
