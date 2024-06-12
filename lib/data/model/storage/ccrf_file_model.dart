class CcrfFileModel {

  String _fileType = "";
  String get fileType => _fileType;

  String _fileUrl = "";
  String get fileUrl => _fileUrl;

  CcrfFileModel.fromJson(dynamic json) {
    _fileType = json["file_type"];
    _fileUrl = json["file_url"];
  }

}