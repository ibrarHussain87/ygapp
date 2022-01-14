class FamilyData {
  FamilyData(this.id,this._imageUrl, this._unselectedImage, this._familyName);
  int id;
  String _imageUrl;
  String _unselectedImage;
  String _familyName;
  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get unselectedImage => _unselectedImage;

  set unselectedImage(String value) {
    _unselectedImage = value;
  }

  String get familyName => _familyName;

  set familyName(String value) {
    _familyName = value;
  }
}