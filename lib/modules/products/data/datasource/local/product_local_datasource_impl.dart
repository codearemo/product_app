import 'dart:convert';

import 'package:assessment/core/error/exceptions.dart';
import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/core/resolvers/init_dependencies.dart';
import 'package:assessment/core/storage.dart';
import 'package:assessment/modules/products/data/datasource/local/product_local_datasource.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl();

  @override
  Future<GeneralResponseModel<List<ProductModel?>?>?> fetchProducts() async {
    final storage = serviceLocator.get<Storage>();

    try {
      final data = (await storage.getData(key: 'products')) ?? [];

      final List<ProductModel?>? listData = data.map<ProductModel?>((e) {
        return ProductModel.fromJson(jsonDecode(e));
      }).toList();

      return GeneralResponseModel(
        data: listData,
        message: "Fetched products successfully.",
        // meta: Meta.fromJson({}),
      );
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<GeneralResponseModel?> saveProducts(
      List<ProductModel?>? params) async {
    final storage = serviceLocator.get<Storage>();

    try {
      final List<String> data = [];

      params?.forEach((element) {
        if (element != null) {
          final stringifiedData = jsonEncode(element.toJson());

          data.add(stringifiedData);
        }
      });

      await storage.storeData(key: 'products', value: data);

      return GeneralResponseModel(
        data: null,
        message: "Saved product successfully.",
        // meta: Meta.fromJson({}),
      );
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }
}
