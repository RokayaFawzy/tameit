part of 'values.dart';

class Styles {


  static TextStyle customTextStyle({
    Color color = AppColors.blackShade1,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = Sizes.TEXT_SIZE_14,
    FontStyle fontStyle = FontStyle.normal,
    Alignment alignment =Alignment.center
    
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle customTextStyle2({
    Color color = AppColors.blackShade7,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = Sizes.TEXT_SIZE_16,
    Alignment alignment = Alignment.center,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.comfortaa(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
