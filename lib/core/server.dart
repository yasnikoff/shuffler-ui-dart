import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular2/core.dart';

import 'path.dart';

const HOST = const OpaqueToken('ServerUrl');
//const PORT = const OpaqueToken('ServerPort');

@Injectable()
class Server {

  Server(@Inject(HOST) this._host,
//      @Inject(PORT) this._port
      );

  String _host;
//  int _port;

  Path get path {
    return new Path("http://$_host/api/");
  }

  Future<String> loadJson({String path, Map params}) async {
    String url = this.path.child(path).url(params: params);
//    print("getting url: $url");
    return HttpRequest.getString(url);
  }

  Future<String> postJson(dynamic data, {String path}) async {
    var jsonData = JSON.encode({"data":data});
    String url = this.path.child(path).url();
//    print("posting to $url: \n$jsonData");
    HttpRequest r = await HttpRequest.request(url,
        sendData: jsonData,
        method: "POST",
        mimeType: "application/json").catchError((err) {
      print("error saving data: $err");
    });

    return r.responseText;
  }
}
