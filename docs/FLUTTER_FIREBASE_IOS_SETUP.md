# Flutter + Firebase iOS setup checklist

Use this **when creating a new Flutter project** that uses Firebase (Auth, Firestore, etc.) so you avoid common iOS/CocoaPods issues.

---

## 1. Create project and add Firebase

- Create app: `flutter create my_app`
- Add Firebase packages in `pubspec.yaml`: `firebase_core`, `firebase_auth`, `cloud_firestore`, etc.
- Run `flutter pub get`
- Add Firebase to the app (Firebase Console, download `GoogleService-Info.plist` and `google-services.json`)

---

## 2. Firebase initialization (required on iOS/macOS)

- **Option A – FlutterFire CLI (recommended)**  
  - Add dev dependency: `flutterfire_cli: ^1.3.1`  
  - Install Ruby gem (needed for CLI): `sudo gem install xcodeproj`  
  - Run: `dart run flutterfire_cli:flutterfire configure`  
  - In `main.dart`:  
  `await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);`
- **Option B – Manual**  
  - Create `lib/firebase_options.dart` (from your plist/json or copy from another project).  
  - In `main.dart`:  
  `await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);`  
  - Never use `Firebase.initializeApp()` with no arguments on iOS/macOS.

---

## 3. iOS: minimum version and Podfile

- Open `ios/Podfile`:
  - Set: `platform :ios, '15.0'` (Firebase currently needs iOS 15+).
  - In the `post_install` block, set:  
  `config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'`  
  (not 12 or 13).
- Open `ios/Runner.xcodeproj/project.pbxproj`:  
Replace all `IPHONEOS_DEPLOYMENT_TARGET = 13.0` (or 12.0) with `15.0`.

---

## 4. iOS: Profile xcconfig (avoid CocoaPods warning)

- Create `ios/Flutter/Profile.xcconfig` with:
  ```
  #include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig"
  #include "Generated.xcconfig"
  ```
- In `ios/Runner.xcodeproj/project.pbxproj`:
  - Add a `PBXFileReference` for `Profile.xcconfig` (path `Flutter/Profile.xcconfig`).
  - Add it to the Flutter group.
  - Find the **Runner** target’s **Profile** build configuration and set its `baseConfigurationReference` to this new `Profile.xcconfig` (instead of `Release.xcconfig`).

---

## 5. First pod install

- Update CocoaPods repo and install:
  ```bash
  cd ios
  pod install --repo-update
  cd ..
  ```
- If you see “None of your spec sources contain a spec satisfying…” → run `pod install --repo-update` (or `pod repo update` then `pod install`).
- If you see “required a higher minimum deployment target” → ensure step 3 is done, then `rm -rf Pods Podfile.lock` and `pod install` again.

---

## 6. Run the app

```bash
flutter run
```

You should see “Firebase initialized!” and no CocoaPods base-configuration warning.

---

## Quick reference: one-time fixes per new project


| Issue                                                      | Fix                                                                                                             |
| ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Firebase not initialized on iOS                            | Use `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` and have `firebase_options.dart`. |
| Firebase/Firestore “higher minimum deployment”             | Podfile + pbxproj: iOS 15.0 everywhere.                                                                         |
| “None of your spec sources contain…”                       | `pod install --repo-update`.                                                                                    |
| “CocoaPods did not set the base configuration” for Profile | Add `Flutter/Profile.xcconfig` and point Runner Profile config to it.                                           |
| Pod version conflict (e.g. 12.8 vs 12.9)                   | `rm ios/Podfile.lock`, then `pod install --repo-update`.                                                        |


Save this file (or its path) and open it the next time you run through a **new** Flutter + Firebase setup.

---

## description: Flutter Firebase iOS setup
globs: pubspec.yaml

## Auth Dependency Graph (with GetIt)

flowchart LR
  subgraph Presentation
    UI[SignUpScreen\n(Widget)]
    BLoC[AuthBloc]
  end

  subgraph Domain
    UCSignUp[SignUpWithEmail\n(Use case)]
    UcSignIn[SignInWithEmail\n(Use case)]
    UcGetCurrent[GetCurrentUser\n(Use case)]
    RepoInt[AuthRepository\n(abstract)]
  end

  subgraph Data
    RepoImpl[AuthRepositoriesImpl]
    DS[AuthRemoteDataSourceImpl]
  end

  subgraph External
    FA[FirebaseAuth.instance]
    FS[FirebaseFirestore.instance]
  end

  %% UI to Bloc
  UI -->|"context.read()\n.add(SignUpRequested)"| BLoC

  %% Bloc to use cases
  BLoC -->|"signUpUseCase"| UCSignUp
  BLoC -->|"signInUseCase"| UcSignIn
  BLoC -->|"getCurrentUserUseCase"| UcGetCurrent

  %% Use cases to repository interface
  UCSignUp --> RepoInt
  UcSignIn --> RepoInt
  UcGetCurrent --> RepoInt

  %% Repository interface to implementation (bound in GetIt)
  RepoInt --> RepoImpl

  %% Implementation to data source
  RepoImpl -->|"remoteDatasource"| DS

  %% Data source to external services
  DS --> FA
  DS --> FS



## Auth Dependency Graph (with GetIt)

flowchart LR

  subgraph Presentation

    UI[SignUpScreen\n(Widget)]

    BLoC[AuthBloc]

  end

  subgraph Domain

    UCSignUp[SignUpWithEmail\n(Use case)]

    UcSignIn[SignInWithEmail\n(Use case)]

    UcGetCurrent[GetCurrentUser\n(Use case)]

    RepoInt[AuthRepository\n(abstract)]

  end

  subgraph Data

    RepoImpl[AuthRepositoriesImpl]

    DS[AuthRemoteDataSourceImpl]

  end

  subgraph External

    FA[FirebaseAuth.instance]

    FS[FirebaseFirestore.instance]

  end

  %% UI to Bloc

  UI -->|"[context.read](http://context.read)<AuthBloc>()\n.add(SignUpRequested)"| BLoC

  %% Bloc to use cases

  BLoC -->|"signUpUseCase"| UCSignUp

  BLoC -->|"signInUseCase"| UcSignIn

  BLoC -->|"getCurrentUserUseCase"| UcGetCurrent

  %% Use cases to repository interface

  UCSignUp --> RepoInt

  UcSignIn --> RepoInt

  UcGetCurrent --> RepoInt

  %% Repository interface to implementation (bound in GetIt)

  RepoInt --> RepoImpl

  %% Implementation to data source

  RepoImpl -->|"remoteDatasource"| DS

  %% Data source to external services

  DS --> FA

  DS --> FS

