import 'dart:async';

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';

@Injectable()
abstract class Service implements Server {

  Server server;

  @Output() final StreamController onLoaded = new StreamController();

  Stream get loaded => onLoaded.stream;

  Service(this.server);

  String get pathSegment;

  @override
  Path get path {
    return server.path.child(pathSegment);
  }

  Future<String> loadJson({String path, Map params}) async {
    if (server is Service) {
      await (server as Service).loaded;
    }
    return server.loadJson(
        path: this.path.child(path).url(trailingSlash: true),
        params: params);
  }

  Future<String> postJson(Object data, {String path}) async {
    if (server is Service) {
      await (server as Service).loaded;
    }
    return server.postJson(
        data, path: this.path.child(path).url(trailingSlash: true));
  }

}
