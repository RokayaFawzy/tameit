import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tame_it/values/values.dart';
import 'package:tame_it/widgets/custom_button.dart';

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
      child: _buildChangePassForm(),
    ));
  }

  Widget _buildChangePassForm() {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: AppColors.whiteShade3,
        appBar: AppBar(
            title: Center(
                child: Text('Change Password',
                    style: TextStyle(
                      color: AppColors.deepsea,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ))),
            iconTheme: const IconThemeData(color: AppColors.deepsea),
            backgroundColor: AppColors.whiteShade3),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
            child: Column(children: <Widget>[
              SizedBox(
                height: Sizes.HEIGHT_14,
              ),
              SizedBox(
                height: Sizes.HEIGHT_50,
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                  ),
                  decoration: InputDecoration(
                      // contentPadding:EdgeInsets.only(left: 25),
                      hintText: ' Enter current password',
                      hintStyle: Styles.customTextStyle(
                        fontSize: Sizes.TEXT_SIZE_14,
                        color: Color.fromARGB(255, 137, 182, 177),
                      ),
                      enabled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.RADIUS_14)),
                          borderSide: BorderSide(
                              color: AppColors.grey,
                              width: Sizes.WIDTH_1,
                              style: BorderStyle.solid)),
                      filled: true,
                      fillColor: Color.fromARGB(94, 200, 201, 205)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: Sizes.HEIGHT_50,
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                  ),
                  decoration: InputDecoration(
                      // contentPadding:EdgeInsets.only(left: 25),
                      hintText: ' New password',
                      hintStyle: Styles.customTextStyle(
                        fontSize: Sizes.TEXT_SIZE_14,
                        color: Color.fromARGB(255, 137, 182, 177),
                      ),
                      suffixIcon: const Icon(
                        FeatherIcons.eyeOff,
                        size: Sizes.ICON_SIZE_22,
                        color: Color.fromARGB(255, 137, 182, 177),
                      ),
                      enabled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.RADIUS_14)),
                          borderSide: BorderSide(
                              color: AppColors.grey,
                              width: Sizes.WIDTH_1,
                              style: BorderStyle.solid)),
                      filled: true,
                      fillColor: Color.fromARGB(94, 200, 201, 205)),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: Sizes.HEIGHT_50,
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                  ),
                  decoration: InputDecoration(
                      // contentPadding:EdgeInsets.only(left: 25),
                      hintText: ' Confirm new password',
                      hintStyle: Styles.customTextStyle(
                        fontSize: Sizes.TEXT_SIZE_14,
                        color: Color.fromARGB(255, 137, 182, 177),
                      ),
                      suffixIcon: const Icon(
                        FeatherIcons.eyeOff,
                        size: Sizes.ICON_SIZE_22,
                        color: Color.fromARGB(255, 137, 182, 177),
                      ),
                      enabled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.RADIUS_14)),
                          borderSide: BorderSide(
                              color: AppColors.grey,
                              width: Sizes.WIDTH_1,
                              style: BorderStyle.solid)),
                      filled: true,
                      fillColor: Color.fromARGB(94, 200, 201, 205)),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                width: widthOfScreen * 0.6,
                child: CustomButton(
                  title: 'Save',
                  color: AppColors.deepsea,
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: Sizes.HEIGHT_25,
              )
            ])));
  }
}
