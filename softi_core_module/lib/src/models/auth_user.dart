import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../gen/auth_user.freezed.dart';

@freezed
abstract class AuthUser implements _$AuthUser {
  const AuthUser._();

  const factory AuthUser({
    final String uid,

    // Profile infos : Editable by the user
    final String displayName,
    final String photoUrl,
    final String email,
    final String phoneNumber,

    // Account infos : Not editable from frontend
    final bool isAnonymous,
    final bool isEmailVerified,
    final DateTime creationTime,
    final DateTime lastSignInTime,
    final String providerId,
    //
  }) = _AuthUser;
}
