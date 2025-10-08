import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/login_bloc.dart';
import 'login_page.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Scaffold'),
        ),
        body: LoginPage(),
      ),
    );
  }
}
