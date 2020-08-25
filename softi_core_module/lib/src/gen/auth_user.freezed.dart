// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of '../models/auth_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$AuthUserTearOff {
  const _$AuthUserTearOff();

  _AuthUser call(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      bool isAnonymous,
      bool isEmailVerified,
      DateTime creationTime,
      DateTime lastSignInTime,
      String providerId}) {
    return _AuthUser(
      uid: uid,
      displayName: displayName,
      photoUrl: photoUrl,
      email: email,
      phoneNumber: phoneNumber,
      isAnonymous: isAnonymous,
      isEmailVerified: isEmailVerified,
      creationTime: creationTime,
      lastSignInTime: lastSignInTime,
      providerId: providerId,
    );
  }
}

// ignore: unused_element
const $AuthUser = _$AuthUserTearOff();

mixin _$AuthUser {
  String get uid;
  String get displayName;
  String get photoUrl;
  String get email;
  String get phoneNumber;
  bool get isAnonymous;
  bool get isEmailVerified;
  DateTime get creationTime;
  DateTime get lastSignInTime;
  String get providerId;

  $AuthUserCopyWith<AuthUser> get copyWith;
}

abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) = _$AuthUserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      bool isAnonymous,
      bool isEmailVerified,
      DateTime creationTime,
      DateTime lastSignInTime,
      String providerId});
}

class _$AuthUserCopyWithImpl<$Res> implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  final AuthUser _value;
  // ignore: unused_field
  final $Res Function(AuthUser) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object displayName = freezed,
    Object photoUrl = freezed,
    Object email = freezed,
    Object phoneNumber = freezed,
    Object isAnonymous = freezed,
    Object isEmailVerified = freezed,
    Object creationTime = freezed,
    Object lastSignInTime = freezed,
    Object providerId = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      displayName: displayName == freezed ? _value.displayName : displayName as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      email: email == freezed ? _value.email : email as String,
      phoneNumber: phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      isAnonymous: isAnonymous == freezed ? _value.isAnonymous : isAnonymous as bool,
      isEmailVerified: isEmailVerified == freezed ? _value.isEmailVerified : isEmailVerified as bool,
      creationTime: creationTime == freezed ? _value.creationTime : creationTime as DateTime,
      lastSignInTime: lastSignInTime == freezed ? _value.lastSignInTime : lastSignInTime as DateTime,
      providerId: providerId == freezed ? _value.providerId : providerId as String,
    ));
  }
}

abstract class _$AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$AuthUserCopyWith(_AuthUser value, $Res Function(_AuthUser) then) = __$AuthUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      bool isAnonymous,
      bool isEmailVerified,
      DateTime creationTime,
      DateTime lastSignInTime,
      String providerId});
}

class __$AuthUserCopyWithImpl<$Res> extends _$AuthUserCopyWithImpl<$Res> implements _$AuthUserCopyWith<$Res> {
  __$AuthUserCopyWithImpl(_AuthUser _value, $Res Function(_AuthUser) _then)
      : super(_value, (v) => _then(v as _AuthUser));

  @override
  _AuthUser get _value => super._value as _AuthUser;

  @override
  $Res call({
    Object uid = freezed,
    Object displayName = freezed,
    Object photoUrl = freezed,
    Object email = freezed,
    Object phoneNumber = freezed,
    Object isAnonymous = freezed,
    Object isEmailVerified = freezed,
    Object creationTime = freezed,
    Object lastSignInTime = freezed,
    Object providerId = freezed,
  }) {
    return _then(_AuthUser(
      uid: uid == freezed ? _value.uid : uid as String,
      displayName: displayName == freezed ? _value.displayName : displayName as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      email: email == freezed ? _value.email : email as String,
      phoneNumber: phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      isAnonymous: isAnonymous == freezed ? _value.isAnonymous : isAnonymous as bool,
      isEmailVerified: isEmailVerified == freezed ? _value.isEmailVerified : isEmailVerified as bool,
      creationTime: creationTime == freezed ? _value.creationTime : creationTime as DateTime,
      lastSignInTime: lastSignInTime == freezed ? _value.lastSignInTime : lastSignInTime as DateTime,
      providerId: providerId == freezed ? _value.providerId : providerId as String,
    ));
  }
}

class _$_AuthUser extends _AuthUser with DiagnosticableTreeMixin {
  const _$_AuthUser(
      {this.uid,
      this.displayName,
      this.photoUrl,
      this.email,
      this.phoneNumber,
      this.isAnonymous,
      this.isEmailVerified,
      this.creationTime,
      this.lastSignInTime,
      this.providerId})
      : super._();

  @override
  final String uid;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final bool isAnonymous;
  @override
  final bool isEmailVerified;
  @override
  final DateTime creationTime;
  @override
  final DateTime lastSignInTime;
  @override
  final String providerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthUser(uid: $uid, displayName: $displayName, photoUrl: $photoUrl, email: $email, phoneNumber: $phoneNumber, isAnonymous: $isAnonymous, isEmailVerified: $isEmailVerified, creationTime: $creationTime, lastSignInTime: $lastSignInTime, providerId: $providerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthUser'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('photoUrl', photoUrl))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('isAnonymous', isAnonymous))
      ..add(DiagnosticsProperty('isEmailVerified', isEmailVerified))
      ..add(DiagnosticsProperty('creationTime', creationTime))
      ..add(DiagnosticsProperty('lastSignInTime', lastSignInTime))
      ..add(DiagnosticsProperty('providerId', providerId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthUser &&
            (identical(other.uid, uid) || const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality().equals(other.displayName, displayName)) &&
            (identical(other.photoUrl, photoUrl) || const DeepCollectionEquality().equals(other.photoUrl, photoUrl)) &&
            (identical(other.email, email) || const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.isAnonymous, isAnonymous) ||
                const DeepCollectionEquality().equals(other.isAnonymous, isAnonymous)) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                const DeepCollectionEquality().equals(other.isEmailVerified, isEmailVerified)) &&
            (identical(other.creationTime, creationTime) ||
                const DeepCollectionEquality().equals(other.creationTime, creationTime)) &&
            (identical(other.lastSignInTime, lastSignInTime) ||
                const DeepCollectionEquality().equals(other.lastSignInTime, lastSignInTime)) &&
            (identical(other.providerId, providerId) ||
                const DeepCollectionEquality().equals(other.providerId, providerId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(photoUrl) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(isAnonymous) ^
      const DeepCollectionEquality().hash(isEmailVerified) ^
      const DeepCollectionEquality().hash(creationTime) ^
      const DeepCollectionEquality().hash(lastSignInTime) ^
      const DeepCollectionEquality().hash(providerId);

  @override
  _$AuthUserCopyWith<_AuthUser> get copyWith => __$AuthUserCopyWithImpl<_AuthUser>(this, _$identity);
}

abstract class _AuthUser extends AuthUser {
  const _AuthUser._() : super._();
  const factory _AuthUser(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      bool isAnonymous,
      bool isEmailVerified,
      DateTime creationTime,
      DateTime lastSignInTime,
      String providerId}) = _$_AuthUser;

  @override
  String get uid;
  @override
  String get displayName;
  @override
  String get photoUrl;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  bool get isAnonymous;
  @override
  bool get isEmailVerified;
  @override
  DateTime get creationTime;
  @override
  DateTime get lastSignInTime;
  @override
  String get providerId;
  @override
  _$AuthUserCopyWith<_AuthUser> get copyWith;
}
