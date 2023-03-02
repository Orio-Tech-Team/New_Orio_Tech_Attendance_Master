import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Colors/color_resource.dart';

appBar({isShowCartIcon = true,var context}) {
  return AppBar(
    //backgroundColor: kBlueColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black87),
    title: Row(
      children: [
        InkWell(
            onTap: (){
             // Get.toNamed(CategoryScreen.routeName);
            },
            child: const Icon(Icons.menu,/*color: kSecondaryColor,*/)),
        const SizedBox(width: 5,),
        Image.asset('assets/images/logo.png', height: 32.0),
      ],
    ),
    actions: [
      /*Icon(Icons.person_outline,color: kSecondaryColor,size: 28,),
      SizedBox(width: 12,),*/
      Image.network("https://cartswing.com/static/version1658147413/frontend/PiknPak/CartswingV2/en_US/images/wallet-icon.png",width: 24,),
      const SizedBox(width: 15,),
      InkWell(
          onTap: (){
            /*Get.toNamed(WishListScreen.routeName);*/
            //Navigator.push(context, MaterialPageRoute(builder: (context) => WishListScreen()));
          },
          child: Image.network("https://cartswing.com/static/version1658147413/frontend/PiknPak/CartswingV2/en_US/images/wishlist-icon.png",width: 24,)),

      if (isShowCartIcon)
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 12),
          child: InkWell(
            //onTap: () => Get.toNamed(CartScreen.routeName),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /*GetBuilder<AuthController>(
                  builder: (authController) => InkWell(
                    onTap: (){
                      if (authController.currentUserData.isEmpty) {
                        Get.toNamed(LogInScreen.routeName, arguments: true);
                      } else {
                        Get.toNamed(CartScreen.routeName);
                      }
                    },
                    child: Image.network("https://cartswing.com/static/version1658147413/frontend/PiknPak/CartswingV2/en_US/images/cart-icon.png",width: 24,),
                  ),*//*IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                    onPressed: () {
                      if (authController.currentUserData.isEmpty) {
                        Get.toNamed(LogInScreen.routeName, arguments: true);
                      } else {
                        Get.toNamed(CartScreen.routeName);
                      }
                    },
                  ),*//*
                ),*/
                Positioned(
                  right: 0,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.redAccent,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    /*child: GetBuilder<CartController>(
                      init: CartController(),
                      builder: (cartController) {
                        List<int> productQuantity =
                        cartController.cartItemList.values.map((e) => e.qty).toList();
                        var sumOfAllQuantity = 0;
                        for (var i = 0; i < productQuantity.length; i++) {
                          sumOfAllQuantity += productQuantity[i];
                        }

                        return cartController.cartItemList.isEmpty
                            ? const Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : Text(
                          '$sumOfAllQuantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),*/
                  ),
                )
              ],
            ),
          ),
        ),
    ],
  );
}