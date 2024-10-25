import 'dart:io';

import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';
import 'package:css_mobile/data/model/storage/storage_model.dart';

abstract class StorageRepository {
  Future<DefaultResponseModel<StorageModel?>> postStorage(File file);
  Future<DefaultResponseModel<List<CcrfFileModel>?>> postCcrfFile(
      Map<String, String> files);
}
