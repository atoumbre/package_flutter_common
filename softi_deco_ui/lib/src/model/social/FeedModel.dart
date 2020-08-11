import 'package:flutter/material.dart';

class FeedModel {
  final String username;
  final ImageProvider userImage;
  final String date;
  final ImageProvider image;
  final bool isLiked;
  final int likes;
  final int comments;
  final String title;
  final String description;

  const FeedModel({
    this.username,
    this.userImage,
    this.date,
    this.image,
    this.isLiked,
    this.likes,
    this.comments,
    this.title,
    this.description
  });
}