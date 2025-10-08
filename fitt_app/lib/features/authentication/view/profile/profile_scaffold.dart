import 'package:fitt_app/features/authentication/view/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/profile_bloc.dart';

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Scaffold'),
        ),
        body: ProfilePage(),
      ),
    );
  }
}
