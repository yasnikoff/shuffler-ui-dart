import 'package:path/path.dart';

class Path {
  String segment;
  Path parent;

  Path(this.segment, {this.parent});

  Path child(String segment) {
    if(segment==null || segment=="")return this;
    return new Path(segment, parent: this);
  }

  String toString() => join(parent?.toString() ?? "", segment);

  static String query(Map params) {
    if (params == null) return "";
    String result = "";
    var segments = new List<String>();
    params.forEach((name, val) {
      if(val==null || name==null || name=="")return;
      segments.add("${Uri.encodeQueryComponent(name)}=${Uri.encodeQueryComponent(val)}");
    });
    result = segments.join("&");

    if (result.trim() != "") {
      result = "?" + result;
    }
    return result;
  }

  String url({Map params, bool trailingSlash:false}) {
    String path = toString();

    if (trailingSlash && !path.endsWith("/") && (params == null || params?.length == 0)) {
      path += "/";
    }

    return path + query(params);
  }
}
