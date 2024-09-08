import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/consts/consts.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/views/category_screen/item_details.dart';
import 'package:flutter_ecommerce/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();

              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 230,
                ),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['p_imgs'][0],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "${filtered[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                            10.heightBox
                          ],
                        )
                            .box
                            .white
                            .outerShadowMd
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }))
                    .toList(),
              );

              // GridView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: data.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 8,
              //     crossAxisSpacing: 8,
              //     mainAxisExtent: 230,
              //   ),
              //   itemBuilder: (context, index) {
              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Image.network(
              //           data[index]['p_imgs'][0],
              //           width: 200,
              //           fit: BoxFit.cover,
              //         ),
              //         const Spacer(),
              //         "${data[index]['p_name']}"
              //             .text
              //             .fontFamily(semibold)
              //             .color(darkFontGrey)
              //             .make(),
              //         10.heightBox,
              //         "${data[index]['p_price']}"
              //             .text
              //             .color(redColor)
              //             .fontFamily(bold)
              //             .size(16)
              //             .make(),
              //       ],
              //     )
              //         .box
              //         .white
              //         .rounded
              //         .margin(const EdgeInsets.symmetric(horizontal: 4))
              //         .padding(const EdgeInsets.all(8))
              //         .make()
              //         .onTap(() {
              //       Get.to(() => ItemDetails(
              //             title: "${data[index]['p_name']}",
              //             data: data[index],
              //           ));
              //     });
              //   },
              // );
            }
          }),
    );
  }
}
