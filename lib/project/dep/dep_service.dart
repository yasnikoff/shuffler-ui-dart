import 'dart:collection';

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/project/project_service.dart';


@Injectable()
class DepCollection extends Data {

  DepCollection(ProjectService server) : super(server);

  SplayTreeMap<String, Dep> items;


  @override
  String get pathSegment => "dependencies";

  @override
  Object get data => items;

  @override
  set data(value) {
    if (items == null)
      items = new SplayTreeMap();
    else
      items.clear();

    (value as Map).forEach((key, value) {
      items[key] = new Dep(this, path: key, data: value);
    });
  }

  int get length => items?.length ?? 0;

  ProjectService get project => server;

  update() {
    postJson({"path":""}, path: "update");
  }

  add(String path, String depType, dynamic depData){
    save(data: {"path":path, "type":depType, "dep":depData}, path: "add");
  }
}

class Dep extends Data {

  Dep(DepCollection server, {String path, dynamic data}) : super(server) {
    if (data != null) this.data = data;
    if (path != null) depPath = path;
  }

  String depPath;
  String depType;
  DepData depData;

  DepCollection get collection => server;

  @override
  dynamic get data => {"path":depPath, "type":depType, "data":depData};

  @override
  String get pathSegment => "";

  @override
  set data(dynamic value) {
    depPath = value['path'];
    depType = value['type'];
    switch (depType) {
      case 'descriptor':
        depData = new Descriptor(value['data'], this);
    }
  }

  update() {
    postJson(data, path: "update");
  }

  remove() {
    postJson({"path":depPath}, path: "remove").then((_) {
      collection.load();
    });
  }

  replace(ID newID) {
    save(data: {"path":depPath, "id":"$newID"});
  }

}

abstract class DepData {
  ID get id;

  Dep _dep;
}

class Descriptor extends DepData {

  Descriptor(dynamic data, Dep dependency) {
    this.data = data;
    this._dep = dependency;
  }

  ID id;

  dynamic get data => {'id':id};

  set data(dynamic value) {
    id = new ID(value['id']);
  }

  String toString() => "$data";

  replace(String newId) {
    _dep.collection.postJson(
        {"path":_dep.depPath, "id":"$newId"}, path: "replace").then((_){
      _dep.collection.load();
    });
  }
}
