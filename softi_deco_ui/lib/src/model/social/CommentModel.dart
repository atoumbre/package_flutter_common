import 'package:flutter/material.dart';

class CommentModel {
  final String id;
  final String date;
  final String text;
  final ImageProvider userImage;
  final String username;

  const CommentModel({
    this.id,
    this.date,
    this.text,
    this.userImage,
    this.username
  });
}