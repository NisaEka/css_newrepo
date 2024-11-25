import 'dart:io';

import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';
import 'package:css_mobile/data/model/storage/storage_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/storage/storage_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class StorageImpl extends StorageRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<DefaultResponseModel<StorageModel?>> postStorage(File file) async {
    try {
      var formData = FormData.fromMap({});
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(file.path)));
      var response = await network.dio.post("/storage",
          data: formData,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "multipart/form-data"
          }));
      var storageModel = response.data["payload"];
      return DefaultResponseModel.fromJson(
          response.data, StorageModel.fromJson(storageModel));
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

  @override
  Future<DefaultResponseModel<List<FileModel>?>> postCcrfFile(
      Map<String, String> files) async {
    try {
      var formData = FormData.fromMap({});
      files.forEach((key, value) {
        formData.files.add(MapEntry(key, MultipartFile.fromFileSync(value)));
      });
      var response = await network.dio.post("/storage/ccrf",
          data: formData,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "multipart/form-data"
          }));
      var payload = response.data["payload"];
      List<FileModel> fileModels = [];
      payload.forEach((fileModel) {
        fileModels.add(FileModel.fromJson(fileModel));
      });
      return DefaultResponseModel.fromJson(response.data, fileModels);
    } on DioException catch (e) {
      AppLogger.e('error postCcrfFile $e');
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }
}
