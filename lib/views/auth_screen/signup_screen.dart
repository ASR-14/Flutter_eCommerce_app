import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/consts/consts.dart';
import 'package:flutter_ecommerce/consts/lists.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/views/home_screen/home.dart';
import 'package:flutter_ecommerce/widgets_common/applogo_widget.dart';
import 'package:flutter_ecommerce/widgets_common/bg_widget.dart';
import 'package:flutter_ecommerce/widgets_common/custom_textfield.dart';
import 'package:flutter_ecommerce/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Sign up to $appname".text.fontFamily(bold).white.size(22).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPassword: false),
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        isPassword: false),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        isPassword: true),
                    customTextField(
                        hint: passwordHint,
                        title: retypePassord,
                        controller: passwordRetypeController,
                        isPassword: false),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: TextButton(
                    //         onPressed: () {}, child: forgetPass.text.make())),
                    // 5.heightBox,
                    // ourButton(
                    //         color: redColor,
                    //         title: login,
                    //         textColor: whiteColor,
                    //         onPress: () {})
                    //     .box
                    //     .width(context.screenWidth - 50)
                    //     .make(),
                    5.heightBox,
                    Row(
                      children: [
                        Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                )),
                            TextSpan(
                                text: " &",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ))
                          ])),
                        )
                      ],
                    ),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor))
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck == true) {
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then(
                                    (value) {
                                      return controller.storeUserData(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text);
                                    },
                                  ).then((value) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                }
                              }
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    RichText(
                        text: const TextSpan(
                      children: [
                        TextSpan(
                            text: alreadyHaveAccount,
                            style:
                                TextStyle(fontFamily: bold, color: fontGrey)),
                        TextSpan(
                            text: login,
                            style: TextStyle(fontFamily: bold, color: redColor))
                      ],
                    )).onTap(() {
                      Get.back();
                    }),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
