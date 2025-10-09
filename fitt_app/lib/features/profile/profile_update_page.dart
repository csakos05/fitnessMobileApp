import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/features/profile/logic/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileUpdatePageProvider extends StatelessWidget {
  const ProfileUpdatePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<ProfileBloc>(),
      child: const ProfileUpdatePage(),
    );
  }
}


class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers a szöveges mezőkhöz
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Gender? _selectedGender;
  UserProfileModel? _currentProfile;

  @override
  void initState() {
    super.initState();
    // Lekérjük a mentett profilt
    context.read<ProfileBloc>().add(ProfileRequestEvent());
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _populateFields(UserProfileModel profile) {
    if (_currentProfile != null) return; // Csak egyszer töltjük fel

    _currentProfile = profile;
    _weightController.text = profile.weight?.toString() ?? '';
    _heightController.text = profile.height?.toString() ?? '';
    _ageController.text = profile.age?.toString() ?? '';
    _selectedGender = profile.gender;
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_currentProfile == null) return;

      final updatedProfile = UserProfileModel(
        userId: _currentProfile!.userId,
        userEmail: _currentProfile!.userEmail,
        createdAt: _currentProfile!.createdAt,
        subscriptionType: _currentProfile!.subscriptionType,
        profileCompleted: true,
        weight: double.tryParse(_weightController.text),
        height: double.tryParse(_heightController.text),
        age: int.tryParse(_ageController.text),
        gender: _selectedGender,
      );

      context.read<ProfileBloc>().add(ProfileUpdateEvent(profile: updatedProfile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
          Navigator.of(context).pop();
        } else if (state is ProfileUpdateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed: ${state.error}')));
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ProfileLoadSuccess) {
          _populateFields(state.profile);
          return _buildForm(context);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Gender>(
              initialValue: _selectedGender,
              decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
              items: Gender.values.map((Gender gender) {
                return DropdownMenuItem<Gender>(value: gender, child: Text(gender.name));
              }).toList(),
              onChanged: (Gender? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select your gender';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
