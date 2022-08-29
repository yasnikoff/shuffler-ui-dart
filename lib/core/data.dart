import 'dart:async';

import 'dart:convert';
import 'package:shuffler_web_ui/core.dart';

abstract class Data extends Service {

  Data(Server server):super(server);

  String get json => JSON.encode(data);

  set json(String value){
    var _data = JSON.decode(value);
//    print("json:$value \nset data: ${_data} to $this");
    data = _data;
  }

  dynamic toJson(){
    return data;
  }

  dynamic get data;
  set data(dynamic value);

  Future<Null> load({String path, Map params}) async {
//    print("loading: path: '$path', params:'$params'");

    json = await loadJson(path:path, params:params);
    onLoaded.add(null);
  }

  Future<Null> save({Object data, String path}) async{
    data ??= this;
    try{
      await postJson(data, path:path);
    }catch(e){
      print("can't save ${data}: $e");
    }
    await load();
  }

  String toString() => "${data}";
}
