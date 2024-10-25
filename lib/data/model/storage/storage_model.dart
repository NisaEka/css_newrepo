class StorageModel {
  String _fileId = "";
  String get fileId => _fileId;

  String _fileRelativePath = "";
  String get fileRelativePath => _fileRelativePath;

  String _fileAbsolutePath = "";
  String get fileAbsolutePath => _fileAbsolutePath;

  StorageModel.fromJson(dynamic json) {
    _fileId = json["file_id"];
    _fileRelativePath = json["file_relative_path"];
    _fileAbsolutePath = json["file_absolute_path"];
  }
}
