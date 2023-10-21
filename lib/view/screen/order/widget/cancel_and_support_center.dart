import 'package:flutter/material.dart';
import 'package:phsar_muslim/data/model/response/order_model.dart';
import 'package:phsar_muslim/localization/language_constrants.dart';
import 'package:phsar_muslim/provider/auth_provider.dart';
import 'package:phsar_muslim/provider/order_provider.dart';
import 'package:phsar_muslim/utill/color_resources.dart';
import 'package:phsar_muslim/utill/custom_themes.dart';
import 'package:phsar_muslim/utill/dimensions.dart';
import 'package:phsar_muslim/view/basewidget/custom_button.dart';
import 'package:phsar_muslim/view/screen/order/widget/cancel_order_dialog.dart';
import 'package:phsar_muslim/view/screen/support/support_ticket_screen.dart';
import 'package:phsar_muslim/view/screen/tracking/tracking_result_screen.dart';
import 'package:provider/provider.dart';

class CancelAndSupport extends StatelessWidget {
  final Orders? orderModel;
  final bool fromNotification;
  const CancelAndSupport({Key? key, this.orderModel, this.fromNotification = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen())),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: getTranslated('if_you_cannot_contact_with_seller_or_facing_any_trouble_then_contact', context),
                style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeSmall),),
              TextSpan(text: ' ${getTranslated('SUPPORT_CENTER', context)}',
                style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)))]))),
          const SizedBox(height: Dimensions.homePagePadding),


          orderModel != null && orderModel!.orderStatus == 'pending' && orderModel!.orderType != "POS" || fromNotification ?
          CustomButton(textColor: Theme.of(context).colorScheme.error,
              backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
              buttonText: getTranslated('cancel_order', context),
              onTap: () {
            showDialog(context: context, builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: CancelOrderDialog(orderId: orderModel!.id)));}) :



          orderModel != null && orderModel!.orderStatus == 'delivered' && orderModel!.orderType != "POS" ?
          CustomButton(textColor: ColorResources.white,
              backgroundColor: Theme.of(context).primaryColor,
              buttonText: getTranslated('re_order', context),
              onTap: () => Provider.of<OrderProvider>(context, listen: false).reorder(orderId: orderModel?.id.toString())):

          ( Provider.of<AuthProvider>(context, listen: false).isLoggedIn() && orderModel!.orderType != "POS" && (orderModel!.orderStatus != 'canceled' ||  orderModel!.orderStatus != 'returned'  || orderModel!.orderStatus != 'fail_to_delivered' ) )?
          CustomButton(buttonText: getTranslated('TRACK_ORDER', context),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(orderID: orderModel!.id.toString()))),): const SizedBox(),

          const SizedBox(width: Dimensions.paddingSizeSmall),


        ],
      ),
    );
  }
}
