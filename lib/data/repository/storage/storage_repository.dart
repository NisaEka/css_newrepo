import 'dart:io';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';

abstract class StorageRepository {
  Future<BaseResponse<List<FileModel>?>> postCcrfFile(
      Map<String, String> files);

  Future<BaseResponse<List<FileModel>?>> postLaporankuFiles(File file);
}
