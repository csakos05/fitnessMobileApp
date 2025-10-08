import 'package:fitt_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String nickName = '';
  int age = 0;

  @override
  Widget build(BuildContext context) {
    final AppNavigationService navigationService = AppNavigationService.of(
      context,
    );
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          navigationService.goToTest();
        }
      },
      child: Column(
        children: [
          Text('Login Page'),
          TextField(
            decoration: const InputDecoration(labelText: 'Nickname'),
            onChanged: (value) {
              // Update nickname state
              setState(() {
                nickName = value; // Uncomment if nickName is made mutable
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Update age state
              setState(() {
                age =
                    int.tryParse(value) ??
                    0; // Uncomment if age is made mutable
              });
            },
          ),

          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                LoginRequested(nickname: nickName, age: age),
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
