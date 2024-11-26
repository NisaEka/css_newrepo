class FileModel {
  String _fileType = "";
  String get fileType => _fileType;

  String _fileUrl = "";
  String get fileUrl => _fileUrl;

  FileModel.fromJson(dynamic json) {
    _fileType = json["fileType"];
    _fileUrl = json["fileUrl"];
  }
}
