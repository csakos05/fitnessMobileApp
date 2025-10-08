import 'package:hive_ce/hive.dart';

enum SubscriptionType { free, premium, enterprise }

enum Gender { male, female }

class UserProfileModel extends HiveObject {
  final String userId;
  final String userEmail;
  final DateTime createdAt;
  final SubscriptionType subscriptionType;
  final double? weight;
  final double? height;
  final int? age;
  final Gender? gender;

  UserProfileModel({
    required this.userId,
    required this.userEmail,
    required this.createdAt,
    required this.subscriptionType,
    this.weight,
    this.height,
    this.age,
    this.gender,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      userEmail: json['userEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      subscriptionType: SubscriptionType.values.firstWhere(
        (e) =>
            e.toString().split('.').last ==
            (json['subscriptionType'] ?? 'free'),
        orElse: () => SubscriptionType.free,
      ),
      weight: (json['weight'] != null)
          ? (json['weight'] as double).toDouble()
          : null,
      height: (json['height'] != null)
          ? (json['height'] as double).toDouble()
          : null,
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'createdAt': createdAt.toIso8601String(),
      'subscriptionType': subscriptionType.toString().split('.').last,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender.toString().split('.').last,
    };
  }
}
