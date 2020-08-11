import 'package:flutter/material.dart';
import 'FeedModel.dart';
import 'ImageCardModel.dart';
import 'ActivityModel.dart';

class Feeds {
  static final List<FeedModel> feed = [
    const FeedModel(
      username: 'John Perkins',
      userImage: AssetImage('assets/images/deco/avatar/1.jpg'),
      date: 'March 14, 2019',
      image: AssetImage('assets/images/deco/content/1.jpg'),
      isLiked: true,
      likes: 250,
      comments: 569,
      title: 'Pink Classic Chair',
      description: 'Shop Wayfair for the best dusty pink chair. Enjoy Free Shipping on most stuff, even big stuff.',
    ),

    const FeedModel(
      username: 'Dennis Wells',
      userImage: AssetImage('assets/images/deco/avatar/2.jpg'),
      date: 'March 19, 2019',
      image: AssetImage('assets/images/deco/content/2.jpg'),
      isLiked: false,
      likes: 156,
      comments: 25,
      title: 'Deep Sea Jellyfish',
      description: 'Jellyfish or sea jelly is the informal common name given to the medusa-phase of certain gelatinous.',
    ),

    const FeedModel(
      username: 'Samantha Bates',
      userImage: AssetImage('assets/images/deco/avatar/3.jpg'),
      date: 'April 27, 2019',
      image: AssetImage('assets/images/deco/content/3.jpg'),
      isLiked: true,
      likes: 56,
      comments: 32,
      title: 'Floating Pink Cherry',
      description: 'A cherry is the fruit of many plants of the genus Prunus, and is a fleshy drupe.',
    ),

    const FeedModel(
      username: 'Lawrence Murray',
      userImage: AssetImage('assets/images/deco/avatar/4.jpg'),
      date: 'June 15, 2019',
      image: AssetImage('assets/images/deco/content/4.jpg'),
      isLiked: false,
      likes: 98,
      comments: 1,
      title: 'Green Leaf Pattern',
      description: 'A green leaf pattern is a discernible regularity in the world or in a manmade design.',
    ),

    const FeedModel(
      username: 'Teresa Olsen',
      userImage: AssetImage('assets/images/deco/avatar/5.jpg'),
      date: 'August 25, 2019',
      image: AssetImage('assets/images/deco/content/5.jpg'),
      isLiked: true,
      likes: 45,
      comments: 96,
      title: 'Trees and Blue River',
      description: 'Along the Blue River can be found many miles of hiking, biking, and walking trails.',
    ),

    const FeedModel(
      username: 'Barbara Morales',
      userImage: AssetImage('assets/images/deco/avatar/6.jpg'),
      date: 'April 22, 2019',
      image: AssetImage('assets/images/deco/content/6.jpg'),
      isLiked: false,
      likes: 40,
      comments: 6,
      title: 'Pink Jellyfish in Sea',
      description: 'Jellyfish are eaten by humans in certain cultures, being considered a delicacy in some countries.',
    ),

    const FeedModel(
      username: 'Victoria Gilbert',
      userImage: AssetImage('assets/images/deco/avatar/7.jpg'),
      date: 'July 14, 2019',
      image: AssetImage('assets/images/deco/content/7.jpg'),
      isLiked: true,
      likes: 40,
      comments: 6,
      title: 'Orange Stairs Building',
      description: 'The vertical portion between each tread on the stair. This may be missing for an "open" stair effect.',
    ),
  ];


  static final List<ImageCardModel> imageCards = [
    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/1.jpg'),
      title: 'Pink Classic Chair',
      description: 'Shop Wayfair for the best dusty pink chair. Enjoy Free Shipping on most stuff, even big stuff.',
      date: 'March 14th, 2019',
      likes: 210,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/2.jpg'),
      title: 'Deep Sea Jellyfish',
      description: 'Jellyfish or sea jelly is the informal common name given to the medusa-phase of certain gelatinous.',
      date: 'March 19th, 2019',
      likes: 199,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/3.jpg'),
      title: 'Floating Pink Cherry',
      description: 'A cherry is the fruit of many plants of the genus Prunus, and is a fleshy drupe.',
      date: 'April 27th, 2019',
      likes: 189,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/4.jpg'),
      title: 'Green Leaf Pattern',
      description: 'A green leaf pattern is a discernible regularity in the world or in a manmade design.',
      date: 'June 15th, 2019',
      likes: 120,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/5.jpg'),
      title: 'Trees and Blue River',
      description: 'Along the Blue River can be found many miles of hiking, biking, and walking trails.',
      date: 'August 25th, 2019',
      likes: 123,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/6.jpg'),
      title: 'Pink Jellyfish in Sea',
      description: 'Jellyfish are eaten by humans in certain cultures, being considered a delicacy in some countries.',
      date: 'April 22th, 2019',
      likes: 89,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/7.jpg'),
      title: 'Orange Stairs Building',
      description: 'The vertical portion between each tread on the stair. This may be missing for an \'open\' stair effect.',
      date: 'July 14th, 2019',
      likes: 70,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/8.jpg'),
      title: 'Color full Tennis Court',
      description: 'Tennis is a racket sport that can be played individually against a single opponent or between two teams',
      date: 'January 29th, 2019',
      likes: 56,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/9.jpg'),
      title: 'Green Vegetables Pattern',
      description: 'Vegetables are parts of plants that are consumed by humans as food as part of a meal.',
      date: 'April 17th, 2019',
      likes: 42,
    ),

    const ImageCardModel(
      image: AssetImage('assets/images/deco/content/10.jpg'),
      title: 'Abstract Blue Wallpaper',
      description: 'An abstract is a brief summary of a research article, thesis, review, conference proceeding.',
      date: 'May 12th, 2019',
      likes: 18,
    ),
  ];



  static final List<ActivityModel> activity = [
    const ActivityModel(
      username: 'John Perkins',
      userImage: AssetImage('assets/images/deco/avatar/1.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/1.jpg'),
      date: '4 min ago',
    ),

    const ActivityModel(
      username: 'Dennis Wells',
      userImage: AssetImage('assets/images/deco/avatar/2.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/2.jpg'),
      date: '6 min ago',
    ),

    const ActivityModel(
      username: 'Samantha Bates',
      userImage: AssetImage('assets/images/deco/avatar/3.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/3.jpg'),
      date: '7 min ago',
    ),

    const ActivityModel(
      username: 'Lawrence Murray',
      userImage: AssetImage('assets/images/deco/avatar/4.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/4.jpg'),
      date: '10 min ago',
    ),

    const ActivityModel(
      username: 'Teresa Olsen',
      userImage: AssetImage('assets/images/deco/avatar/5.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/5.jpg'),
      date: '14 min ago',
    ),

    const ActivityModel(
      username: 'Barbara Morales',
      userImage: AssetImage('assets/images/deco/avatar/6.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/6.jpg'),
      date: '19 min ago',
    ),

    const ActivityModel(
      username: 'Victoria Gilbert',
      userImage: AssetImage('assets/images/deco/avatar/7.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/7.jpg'),
      date: '25 min ago',
    ),

    const ActivityModel(
      username: 'Jack Hansen',
      userImage: AssetImage('assets/images/deco/avatar/8.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/8.jpg'),
      date: '37 min ago',
    ),

    const ActivityModel(
      username: 'Michael Bell',
      userImage: AssetImage('assets/images/deco/avatar/9.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/9.jpg'),
      date: '41 min ago',
    ),

    const ActivityModel(
      username: 'Jesse Handsen',
      userImage: AssetImage('assets/images/deco/avatar/10.jpg'),
      action: 'commented on your photo',
      image: AssetImage('assets/images/deco/content/10.jpg'),
      date: '54 min ago',
    ),
  ];
}