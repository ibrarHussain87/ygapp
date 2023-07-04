class DetailTileModel {
  String _title;
  String _detail;

  DetailTileModel(this._title, this._detail);

  String get detail => _detail;

  set detail(String value) {
    _detail = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}