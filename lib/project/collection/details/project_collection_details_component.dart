// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';

import '../../query/input/query_input_component.dart';
import 'package:shuffler_web_ui/project/list/project_list_component.dart';

@Injectable()
String queryFromRouteParams(RouteParams params){
//  print("query from route params: '${params.get('query') ?? ""}'");
  return params.get('query') ?? "";
}

@Component(
    selector: 'project-collection-details',
    templateUrl: 'project_collection_details_component.html',
    styleUrls: const ['project_collection_details_component.css'],
    directives: const[ROUTER_DIRECTIVES, ProjectsQueryInput, ProjectList],
    providers: const[const Provider(QUERY, useFactory: queryFromRouteParams)],
    )
class ProjectCollectionDetails
    implements OnInit {

  List<ID> projects = [];
  Router _router;

  ProjectCollectionDetails(this._router);

  ngOnInit() {}

  loadProjects(String query){
//    print("ProjectCollectionDetailsComponent.loadProjects($query);");
//    print("event type: ${query.runtimeType}");
    _router.navigate(["Projects",{"query":query}]);
  }
  onResultLoaded(List<ID> result){
//    print("ProjectCollectionDetails.onResultLoaded: result: $result");
    projects = result;
  }
}
