
class PostModel {

  String _title;
  String _description;
  List<String> _imgUrls;

  PostModel(this._title, this._description, this._imgUrls);

  List<String> get imgUrls => _imgUrls;

  set imgUrls(List<String> value) {
    _imgUrls = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}