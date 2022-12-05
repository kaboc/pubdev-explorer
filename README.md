# pub.dev explorer

An app to explore and bookmark packages hosted on [pub.dev](https://pub.dev/).

[**Web App**](https://kaboc.github.io/pubdev-explorer/)

Packages are shown in descending order starting from the most recently updated one
on platforms other than the web.

<img src="https://user-images.githubusercontent.com/20254485/201298837-1500c704-c0c7-487e-8790-d304cd1a82a4.jpg" height="360">

## About this app

This is a sample app using the following packages created by the same author.

The app shows an example of how those packages are combined. The author himself, however, is
still examining and considering how they are made good use of to make the app more maintainable
and easier to evolve, so the current app design is not necessarily the best.

- [pot](https://pub.dev/packages/pot)
    - An easy and safe DI solution.
    - This is a little similar to providers of pkg:riverpod in that the instance is assigned
      to a global variable and can be accessed from anywhere, but different in that a Pot is
      just a service locator with only a few handy features but with no complexity.
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
$ dart pub run build_runner build -d
```

This project already contains generated code in `core/lib/generated/`, so if you haven't
changed anything, the above command is unnecessary.

### Mock data for the web

The pub.dev API is not available on the web unfortunately, so mock data preset in the app
is used instead. The data contains the packages by the author and 150 most popular packages.

### Mock data on other platforms 

To use the data on other platforms, pass the `USE_MOCK` environment variable as below:

```dart
flutter run --dart-define=USE_MOCK=true
```

