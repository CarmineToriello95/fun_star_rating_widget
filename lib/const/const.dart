import 'package:flutter/material.dart';

import '../models/rating_data.dart';

const Map<int, RatingData> mapStarPositionOne = {
  0: RatingData(asset: "assets/images/star_empty.svg", color: Colors.grey),
  1: RatingData(asset: "assets/images/star_1.svg", color: Colors.red),
  2: RatingData(asset: "assets/images/star_2.svg", color: Colors.orange),
  3: RatingData(asset: "assets/images/star_3.svg", color: Colors.yellow),
  4: RatingData(asset: "assets/images/star_4.svg", color: Colors.yellow),
  5: RatingData(asset: "assets/images/star_5.svg", color: Colors.yellow),
};
const Map<int, RatingData> mapStarPositionTwo = {
  0: RatingData(asset: "assets/images/star_empty.svg", color: Colors.grey),
  2: RatingData(asset: "assets/images/star_2.svg", color: Colors.orange),
  3: RatingData(asset: "assets/images/star_3.svg", color: Colors.yellow),
  4: RatingData(asset: "assets/images/star_4.svg", color: Colors.yellow),
  5: RatingData(asset: "assets/images/star_5.svg", color: Colors.yellow),
};
const Map<int, RatingData> mapStarPositionThree = {
  0: RatingData(asset: "assets/images/star_empty.svg", color: Colors.grey),
  3: RatingData(asset: "assets/images/star_3.svg", color: Colors.yellow),
  4: RatingData(asset: "assets/images/star_4.svg", color: Colors.yellow),
  5: RatingData(asset: "assets/images/star_5.svg", color: Colors.yellow),
};
const Map<int, RatingData> mapStarPositionFour = {
  0: RatingData(asset: "assets/images/star_empty.svg", color: Colors.grey),
  4: RatingData(asset: "assets/images/star_4.svg", color: Colors.yellow),
  5: RatingData(asset: "assets/images/star_5.svg", color: Colors.yellow),
};
const Map<int, RatingData> mapStarPositionFive = {
  0: RatingData(asset: "assets/images/star_empty.svg", color: Colors.grey),
  5: RatingData(asset: "assets/images/star_5.svg", color: Colors.yellow),
};
