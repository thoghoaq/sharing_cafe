import 'package:sharing_cafe/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharing_cafe/data/model/body/signup_body.dart';
import 'package:sharing_cafe/helper/responsive_helper.dart';
import 'package:sharing_cafe/helper/route_helper.dart';
import 'package:sharing_cafe/util/dimensions.dart';
import 'package:sharing_cafe/util/styles.dart';
import 'package:sharing_cafe/view/base/custom_button.dart';
import 'package:sharing_cafe/view/base/custom_snackbar.dart';
import 'package:sharing_cafe/view/base/custom_text_field.dart';
import 'package:sharing_cafe/view/screens/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // final TextEditingController _referCodeController = TextEditingController();
  // String? _countryDialCode;

  @override
  void initState() {
    super.initState();

    // _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode;
    if (Get.find<AuthController>().showPassView) {
      Get.find<AuthController>().showHidePass(isUpdate: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isDesktop(context)
          ? Colors.transparent
          : Theme.of(context).cardColor,
      // endDrawer: const MenuDrawer(), endDrawerEnableOpenDragGesture: false,
      body: SafeArea(
          child: Scrollbar(
        child: Center(
          child: Container(
            width: context.width > 700 ? 700 : context.width,
            padding: context.width > 700
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(Dimensions.paddingSizeLarge),
            margin: context.width > 700
                ? const EdgeInsets.all(Dimensions.paddingSizeDefault)
                : null,
            decoration: context.width > 700
                ? BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)],
                  )
                : null,
            child: GetBuilder<AuthController>(builder: (authController) {
              // ResponsiveHelper.isDesktop(context) ? Align(
              //   alignment: Alignment.topRight,
              //   child: IconButton(
              //     onPressed: () => Get.back(),
              //     icon: const Icon(Icons.clear),
              //   ),
              // ) : const SizedBox(),

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    ResponsiveHelper.isDesktop(context)
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: ResponsiveHelper.isDesktop(context)
                          ? const EdgeInsets.all(40)
                          : EdgeInsets.zero,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtremeLarge),
                                Text(
                                  'Tạo tài khoản 🔐',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                Text(
                                  'Vui lòng nhập số điện thoại, email và mật khẩu.',
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              ],
                            ),
                            // Image.asset(Images.logo, width: 125),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            // Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge),

                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child: Text('sign_up',
                            //       style: robotoBold.copyWith(
                            //           fontSize: Dimensions.fontSizeExtraLarge)),
                            // ),

                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            Row(children: [
                              ResponsiveHelper.isDesktop(context)
                                  ? Expanded(
                                      child: CustomTextField(
                                        titleText: 'Email',
                                        hintText: 'Email',
                                        controller: _emailController,
                                        focusNode: _emailFocus,
                                        nextFocus:
                                            ResponsiveHelper.isDesktop(context)
                                                ? _phoneFocus
                                                : _passwordFocus,
                                        inputType: TextInputType.emailAddress,
                                        prefixIcon: Icons.mail,
                                        showTitle: true,
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                  width: ResponsiveHelper.isDesktop(context)
                                      ? Dimensions.paddingSizeSmall
                                      : 0),
                              Expanded(
                                child: CustomTextField(
                                  titleText: 'Số điện thoại',
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  nextFocus: ResponsiveHelper.isDesktop(context)
                                      ? _passwordFocus
                                      : _emailFocus,
                                  inputType: TextInputType.phone,
                                  prefixIcon:
                                      ResponsiveHelper.isDesktop(context)
                                          ? Icons.phone_android
                                          : null,
                                  showTitle: true,
                                ),
                              ),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            !ResponsiveHelper.isDesktop(context)
                                ? CustomTextField(
                                    titleText: 'Email',
                                    hintText: 'Email',
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    nextFocus: _passwordFocus,
                                    inputType: TextInputType.emailAddress,
                                    showTitle: true,
                                  )
                                : const SizedBox(),
                            SizedBox(
                                height: !ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.paddingSizeLarge
                                    : 0),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(children: [
                                      CustomTextField(
                                        titleText: 'Mật khẩu',
                                        hintText: 'Mật khẩu',
                                        controller: _passwordController,
                                        focusNode: _passwordFocus,
                                        nextFocus: _confirmPasswordFocus,
                                        inputType:
                                            TextInputType.visiblePassword,
                                        prefixIcon:
                                            ResponsiveHelper.isDesktop(context)
                                                ? Icons.lock
                                                : null,
                                        isPassword: true,
                                        showTitle: true,
                                        // onChanged: (value){
                                        //   if(value != null && value.isNotEmpty){
                                        //     if(!authController.showPassView){
                                        //       authController.showHidePass();
                                        //     }
                                        //     authController.validPassCheck(value);
                                        //   }else{
                                        //     if(authController.showPassView){
                                        //       authController.showHidePass();
                                        //     }
                                        //   }
                                        // },
                                      ),

                                      // authController.showPassView ? const PassView() : const SizedBox(),
                                    ]),
                                  ),
                                  SizedBox(
                                      width: ResponsiveHelper.isDesktop(context)
                                          ? Dimensions.paddingSizeSmall
                                          : 0),
                                  ResponsiveHelper.isDesktop(context)
                                      ? Expanded(
                                          child: CustomTextField(
                                          titleText: 'Xác nhận mật khẩu',
                                          hintText: 'Xác nhận mật khẩu',
                                          controller:
                                              _confirmPasswordController,
                                          focusNode: _confirmPasswordFocus,
                                          inputType:
                                              TextInputType.visiblePassword,
                                          prefixIcon: Icons.lock,
                                          isPassword: true,
                                          showTitle: true,
                                          onSubmit: (text) =>  _register(authController),
                                        ))
                                      : const SizedBox()
                                ]),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            !ResponsiveHelper.isDesktop(context)
                                ? CustomTextField(
                                    titleText: 'Xác nhận mật khẩu',
                                    hintText: 'Xác nhận mật khẩu',
                                    controller: _confirmPasswordController,
                                    focusNode: _confirmPasswordFocus,
                                    inputType: TextInputType.visiblePassword,
                                    showTitle: true,
                                    isPassword: true,
                                    onSubmit: (text) =>  _register(authController),
                                  )
                                : const SizedBox(),
                            SizedBox(
                                height: !ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.paddingSizeLarge
                                    : 0),

                            CustomButton(
                              height: ResponsiveHelper.isDesktop(context)
                                  ? 45
                                  : null,
                              width: ResponsiveHelper.isDesktop(context)
                                  ? 180
                                  : null,
                              radius: ResponsiveHelper.isDesktop(context)
                                  ? Dimensions.radiusSmall
                                  : Dimensions.radiusDefault,
                              isBold: !ResponsiveHelper.isDesktop(context),
                              fontSize: ResponsiveHelper.isDesktop(context)
                                  ? Dimensions.fontSizeExtraSmall
                                  : null,
                              buttonText: 'Xác nhận',
                              isLoading: authController.isLoading,
                              onPressed: () => _register(authController),
                            ),

                            const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Đã có tài khoản?',
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).hintColor)),
                                  InkWell(
                                    onTap: () {
                                      if (ResponsiveHelper.isDesktop(context)) {
                                        Get.back();
                                        Get.dialog(const SignInScreen(
                                            exitFromApp: false,
                                            backFromThis: false));
                                      } else {
                                        if (Get.currentRoute ==
                                            RouteHelper.signUp) {
                                          Get.back();
                                        } else {
                                          Get.toNamed(
                                              RouteHelper.getSignInRoute(
                                                  RouteHelper.signUp));
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeExtraSmall),
                                      child: Text('Đăng nhập',
                                          style: robotoMedium.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                  ),
                                ]),
                          ]),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      )),
    );
  }

  void _register(AuthController authController) async {
    String email = _emailController.text.trim();
    String number = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    // ignore: unrelated_type_equality_checks
    bool phoneValid = number == 10 ? true : false;

    if (email.isEmpty) {
      showCustomSnackBar('Email không được để trống');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Vui lòng nhập đúng cú pháp Email');
    } else if (number.isEmpty) {
      showCustomSnackBar('Số điện thoại không được để trống');
    } else if (phoneValid) {
      showCustomSnackBar('Vui lòng nhập đúng số điện thoại');
    } else if (password.isEmpty) {
      showCustomSnackBar('Vui lòng nhập mật khẩu');
    } else if (password.length < 6) {
      showCustomSnackBar('Mật khẩu không đạt điều kiện');
    } else if (password != confirmPassword) {
      showCustomSnackBar('Mật khẩu xác nhận không khớp');
    } else {
      SignUpBody signUpBody = SignUpBody(
        email: email,
        phone: number,
        password: password,
      );
      authController.registration(signUpBody).then((status) async {
        if (status.isSuccess) {
          //TODO
          //nếu tạo tk thành công thực hiện gửi code và chuyển sang trang xác nhận sđt
        } else {
          showCustomSnackBar(status.message);
          //TODO
          //nếu tạo tk ko thành công (tk đã tồn tại)
        }
      });
    }
  }
}
