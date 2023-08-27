# flutter_fm


### バージョン
1. Flutter channel: `stable`
2. Flutter version: ![Flutter Version](https://img.shields.io/badge/Flutter-version:2.8.1-green)
3. Java version: ![Java Version](https://img.shields.io/badge/Java-version%3A11-yellowgreen)

### FlutterSDKを最新バージョンにアップグレードする方法
1. ターミナルを開きます。
2. `flutter channel stable`コマンドを実行します。
3. `flutter upgrade`コマンドを実行します。

-> 最新のFlutterSDKバージョンを更新するため、Android StudioまたはVS codeを再起動します。

- [Reference] (https://docs.flutter.dev/development/tools/sdk/upgrading)

# はじめに

このプロジェクトは、Flutterアプリの開始点です。

# I. ビルド方法

## 1.文字列の生成

1. gitbashを開きます。

2. `sh ./bin/translate.sh`コマンドを実行します。

### 2.1.Android向けビルド方法

1. Android Studioを開いて、プロジェクト又はファイルを選択します。
2. flutter-laboプロジェクトを開きます。
3. ターミナルを開きます。
4. `flutter pub get`を実行します。
5. `flutter run`を実行します。
> - 複数の端末を接続した場合、`adb devices` 及び `flutter run -d <deviceId>`を実行します。

### 2.2.iOS (Xcode v12.5)向けビルド方法
1. Xcodeを開いて、一つのプロジェクト又はファイルを選択します。
2. Project FlutterにてIOSフォルダーを開きます。
3. ターミナルを開いて、IOSフォルダーに移動します。
4. `flutter build ios`を実行します。
5. Xcodeを開いてBuildをクリック 
> - プロセスが完了するまで待つ
> - 初回で間違って実行する場合は、ビルドフォルダをクリーンアップしてください。
> - In Xcodeにて: `上部のナビゲーションでProductをクリック` -> `Clean Build Folder`
> - After Build Again

## 2.システムアーキテクチャー (Clean Architecture)
Clean Architectureに基づいて構築されたこのプロジェクトには、以下の5つのレイヤーが含まれています。
- Application
- Data
- DI
- Domain
- Presentation
- State-Management

## 3.システムアーキテクチャーの詳細

### A. Clean Architectureの定義

![IMAGE_DESCRIPTION](assets/CleanArchitecture.jpg)

### 3.1.データ
- outermostレイヤーのデータモジュールはデータの取得を担当します。


### データのコンテンツ

### Repositories
-  Dataレイヤーのすべてのリポジトリは、Domainレイヤーからのリポジトリを実装する必要があります。
-  データベースまたは他のメソッドからデータを取得します。
-  API呼び出しと高レベルのデータを担当します。


### Models
- メンバーを追加したEntitiesのExtensionsは、プラットフォームに依存する場合があります。

### Domain

- ドメインモジュールは、アプリのビジネスロジックを定義します。開発プラットフォームから独立したモジュール、すなわち純粋にプログラミング言語で記述され、プラットフォームの要素が含まれていないモジュールです。その理由は、ドメインは実装の詳細ではなく、アプリケーションのビジネスロジックのみに関係する必要があるためです。 また、問題が発生した場合に各プラットフォーム間で簡単に移行することもできます。

### 3.2.ドメインのコンテンツ

#### 3.2.1.Entities
- 企業全体のビジネスのルール。 </br>
- メソッドを含めるクラスで構成されます。 </br>
- アプリのビジネス対象です。 </br>
- アプリケーション全体で使用されます。 </br>
- アプリケーション内の何かが変更されたときに変更される可能性が最も低いです。 </br>

#### 3.2.2.Usecases

-  アプリケーション固有のビジネスルールです。 </br>
-  アプリケーションのすべてのユースケースをカプセル化します。 </br>
-  アプリ全体でデータの流れを調整します。 </br>
-  UIの変更による影響は一切受けません。 </br>
-  アプリケーションの機能やフローが変更されると変更される場合があります。 </br>

#### 3.2.3.Repositories
-  アウターレイヤーの期待される機能を定義する抽象クラスです。</br>
-  アウターレイヤーを認識せず、単に期待される機能を定義します。 </br>
-  例えば、Login usecaseでは、ログイン機能を備えたリポジトリが必要です。 </br>
-  アウターレイヤーからユースケースに渡されます。 </br>
-  ドメインはinner-mostレイヤーを表します。したがって、これはアーキテクチャの中で最も抽象的なレイヤーです。 </br>

#### 3.2.4.Presentation
-  ページのUIのみを表します。

### 3.3.DI
- 簡単にモックできるように,REST APIクライアントやデータベースなどのサービスオブジェクトにアクセスします。
- Accessing View/AppModels/Managers/BLoCs from Flutter Views

### 3.4.Shared
- 共通の機能を提供します。
- UIコンポーネントを宣言・ビルドします。
- 共通の検証の値を提供します。
- 複数の言語の翻訳します。


### 3.5.コンポーネントモジュール(widgets、utils、resoures、configsなど)
### 3.6.コアモジュール (helpers、utils、validationなど)

**ライブラリの要件**

| Library                                               | Usability             |                                                                                    Star                                                                                     |
| :---------------------------------------------------- | :-------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| [dartz](https://pub.dev/packages/dartz)               | Data Handling         |             [![Github Stars](https://img.shields.io/github/stars/spebbe/dartz?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/spebbe/dartz)             |
| [dio](https://pub.dev/packages/dio)                   | Http client           |          [![Github Stars](https://img.shields.io/github/stars/flutterchina/dio?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/bloc)           |
| [equatable](https://pub.dev/packages/equatable)       | Getting data abstract |       [![Github Stars](https://img.shields.io/github/stars/felangel/equatable?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/equatable)       |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management      |          [![Github Stars](https://img.shields.io/github/stars/felangel/bloc.svg?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/felangel/bloc)          |
| [get_it](https://pub.dev/packages/get_it)             | Component Injector    |  [![Github Stars](https://img.shields.io/github/stars/fluttercommunity/get_it?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/fluttercommunity/get_it)  |
| [pedantic](https://pub.dev/packages/pedantic)         | Code formatting       |          [![Github Stars](https://img.shields.io/github/stars/google/pedantic?style=flat&logo=github&colorB=blue&label=stars)](https://github.com/google/pedantic)          |
| [auto_route](https://pub.dev/packages/auto_route)     | Navigation            | [![Github Stars](https://img.shields.io/github/stars/Milad-Akarie/auto_route_library?style=flat&logo=github&colorB=green&label=stars)](https://pub.dev/packages/auto_route) |

# II.フィーチャー
| Feature                | Version |
| ---------------------- | :-----: |
| Login                  |   1.0   |
| Manage employee        |   1.0   |
| Create/delete employee |   1.0   |

### III.参照リンク

- [Guide to app architecture] (https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
