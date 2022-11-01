import 'package:flutter/cupertino.dart';

class DropDownInfo {
  final double trailingSize;
  final bool isFavorite;
  final IconData leadingIcon;
  final String title;
  final String info;
  final double infoSize;
  final String? bingoName;
  final double bingoNameTextSize;
  final String? image;
  final String? price;
  final double priceTextSize;
  final DateTime? date;
  final double remainingDaysTextSize;
  final double bingoDateTextSize;
  final double favouriteButtonSize;

  DropDownInfo({
    required this.leadingIcon,
    required this.title,
    required this.info,
    this.infoSize = 15,
    this.image,
    this.price,
    this.priceTextSize = 30,
    this.bingoName,
    this.bingoNameTextSize = 15,
    this.date,
    this.remainingDaysTextSize = 18,
    this.bingoDateTextSize = 14,
    this.isFavorite = false,
    this.trailingSize = 40,
    this.favouriteButtonSize = 40,
  });
}
