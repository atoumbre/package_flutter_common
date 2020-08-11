import 'package:flutter/material.dart';

class ImageCardModel {
  final ImageProvider image;
  final String title;
  final String description;
  final String date;
  final int likes;

  const ImageCardModel({
    this.image,
    this.title,
    this.description,
    this.date,
    this.likes,
  });
}