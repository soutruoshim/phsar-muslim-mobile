import 'package:flutter/material.dart';
import 'package:phsar_muslim/provider/cart_provider.dart';
import 'package:phsar_muslim/provider/notification_provider.dart';
import 'package:phsar_muslim/utill/color_resources.dart';
import 'package:phsar_muslim/utill/custom_themes.dart';
import 'package:phsar_muslim/utill/dimensions.dart';
import 'package:phsar_muslim/utill/images.dart';
import 'package:phsar_muslim/view/screen/cart/cart_screen.dart';
import 'package:phsar_muslim/view/screen/notification/notification_screen.dart';
import 'package:provider/provider.dart';

class CartWidgetHomePage extends StatelessWidget {
  const CartWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, _) {
            return IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
              icon: Stack(clipBehavior: Clip.none, children: [
                Image.asset(Images.notification,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    color: ColorResources.getPrimary(context)),
                Positioned(top: -4, right: -4,
                  child: CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                    child: Text(notificationProvider.notificationModel?.newNotificationItem.toString() ?? '0',
                        style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  ),
                ),

              ]),
            );
          }
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(Images.cartArrowDownImage,
                  height: Dimensions.iconSizeDefault,
                  width: Dimensions.iconSizeDefault,
                  color: ColorResources.getPrimary(context)),
              Positioned(top: -4, right: -4,
                child: Consumer<CartProvider>(builder: (context, cart, child) {
                  return CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                    child: Text(cart.cartList.length.toString(),
                        style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  );
                }),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
