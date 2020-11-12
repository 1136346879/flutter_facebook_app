import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xfs_flutter_utils/define/xfs_config.dart';


import 'dimens.dart';

class TextStyles {
  
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 = TextStyle(
    fontSize: Dimens.font_sp14,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
    fontSize: Dimens.font_sp16,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold
  );
 
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Config.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Config.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle textWhite18 = TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colors.white,
  );
  
  static const TextStyle text = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Config.text,
    textBaseline: TextBaseline.alphabetic
  );


  static const TextStyle textDark = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Config.dark_text,
    textBaseline: TextBaseline.alphabetic
  );


  static const TextStyle textTile = TextStyle(
      fontSize: Dimens.font_sp18,
      color: Colors.white,
      textBaseline: TextBaseline.alphabetic
  );


  static const TextStyle textDarkTile = TextStyle(
      fontSize: Dimens.font_sp18,
      color: Config.dark_text,
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textGray12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Config.text_gray,
    fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Config.dark_text_gray,
    fontWeight: FontWeight.normal
  );
  
  static const TextStyle textHint14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Config.dark_unselected_item_color
  );
}
