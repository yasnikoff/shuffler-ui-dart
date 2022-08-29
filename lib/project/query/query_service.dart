import 'dart:async';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';

import '../collection/project_collection_service.dart';

@Injectable()
class QueryService extends Service {
  ProjectCollection collection;
  List<ID>result = [];

  QueryService(ProjectCollection collection) :super(collection) {
    this.collection = collection;
  }

  @override
  String get pathSegment => "";

  Future<List<ID>>load(String query) async{
//    print("query_service query: $query");
    clear();
    var jsonString = await loadJson(params: {"query":query});
    List<String> value = JSON.decode(jsonString);
    value.forEach((str) {
      result.add(new ID(str));
    });
//    print("query_service.loadResult: result: $result");
    return result;
  }

  clear() {
    result.clear();
  }

  bool isValidQuery(String query){
    // TODO: implement query validation
    return true;
  }

}
