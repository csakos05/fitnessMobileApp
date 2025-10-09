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
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null &&
            AppLocalizations.supportedLocales.contains(locale.languageCode)) {
          return locale;
        }
        return const Locale(Locales.en);
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (context, router) {
        return BlocBuilder<AppStartBloc, AppStartState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildScreen(state, router),
            );
          },
        );
      },
    );
  }

  Widget _buildScreen(AppStartState state, Widget? router) {
    if (state is AppStartSuccess) {
      // A Key biztosítja, hogy az AnimatedSwitcher tudja, hogy új widgetről van szó.
      return SizedBox(key: const ValueKey('App'), child: router);
    }
    if (state is AppStartError) {
      return const MaterialApp( // Egyszerűsített hibaképernyő
        key: ValueKey('Error'),
        home: Scaffold(
          body: Center(child: Text('Error during app initialization')),
        ),
      );
    }
    return const AppStartLoadingScreen(key: ValueKey('Loading'));
  }
}