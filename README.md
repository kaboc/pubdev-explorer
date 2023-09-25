# pub.dev explorer

An app to explore and bookmark packages hosted on [pub.dev](https://pub.dev/).

[**Web App**](https://kaboc.github.io/pubdev-explorer/)

Packages are shown in descending order starting from the most recently updated one
on platforms other than the web.

<img src="https://github.com/kaboc/pubdev-explorer/assets/20254485/28595978-bd11-4dac-81eb-90a1b5d47487" width="240"> <img src="https://github.com/kaboc/pubdev-explorer/assets/20254485/56149003-2127-405d-9ee9-0f588308caee" width="240"> <img src="https://github.com/kaboc/pubdev-explorer/assets/20254485/9c38a02f-42ad-446e-bf1b-d1e90d6f7627" width="240">

## About this app

This is a sample app using the following packages created by the same author.

The app shows an example of how those packages are combined. The author himself, however, is
still examining and considering how they are made good use of to make the app more maintainable
and easier to evolve, so the current app design is not necessarily the best.

- [pottery](https://pub.dev/packages/pottery)
    - A utility widget for [pot](https://pub.dev/packages/pot).
    - Pot is an easy and safe DI solution. It is a little similar to providers of pkg:riverpod
      in that the instance is assigned to a global variable and can be accessed from anywhere,
      but different in that Pot is just a service locator with only a few handy features and
      no complexity.
    - Pottery limits the scope of pots in the widget tree, making it possible to use pots
      in a similar manner to using MultiProvider of pkg:provider.
- [grab](https://pub.dev/packages/grab)
    - A package to control rebuilds of a widget based on updates of a `Listenable` such as
      `ChangeNotifier` and `ValueNotifier`.
    - Usage is similar to `watch()` and `select()` of pkg:provider used on `BuildContext`,
      but Grab does not depend on the widget tree.
    - Take it as an extension method version of `ValueListenableBuilder` with filtering.
- [async_phase_notifier](https://github.com/kaboc/async-phase-notifier)
    - A variant of `ValueNotifier` very similar to AsyncNotifier of pkg:riverpod.
    - `AsyncPhase` has one more phase "initial", which AsyncValue of Riverpod does not have.
    - `AsyncPhaseNotifier` provides a way to listen to errors, and there is also `AsyncErrorListener`
      that is a widget with an error handler, convenient for imperatively showing a message
      (e.g. showing a SnackBar) or for logging. 
- [custom_text](https://pub.dev/packages/custom_text)
    - A highly customisable text widget that decorates strings and enables tap / long-press /
      hover actions flexibly based on regular expression patterns.
    - Such decorations and actions are available even in text editing with `CustomTextEditingController`,
      although the controller is not used in this app.

## How to run

Just run `flutter run` in the `app/` directory, with additional options if necessary.

## Code generation

This app uses [json_serializable](https://pub.dev/packages/json_serializable) and
[drift](https://pub.dev/packages/drift), which require code generation. If you change
the classes from which code is generated, run the command below in the `core/` directory
to generate updated code.

```shell
$ dart run build_runner build -d
```

This project already contains generated code in `core/lib/src/generated/`, so if you haven't
changed anything, the above command is unnecessary.

### Mock data for the web

The pub.dev API is not available on the web unfortunately, so mock data preset in the app
is used instead. The data contains the packages by the author and 150 most popular packages.

### Mock data on other platforms 

To use the data on other platforms, pass the `USE_MOCK` environment variable as below:

```dart
flutter run --dart-define=USE_MOCK=true
```
