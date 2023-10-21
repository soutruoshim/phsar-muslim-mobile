import 'package:phsar_muslim/data/datasource/remote/dio/dio_client.dart';
import 'package:phsar_muslim/data/datasource/remote/exception/api_error_handler.dart';
import 'package:phsar_muslim/data/model/response/base/api_response.dart';
import 'package:phsar_muslim/utill/app_constants.dart';

class CategoryRepo {
  final DioClient? dioClient;
  CategoryRepo({required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      final response = await dioClient!.get(
        AppConstants.categoriesUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getSellerWiseCategoryList(int sellerId) async {
    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseCategoryList}$sellerId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}