import 'package:flutter/material.dart';
import 'package:phsar_muslim/data/model/response/address_model.dart';
import 'package:phsar_muslim/utill/color_resources.dart';
import 'package:phsar_muslim/utill/custom_themes.dart';
import 'package:phsar_muslim/utill/images.dart';
class AddressListPage extends StatelessWidget {
  final AddressModel? address;
  const AddressListPage({Key? key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        address!.addressType == 'Home' ? Images.homeImage
            : address!.addressType == 'Workplace' ? Images.bag : Images.moreImage,
        color: ColorResources.getSellerTxt(context), height: 30, width: 30,
      ),
      title: Text(address!.address!, style: titilliumRegular),
    );



  }
}
