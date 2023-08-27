# flutter_fm


### Version
1. Flutter channel: `stable`
2. Flutter version: ![Flutter Version](https://img.shields.io/badge/Flutter-version:2.8.1-green)
3. Java version: ![Java Version](https://img.shields.io/badge/Java-version%3A11-yellowgreen)

### How to upgrade flutter SDK to latest version.
1. Open terminal
2. Run command `flutter channel stable`
3. Run command `flutter upgrade`

-> Restart Android Studio or VS code to update latest flutter SDK version

- [Reference] (https://docs.flutter.dev/development/tools/sdk/upgrading)

# Getting Started

This project is a starting point for a Flutter application.

# I. How to build

## 1.Generate strings:

1. Open gitbash.

2. run command `sh ./bin/translate.sh`

### 2.1.How to build for Android

1. Open Android Studio and choose Open a project or file
2. Open project flutter-labo
3. Open Terminal
4. Run `flutter pub get`
5. Run `flutter run`
> - If more than one device connected, run `adb devices` and `flutter run -d <deviceId>`

### 2.2.How to build iOS (Xcode v12.5)
1. Open Xcode and choose Open a project or file
2. Open folder IOS on Project Flutter
3. Open Terminal and go to folder IOS
4. Run `flutter build ios`
5. On Xcode Click Build 
> - Wait until the process is complete
> - If you run it wrong for the first time, please clean build folder
> - In Xcode: `Click Product` -> `Clean Build Folder`
> - After Build Again

## 2.System architecture (Clean Architecture)
This project build on Clean Architecture includes 5 layers:
- Application
- Data
- DI
- Domain
- Presentation
- State-Management

## 3.Details of System Architecture

### A. Clean Architecture Definition

![IMAGE_DESCRIPTION](assets/CleanArchitecture.jpg)

### 3.1.Data
- The Data module, which is a part of the outermost layer, is responsible for data retrieval

### Contents of Data
### * Repositories
-  Every Repository should implement Repository from the Domain layer.
-  Retrieve data from databases or other methods.
-  Responsible for any API calls and high-level data

### * Models
- Extensions of Entities with the addition of extra members that might be platform-dependent.

### * Domain
- The Domain module defines the business logic of the application. It is a module that is independent from the development platform i.e. it is written purely in the programming language and does not contain any elements from the platform. The reason for that is that Domain should only be concerned with the business logic of the application, not with the implementation details. This also allows for easy migration between platforms, should any issues arise.

### 3.2.Contents of Domain
#### 3.2.1.Entities
-  Enterprise-wide business rules </br>
-  Made up of classes that can contain methods </br>
-  Business objects of the application </br>
-  Used application-wide </br>
-  Least likely to change when something in the application changes </br>

#### 3.2.2.Usecases

-  Application-specific business rules </br>
-  Encapsulate all the usecases of the application </br>
-  Orchestrate the flow of data throughout the app </br>
-  Should not be affected by any UI changes whatsoever </br>
-  Might change if the functionality and flow of application change </br>

#### 3.2.3.Repositories
-  Abstract classes that define the expected functionality of outer layers </br>
-  Are not aware of outer layers, simply define expected functionality </br>
-  E.g. The Login usecase expects a Repository that has login functionality </br>
-  Passed to Usecases from outer layers </br>
-  Domain represents the inner-most layer. Therefore, it the most abstract layer in the architecture. </br>

#### 3.2.4.Presentation
-  Represents only the UI of the page

### 3.3.DI
- Accessing service objects like REST API clients or databases so that they easily can be mocked.
- Accessing View/AppModels/Managers/BLoCs from Flutter Views

### 3.4.Shared
- Provice the functions common
- Declaring and building UI components
- Provide values of validation common
- Translations for many languages


### 3.5.Components modules  (widgets, utils, resoures, configs,...)
### 3.6.Cores modules (helpers, utils, validation,...)

**Library Requirement**

| Library                                               | Usability             |                                                                                    Star                                                                                     |
| :---------------------------------------------------- | :-------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| [dartz](https://pub.dev/packages/dartz)               | Data Handling         |             [![Github Stars](https://img.shields.io/github/stars/spebbe/dartz?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/spebbe/dartz)             |
| [dio](https://pub.dev/packages/dio)                   | Http client           |          [![Github Stars](https://img.shields.io/github/stars/flutterchina/dio?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/bloc)           |
| [equatable](https://pub.dev/packages/equatable)       | Getting data abstract |       [![Github Stars](https://img.shields.io/github/stars/felangel/equatable?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/equatable)       |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management      |          [![Github Stars](https://img.shields.io/github/stars/felangel/bloc.svg?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/bloc)          |
| [get_it](https://pub.dev/packages/get_it)             | Component Injector    |  [![Github Stars](https://img.shields.io/github/stars/fluttercommunity/get_it?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/fluttercommunity/get_it)  |
| [pedantic](https://pub.dev/packages/pedantic)         | Code formatting       |          [![Github Stars](https://img.shields.io/github/stars/google/pedantic?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/google/pedantic)          |
| [auto_route](https://pub.dev/packages/auto_route)     | Navigation            | [![Github Stars](https://img.shields.io/github/stars/Milad-Akarie/auto_route_library?style=flat&logo=github&colorB=green&label=stars)](https://pub.dev/packages/auto_route) |

# II.Feature
| Feature                | Verison |
| ---------------------- | :-----: |
| Login                  |   1.0   |
| Manage employee        |   1.0   |
| Create/delete employee |   1.0   |

### III.Link reference

- [Guide to app architecture] (https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

