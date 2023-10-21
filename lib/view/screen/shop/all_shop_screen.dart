import 'package:flutter/material.dart';
import 'package:phsar_muslim/data/model/response/top_seller_model.dart';
import 'package:phsar_muslim/localization/language_constrants.dart';
import 'package:phsar_muslim/utill/color_resources.dart';
import 'package:phsar_muslim/utill/dimensions.dart';
import 'package:phsar_muslim/view/basewidget/custom_app_bar.dart';
import 'package:phsar_muslim/view/screen/home/widget/top_seller_view.dart';

class AllTopSellerScreen extends StatelessWidget {
  final TopSellerModel? topSeller;
  final String title;
  const AllTopSellerScreen({Key? key, required this.topSeller, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(title: '${getTranslated(title, context)}',),

      body: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: TopSellerView(isHomePage: false),
      ),
    );
  }
}
