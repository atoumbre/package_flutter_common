import 'package:flutter/material.dart';
import 'ShopModel.dart';

class Shops {
  static final List<ShopModel> shopWithCards = [
    const ShopModel(
      image: AssetImage('assets/images/deco/shop/1.jpg'),
      imageRight: false,
      title: 'Brown Woman bag',
      category: 'Jackets',
      price: '\$ 26.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 4
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/2.jpg'),
      imageRight: true,
      title: 'Green Man T-Shirt',
      category: 'Blazers',
      price: '\$ 36.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 6
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/3.jpg'),
      imageRight: false,
      title: 'Orange Football Man',
      category: 'Dresses',
      price: '\$ 65.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 1
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/4.jpg'),
      imageRight: true,
      title: 'Classic Brown Hat',
      category: 'Jumpsuits',
      price: '\$ 36.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 3
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/5.jpg'),
      imageRight: false,
      title: 'Blue Classic Shirt',
      category: 'Shirts',
      price: '\$ 22.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 2
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/6.jpg'),
      imageRight: true,
      title: 'Big Orange Backpack',
      category: 'Jeans',
      price: '\$ 46.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 7
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/7.jpg'),
      imageRight: false,
      title: 'Colorfufl Hiphop Hat',
      category: 'Skirts',
      price: '\$ 71.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 1
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/8.jpg'),
      imageRight: true,
      title: 'Blue Man Shorts',
      category: 'Jackets',
      price: '\$ 66.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 4
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/9.jpg'),
      imageRight: false,
      title: 'Red Woman Shoes',
      category: 'Blazers',
      price: '\$ 32.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 2
    ),

    const ShopModel(
      image: AssetImage('assets/images/deco/shop/10.jpg'),
      imageRight: true,
      title: 'Classic Green Bag',
      category: 'Dresses',
      price: '\$ 24.95',
      icon: Icons.shopping_basket,
      iconLabel: 'Add to Cart',
      quantity: 6
    ),
  ];
}