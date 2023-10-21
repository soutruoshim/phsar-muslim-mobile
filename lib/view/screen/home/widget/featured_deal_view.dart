import 'package:flutter/material.dart';
import 'package:phsar_muslim/provider/featured_deal_provider.dart';
import 'package:phsar_muslim/utill/dimensions.dart';
import 'package:phsar_muslim/view/basewidget/custom_slider/carousel_options.dart';
import 'package:phsar_muslim/view/basewidget/custom_slider/custom_slider.dart';
import 'package:phsar_muslim/view/screen/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:phsar_muslim/view/screen/home/widget/featured_deal_card.dart';
import 'package:provider/provider.dart';


class FeaturedDealsView extends StatelessWidget {
  final bool isHomePage;
  const FeaturedDealsView({Key? key, this.isHomePage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return isHomePage?
    Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, child) {
        return featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 2.5,
            viewportFraction: 0.83,
            autoPlay: true,
            enlargeFactor: 0.2,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            disableCenter: true,
            onPageChanged: (index, reason) {
              Provider.of<FeaturedDealProvider>(context, listen: false).changeSelectedIndex(index);
            },
          ),
          itemCount: featuredDealProvider.featuredDealProductList?.length,


          itemBuilder: (context, index, _) {
            return FeaturedDealCard(isHomePage: isHomePage,product: featuredDealProvider.featuredDealProductList![index]);
          },
        ) : const SizedBox() :const FindWhatYouNeedShimmer();
      },
    ):
    Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featuredDealProvider.featuredDealProductList?.length,
              itemBuilder: (context, index) {
                return FeaturedDealCard(isHomePage: isHomePage,product: featuredDealProvider.featuredDealProductList![index]);
              }),
        );
      }
    );
  }
}


