import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nickName = '';
  int age = 0;


  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    final AppNavigationService navigationService = AppNavigationService.of(
      context,
    );
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileCreatedSuccess) {
          navigationService.goToTest();
        }
      },
      builder:  (context, state) {
        if(state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ProfileLoadSuccess) {
          return buildBody(context, state.profile);
        }
      return const SizedBox();
      }
    );
  }

  Widget buildBody(BuildContext context, UserProfileModel profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Login Page'),
        Text('Email: ${profile.userEmail}'),
        Text('User ID: ${profile.userId}'),
        Text('Current Nickname: ${profile.createdAt}'),
        Text('Current Age: ${profile.age}'),
        Text('Subscription: ${profile.subscriptionType.name}'),
        Text('Subscription: ${profile.gender?.name ?? 'Not specified'}'),
        ElevatedButton(
          onPressed: () {
            context.read<ProfileBloc>().add(LogoutEvent());
          },
          child: Text('logout'),
        ),
      ],
    );
  }
}
