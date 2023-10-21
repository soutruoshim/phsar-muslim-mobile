import 'package:phsar_muslim/data/datasource/remote/dio/dio_client.dart';
import 'package:phsar_muslim/data/datasource/remote/exception/api_error_handler.dart';
import 'package:phsar_muslim/data/model/response/base/api_response.dart';
import 'package:phsar_muslim/utill/app_constants.dart';

class TopSellerRepo {
  final DioClient? dioClient;
  TopSellerRepo({required this.dioClient});

  Future<ApiResponse> getTopSeller() async {
    try {
      final response = await dioClient!.get(AppConstants.topSeller);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}