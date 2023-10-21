import 'package:flutter/material.dart';

import 'package:phsar_muslim/localization/language_constrants.dart';
import 'package:phsar_muslim/provider/featured_deal_provider.dart';
import 'package:phsar_muslim/utill/dimensions.dart';
import 'package:phsar_muslim/view/basewidget/custom_app_bar.dart';
import 'package:phsar_muslim/view/screen/home/widget/featured_deal_view.dart';
import 'package:provider/provider.dart';

class FeaturedDealScreen extends StatelessWidget {
  const FeaturedDealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('featured_deals', context)),

        Expanded(child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<FeaturedDealProvider>(context, listen: false).getFeaturedDealList(true);
          },
          child: const Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: FeaturedDealsView(isHomePage: false),
          ),
        )),

      ]),
    );
  }
}
