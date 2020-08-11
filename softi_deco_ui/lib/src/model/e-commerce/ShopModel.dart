import 'package:flutter/material.dart';

class ShopModel {
  final ImageProvider image;
  final bool imageRight;
  final String title;
  final String category;
  final String price;
  final IconData icon;
  final String iconLabel;
  final int quantity;

  const ShopModel({
    this.image,
    this.imageRight,
    this.title,
    this.category,
    this.price,
    this.icon,
    this.iconLabel,
    this.quantity
  });
}