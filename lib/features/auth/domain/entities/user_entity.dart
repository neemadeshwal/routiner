import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool biometricEnabled;

  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isEmailVerified = false,
    required this.createdAt,
    this.lastLoginAt,
    this.biometricEnabled = false,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    phoneNumber,
    isEmailVerified,
    createdAt,
    lastLoginAt,
    biometricEnabled,
  ];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? biometricEnabled,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    );
  }
}
