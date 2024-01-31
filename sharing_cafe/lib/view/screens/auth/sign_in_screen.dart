import 'dart:async';
import 'dart:io';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:sixam_mart/controller/auth_controller.dart';
// import 'package:sixam_mart/controller/cart_controller.dart';
// import 'package:sixam_mart/controller/localization_controller.dart';
// import 'package:sixam_mart/controller/location_controller.dart';
// import 'package:sixam_mart/controller/splash_controller.dart';
// import 'package:sixam_mart/helper/custom_validator.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/helper/route_helper.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/images.dart';
// import 'package:sixam_mart/util/styles.dart';
// import 'package:sixam_mart/view/base/custom_button.dart';
// import 'package:sixam_mart/view/base/custom_snackbar.dart';
// import 'package:sixam_mart/view/base/custom_text_field.dart';
// import 'package:sixam_mart/view/base/menu_drawer.dart';
// import 'package:sixam_mart/view/screens/auth/sign_up_screen.dart';
// import 'package:sixam_mart/view/screens/auth/widget/condition_check_box.dart';
// import 'package:sixam_mart/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sharing_cafe/controller/auth_controller.dart';
import 'package:sharing_cafe/helper/responsive_helper.dart';
import 'package:sharing_cafe/helper/route_helper.dart';
import 'package:sharing_cafe/util/dimensions.dart';
import 'package:sharing_cafe/util/images.dart';
import 'package:sharing_cafe/util/styles.dart';
import 'package:sharing_cafe/view/base/custom_button.dart';
import 'package:sharing_cafe/view/base/custom_snackbar.dart';
import 'package:sharing_cafe/view/base/custom_text_field.dart';
// import 'package:sixam_mart/view/screens/auth/widget/social_login_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  final bool backFromThis;
  const SignInScreen({Key? key, required this.exitFromApp, required this.backFromThis}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    // _countryDialCode = Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode()
    //     : CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode;
    // _phoneController.text =  Get.find<AuthController>().getUserNumber();
    // _passwordController.text = Get.find<AuthController>().getUserPassword();
    // if(Get.find<AuthController>().showPassView){
    //   Get.find<AuthController>().showHidePass(isUpdate: false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              // Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('ấn lần nữa để thoát', style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              // margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        }else {
          return true;
        }
      },
      child: Scaffold(
        // backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
        // appBar: (ResponsiveHelper.isDesktop(context) ? null : !widget.exitFromApp ? AppBar(leading: IconButton(
        //   onPressed: () => Get.back(),
        //   icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).textTheme.bodyLarge!.color),
        // ), elevation: 0, backgroundColor: Colors.transparent,
        // actions: const [SizedBox()],
        // ) : null),
        // endDrawer: const MenuDrawer(),endDrawerEnableOpenDragGesture: false,
        body: SafeArea(child: Scrollbar(
          child: Center(
            child: Container(
              height: ResponsiveHelper.isDesktop(context) ? 690 : null,
              width: context.width > 700 ? 500 : context.width,
              padding: context.width > 700 ? const EdgeInsets.symmetric(horizontal: 0) : const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
              decoration: context.width > 700 ? BoxDecoration(
                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: ResponsiveHelper.isDesktop(context) ? null : [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
              ) : null,
              child: GetBuilder<AuthController>(builder: (authController) {
                return Center(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          ResponsiveHelper.isDesktop(context) ? Positioned(
                            top: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ) : const SizedBox(),

                          Padding(
                            padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(40) : EdgeInsets.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Image.asset(Images.logo, width: 50),
                                      Text('Sharing Cafe', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),)
                                    ],),
                                    const SizedBox(height: Dimensions.paddingSizeExtremeLarge),
                                    Text('Xin Chào', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                                    const SizedBox(height: Dimensions.paddingSizeLarge),
                                  Text('Vui lòng nhập số điện thoại và mật khẩu của bạn để đăng nhập.', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),

                                  ],
                                ),
                                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  
                                  const SizedBox(height: Dimensions.paddingSizeSmall),
                                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),


                                  CustomTextField(
                                    titleText: 'Số điện thoại',
                                    hintText: 'Số điện thoại',
                                    controller: _phoneController,
                                    focusNode: _phoneFocus,
                                    nextFocus: _passwordFocus,
                                    inputType: TextInputType.phone,
                                    showTitle: true,
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeLarge),
                                  CustomTextField(
                                    titleText: 'Mật khẩu',
                                    hintText: 'Mật khẩu',
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    inputAction: TextInputAction.done,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    showTitle: true,
                                    onSubmit: (text) => _login(authController),
                                
                                    onChanged: (value){
                                      if(value != null && value.isNotEmpty){
                                        if(!authController.showPassView){
                                          authController.showHidePass();
                                        }
                                        authController.validPassCheck(value);
                                      }else{
                                        if(authController.showPassView){
                                          authController.showHidePass();
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeSmall),


                                  Row(children: [
                                    Expanded(
                                      child: ListTile(
                                        onTap: () => authController.toggleRememberMe(),
                                        leading: Checkbox(
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          activeColor: Theme.of(context).primaryColor,
                                          value: authController.isActiveRememberMe,
                                          onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                        ),
                                        title: const Text('Ghi nhớ đăng nhập'),
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                        dense: true,
                                        horizontalTitleGap: 0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
                                      child: Text('Quên mật khẩu?', style: robotoRegular.copyWith(color: Theme.of(context).primaryColor)),
                                    ),
                                  ]),
                                  const SizedBox(height: Dimensions.paddingSizeLarge),


                                  const SizedBox(height: Dimensions.paddingSizeDefault),

                                  CustomButton(
                                    height: ResponsiveHelper.isDesktop(context) ? 45 : null,
                                    width:  ResponsiveHelper.isDesktop(context) ? 180 : null,
                                    buttonText: 'Đăng nhập',
                                    onPressed: () => _login(authController),

                                    isLoading: authController.isLoading,
                                    radius: ResponsiveHelper.isDesktop(context) ? Dimensions.radiusSmall : Dimensions.radiusDefault,
                                    isBold: !ResponsiveHelper.isDesktop(context),
                                    fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeExtraSmall : null,
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                                  ResponsiveHelper.isDesktop(context) ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text('Không có tài khoản?', style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                                    InkWell(
                                      onTap: () {
                                          Get.toNamed(RouteHelper.getSignUpRoute());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                        child: Text('Đăng ký ngay', style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: Dimensions.paddingSizeSmall),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              }),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    // ignore: unrelated_type_equality_checks
    bool phoneValid = phone == 10 ? true : false;

    if (phone.isEmpty) {
      showCustomSnackBar('Vui lòng nhập số điện thoại');
    }else if (phoneValid) {
      showCustomSnackBar('Số điện thoại không hợp lệ');
    }else if (password.isEmpty) {
      showCustomSnackBar('Vui lòng nhập mật khẩu');
    }else if (password.length < 6) {
      showCustomSnackBar('Mật khẩu không hợp lệ');
    }else {
      authController.login(phone, password).then((status) async {
        if (status.isSuccess) {
          // Get.find<CartController>().getCartDataOnline();
          // if (authController.isActiveRememberMe) {
          //   authController.saveUserNumberAndPassword(phone, password, countryDialCode);
          // } else {
          //   authController.clearUserNumberAndPassword();
          // }
          // String token = status.message!.substring(1, status.message!.length);
          // if(Get.find<SplashController>().configModel!.customerVerification! && int.parse(status.message![0]) == 0) {
          //   List<int> encoded = utf8.encode(password);
          //   String data = base64Encode(encoded);
          //   Get.toNamed(RouteHelper.getVerificationRoute(numberWithCountryCode, token, RouteHelper.signUp, data));
          // }else {

          //   if(widget.backFromThis) {
          //     if(ResponsiveHelper.isDesktop(context)){
          //       Get.offAllNamed(RouteHelper.getInitialRoute(fromSplash: false));
          //     } else {
          //       Get.back();
          //     }
          //   }else{
          //     Get.find<LocationController>().navigateToLocationScreen('sign-in', offNamed: true);
          //   }
          // }
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
