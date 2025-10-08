import 'package:fitt_app/features/appstart/logic/app_start_bloc.dart';
import 'package:fitt_app/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'features/authentication/domain/service/auth_service.dart';
import 'firebase_options.dart';
import 'infrastructure/localization/app_localizations.dart';
import 'infrastructure/localization/app_localizations_delegate.dart';
import 'infrastructure/routes/routes.dart';
import 'package:fitt_app/index.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ioc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageService().initialize();
  registerTypesToIoCBeforeRunApp();
  runApp(const MyAppBlocProvider());
}

class MyAppBlocProvider extends StatelessWidget {
  const MyAppBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppStartBloc())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AppStartBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppStartBloc, AppStartState>(
      listener: (context, state) {
        if (state is AppStartError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error:')));
        }
      },
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: createRouterConfiguration(),
          title: 'Flutter Demo',
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale(Locales.en), Locale(Locales.hu)],
          // This determines which locale to use if the device locale isn't supported
          localeResolutionCallback: (locale, supportedLocales) {
            // Default to English if device locale isn't supported
            if (locale != null &&
                AppLocalizations.supportedLocales.contains(
                  locale.languageCode,
                )) {
              return locale;
            }
            return const Locale(Locales.en); // Return English as fallback
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(appLocalizations.resolve('Test')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                final AppNavigationService navigationService =
                    AppNavigationService.of(context);
                navigationService.goToTest();
              },
              child: Text('Click me'),
            ),
            ElevatedButton(
              onPressed: () {
                final AppNavigationService navigationService =
                    AppNavigationService.of(context);
                navigationService.goToLogin();
              },
              child: Text('goToLogin'),
            ),
            ElevatedButton(
              onPressed: () {
                final AppNavigationService navigationService =
                    AppNavigationService.of(context);
                navigationService.goToProfile();
              },
              child: Text('goToprofile'),
            ),
            ElevatedButton(
              onPressed: () {
                final AuthService authService =
                    GetIt.instance<AuthService>();
                authService.signOut();
              },
              child: Text('logout'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
