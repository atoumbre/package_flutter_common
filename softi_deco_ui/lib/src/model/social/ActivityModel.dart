import 'package:flutter/material.dart';

class ActivityModel {
  final String username;
  final ImageProvider userImage;
  final String action;
  final ImageProvider image;
  final String date;

  const ActivityModel({
    this.username,
    this.userImage,
    this.action,
    this.image,
    this.date
  });
}