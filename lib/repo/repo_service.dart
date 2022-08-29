// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:convert';
import 'dart:async';
import "package:angular2/core.dart";
import 'package:shuffler_web_ui/core.dart';

@Injectable()
class RepoService extends Data{

  static Future<Map<String, String>> getRepos(Server server) async {
    final String json = await server.loadJson();
    Map<String, String>repoMap = JSON.decode(json);
    return repoMap;
  }

  String _name;
  List<ID>projects=new List<ID>();
  RepoService repo;

  RepoService(Server server):super(server){
    this.repo = repo;
  }

  String get name{
    return _name;
  }

  set name(String value){
    _name = Uri.decodeComponent(value);
  }


  String get pathSegment{
    return Uri.encodeComponent(_name);
  }


  dynamic get data{
    return {};
  }

  @override
  set data(value) {
    // TODO: implement data
  }


  loadName(String name)async{
    this.name = name;
    await load();
  }

  Future<Null>loadRecent()async{
    // TODO: delegate the functionality to a query when the query is implemented
    projects.clear();
    String recentJson = await loadJson(path:"projects", params:{"query":""});
    List<String>resentStrList = JSON.decode(recentJson);
    resentStrList.forEach((String idString){
      projects.add(new ID(idString));
    });
  }

  Future updateIndex([String path]){
    return postJson({"path":path}, path:"index/update");
  }

}
