import 'package:fitt_app/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/profile_bloc.dart';


class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfilePage(),
    );
  }
}
