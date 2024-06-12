import 'dart:io';

import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';
import 'package:css_mobile/data/model/storage/storage_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/storage/storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class StorageImpl extends StorageRepository {

  final network = Get.find<NetworkCore>();

  @override
  Future<DefaultResponseModel<StorageModel?>> postStorage(File file) async {
    try {
      var formData = FormData.fromMap({});
      formData.files.add(
        MapEntry("file", await MultipartFile.fromFile(file.path))
      );
      var response = await network.dio.post("/storage",
        data: formData,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "multipart/form-data"
        })
      );
      var storageModel = response.data["payload"];
      return DefaultResponseModel.fromJson(response.data, StorageModel.fromJson(storageModel));
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

  @override
  Future<DefaultResponseModel<List<CcrfFileModel>?>> postCcrfFile(Map<String, MultipartFile> files) async {
    try {
      var formData = FormData.fromMap({});
      files.forEach((key, value) {
        formData.files.add(
            MapEntry(key, value)
        );
      });
      var response = await network.dio.post("/storage/ccrf",
          data: formData,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "multipart/form-data"
          })
      );
      var payload = response.data["payload"];
      List<CcrfFileModel> fileModels = [];
      payload.forEach((fileModel) {
        fileModels.add(CcrfFileModel.fromJson(fileModel));
      });
      return DefaultResponseModel.fromJson(response.data, fileModels);
    } on DioException catch (e) {
      e.printError();
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

}