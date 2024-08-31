import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/consts/consts.dart';
import 'package:flutter_ecommerce/consts/lists.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/controllers/profile_controller.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/views/auth_screen/login_screen.dart';
import 'package:flutter_ecommerce/views/profile_screen/components/details_card.dart';
import 'package:flutter_ecommerce/views/profile_screen/edit_profile_screen.dart';
import 'package:flutter_ecommerce/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation(redColor)));
            } else {
              // print(snapshot.data?.docs);
              var data = snapshot.data!.docs[0];

              return SafeArea(
                  child: Column(
                children: [
                  //edit profile
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      ),
                    ).onTap(() {
                      // print(snapshot.data?.docs);
                      Get.to(() => const EditProfileScreen());
                    }),
                  ),
                  //user detail
                  Row(
                    children: [
                      Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          "${data['email']}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: "Logout".text.fontFamily(semibold).make()),
                    ],
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailsCard(
                          count: "00",
                          title: "in your cart",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: "32",
                          title: "in your wishlist",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: "675",
                          title: "your orders",
                          width: context.screenWidth / 3.4),
                    ],
                  ),

                  //buttons section
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ));
            }
          }),
    ));
  }
}
