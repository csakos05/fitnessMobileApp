import 'package:fitt_app/features/appstart/logic/app_start_bloc.dart';
import 'package:fitt_app/features/appstart/widgets/app_start_loading_screen.dart';
import 'package:fitt_app/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'infrastructure/localization/app_localizations.dart';
import 'infrastructure/localization/app_localizations_delegate.dart';
import 'infrastructure/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ioc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageService().initialize();
  registerTypesToIoCBeforeRunApp();
  runApp(const MyAppBlocProvider());
  registerBlocsAfterRunApp();
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

      },
      builder: (context, state) {
        if (state is AppStartLoading || state is AppStartInitial) {
          return const AppStartLoadingScreen();
        }
        else if(state is AppStartSuccess){
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
        } else if (state is AppStartError){
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error during app initialization')),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: SizedBox(),
            ),
          );
        }
      },
    );
  }
}