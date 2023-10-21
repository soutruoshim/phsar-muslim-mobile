import 'package:phsar_muslim/data/datasource/remote/dio/dio_client.dart';
import 'package:phsar_muslim/data/datasource/remote/exception/api_error_handler.dart';
import 'package:phsar_muslim/data/model/response/base/api_response.dart';
import 'package:phsar_muslim/utill/app_constants.dart';

class FeaturedDealRepo {
  final DioClient? dioClient;
  FeaturedDealRepo({required this.dioClient});

  Future<ApiResponse> getFeaturedDeal() async {
    try {
      final response = await dioClient!.get(AppConstants.featuredDealUri
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}