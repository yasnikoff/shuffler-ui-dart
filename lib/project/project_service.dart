// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import "package:angular2/core.dart";
import "package:shuffler_web_ui/core.dart";
import "package:shuffler_web_ui/repo/repo_service.dart";
import "../tags/tags_service.dart" as tags;
import "./collection/project_collection_service.dart";


@Injectable()
class ProjectService extends Data with tags.Owner implements Server  {

  ID id;
  String name = "";
  ID origin;
  String projectPath;
  RepoService get repo => collection?.repo;
  ProjectCollection collection;

  ProjectService(ProjectCollection collection) :super(collection){
    this.collection = collection;
  }

  String get pathSegment => "$id";

  loadId(ID id, {bool addToRecent:false}) async {
    this.id = id;
    await load(params:{"addToRecent":"$addToRecent"});
  }

  @override
  get data{
    return {
      "name":name,
      "origin":origin,
      "path":projectPath
    };
  }

  @override
  set data(dynamic data){
    name = data['name'];
    origin = new ID(data['origin']);
    projectPath = data['path'];
  }

  String get previewPath {
    return path.child("preview").url(trailingSlash: true);
  }

  Future<ID> duplicate(String newPath, {String newName})async{
//    print("ProjectService.duplicate($newPath,newName:$newName)");
    String respJson = await postJson({"name":newName, "path":newPath}, path:"duplicate");
    String resp = JSON.decode(respJson);
//    print("ProjectService.duplicate(): got newId:$resp");
    ID newID = new ID(resp);
    return newID;
  }

}
