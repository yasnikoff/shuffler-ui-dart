import 'dart:html';

class DocTitle {
  String _title;

  String get title => _title;

  set title(String value) {
    _title = value;
    document.title = value;
  }
}
