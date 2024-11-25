import 'dart:io';

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_count_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/storage/ccrf_file_model.dart';

abstract class EclaimRepository {
  Future<BaseResponse<List<EclaimModel>>> getEclaim(QueryParamModel param);

  Future<BaseResponse<EclaimCountModel>> getEclaimCount(QueryParamModel param);

  Future<BaseResponse<List<String>>> getEclaimStatus();

  Future<BaseResponse<List<CcrfFileModel>>> postEclaimImage(File photo);

  Future<BaseResponse<EclaimModel>> postEclaim(EclaimModel data);
}
