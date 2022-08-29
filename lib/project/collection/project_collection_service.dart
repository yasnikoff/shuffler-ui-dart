
import 'dart:async';
import 'dart:convert';
import "package:angular2/core.dart";
import "package:shuffler_web_ui/core.dart";
import "package:shuffler_web_ui/repo/repo_service.dart";

@Injectable()
class ProjectCollection extends Data{

  @override
  var data;

  @override
  String get pathSegment => "projects";

  RepoService repo;

  ProjectCollection(RepoService repo) :super(repo){
    this.repo = repo;
  }

  Future<ID> newProject(String path, {String name}) async{
    String jsonResp = await postJson({"path":path, "name":name});
    var data = JSON.decode(jsonResp);
    return new ID(data['id']);
  }
}
