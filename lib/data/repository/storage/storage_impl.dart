import 'dart:io';

import 'package:css_mobile/data/model/base_response_model.dart';
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
      var response = await network.base.post("/storage",
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
  Future<BaseResponse<List<FileModel>?>> postCcrfFile(
      Map<String, String> files) async {
    try {
      var formData = FormData.fromMap({});

      files.forEach((key, value) {
        String fileExtension = value.split('.').last.toLowerCase();
        String mimeType = _getMimeType(fileExtension);
        if (!value.contains("http")) {
          formData.files.add(MapEntry(
              key,
              MultipartFile.fromFileSync(value,
                  filename: value.split('/').last,
                  contentType: DioMediaType.parse(mimeType))));
        }
      });

      var response = await network.base.post("/uploads/ccrf",
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}));
      return BaseResponse<List<FileModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<FileModel>(
                  (i) => FileModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error post eclaim file ${e.response?.data}');
      return BaseResponse<List<FileModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<FileModel>(
                  (i) => FileModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<List<FileModel>?>> postLaporankuFiles(File file) async {
    try {
      String fileExtension = file.path.split('.').last.toLowerCase();

      String mimeType = _getMimeType(fileExtension);

      var formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
          contentType: DioMediaType.parse(mimeType),
        ),
      });

      var response = await network.base.post("/uploads/laporanku",
          data: formData,
          options: Options(headers: {"Content-Type": "multipart/form-data"}));
      return BaseResponse<List<FileModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<FileModel>(
                  (i) => FileModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error post laporanku file ${e.response?.data}');
      return BaseResponse<List<FileModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<FileModel>(
                  (i) => FileModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  String _getMimeType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }
}
