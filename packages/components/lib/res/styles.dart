import 'package:components/res/colors.dart';
import 'package:components/res/font_alias.dart';
import 'package:components/res/spacing_alias.dart';
import 'package:components/res/text_style_common.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Text styles
  static final TextStyle textSize12 =
      TextStyle(fontSize: FontAlias.fontAlias12);

  static final TextStyle textSize14 =
      TextStyle(fontSize: FontAlias.fontAlias14);

  static final paddingContainer = EdgeInsets.only(
      left: SpacingAlias.Spacing16,
      right: SpacingAlias.Spacing16,
      bottom: SpacingAlias.Spacing16);

  static final paddingButtonFooter = EdgeInsets.only(
      top: SpacingAlias.Spacing12,
      left: SpacingAlias.Spacing16,
      right: SpacingAlias.Spacing16,
      bottom: SpacingAlias.Spacing16);

  static final mainActionTextStyle = TextStyleCommon(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: FontAlias.fontAlias16);

  static final assistActionsTextStyle = TextStyleCommon(
      color: AppColors.colorTextBase,
      fontWeight: FontWeight.w600,
      fontSize: FontAlias.fontAlias16);

  static final warningTextStyle = TextStyleCommon(
    fontSize: FontAlias.fontAlias14,
    color: AppColors.error,
    decoration: TextDecoration.none,
  );

  static final titleStyle = TextStyleCommon(
      color: AppColors.colorTextBase,
      fontSize: FontAlias.fontAlias16,
      fontWeight: FontWeight.w600);

  static final itemTitleStyleAlert = TextStyleCommon(
    color: AppColors.error,
    fontSize: FontAlias.fontAlias16,
    fontWeight: FontWeight.w600,
  );

  static final itemDescStyle = TextStyleCommon(
    color: AppColors.colorTextBase,
    fontSize: FontAlias.fontAlias12,
    fontWeight: FontWeight.w600,
  );

  static final itemDescStyleLink = TextStyleCommon(
    color: AppColors.colorLink,
    fontSize: FontAlias.fontAlias12,
    fontWeight: FontWeight.w600,
  );

  static final itemDescStyleAlert = TextStyleCommon(
    color: AppColors.error,
    fontSize: FontAlias.fontAlias12,
    fontWeight: FontWeight.w600,
  );

  static final itemTitleStyle = TextStyleCommon(
    color: AppColors.colorTextBase,
    fontSize: FontAlias.fontAlias16,
    fontWeight: FontWeight.w600,
  );

  static final itemTitleStyleLink = TextStyleCommon(
      fontSize: FontAlias.fontAlias16,
      fontWeight: FontWeight.w600,
      color: AppColors.colorLink);

  static final cancelStyle = TextStyleCommon(
    color: AppColors.colorTextBase,
    fontSize: FontAlias.fontAlias16,
    fontWeight: FontWeight.w600,
  );

  static final labelStyle = TextStyleCommon(
      color: AppColors.colorLink,
      fontSize: FontAlias.fontAlias16,
      fontWeight: FontWeight.w600);

  static final unselectedLabelStyle = TextStyleCommon(
      color: AppColors.colorTextBase,
      fontSize: FontAlias.fontAlias16,
      fontWeight: FontWeight.normal);

  static final tagNormalTextStyle = TextStyleCommon(
      color: AppColors.colorTextBase, fontSize: FontAlias.fontAlias12);

  static final tagSelectedTextStyle = TextStyleCommon(
      color: AppColors.colorLink, fontSize: FontAlias.fontAlias12);

  static final titlePaddingSm = EdgeInsets.only(
      top: SpacingAlias.Spacing16, left: SpacingAlias.Spacing10);

  static final titlePaddingLg = EdgeInsets.only(
      top: SpacingAlias.Spacing16, left: SpacingAlias.Spacing20);

  static final titlePadding0 =
      EdgeInsets.only(top: SpacingAlias.Spacing16, left: SpacingAlias.Spacing0);

  static final contentPaddingSm = EdgeInsets.only(
      top: 8, left: SpacingAlias.Spacing24, right: SpacingAlias.Spacing24);

  static final contentPaddingLg = EdgeInsets.only(
      top: 28, left: SpacingAlias.Spacing24, right: SpacingAlias.Spacing24);

  static final contentTextStyle = TextStyleCommon(
      color: AppColors.colorTextBase, fontSize: FontAlias.fontAlias16);

  static final warningPaddingSm = EdgeInsets.only(
      top: 6, left: SpacingAlias.Spacing24, right: SpacingAlias.Spacing24);

  static final warningPaddingLg = EdgeInsets.only(
      top: 28, left: SpacingAlias.Spacing24, right: SpacingAlias.Spacing24);
}

extension CustomStyles on TextTheme {
  TextStyle get buttonWhite => Typography.material2018()
      .englishLike
      .button!
      .copyWith(color: AppColors.white, letterSpacing: 1);

  TextStyle get buttonPrimary => Typography.material2018()
      .englishLike
      .button!
      .copyWith(color: AppColors.primary, letterSpacing: 1);

  TextStyle get subtitle3 => Typography.material2018()
      .englishLike
      .subtitle2!
      .copyWith(fontSize: FontAlias.fontAlias14, fontWeight: FontWeight.w300);
}
