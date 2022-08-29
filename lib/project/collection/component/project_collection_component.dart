// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:angular2/platform/common.dart';


import '../../component/project_component.dart';
import '../project_collection_service.dart';
import '../details/project_collection_details_component.dart';
import '../../create/project_create_component.dart';


@Component(
    selector: 'project-collection',
    templateUrl: 'project_collection_component.html',
    styleUrls: const ['project_collection_component.css'],
    directives: const[ROUTER_DIRECTIVES],
    providers: const[ProjectCollection, ProjectCollectionDetails],
    )
@RouteConfig(
    const[
      const Route(name:"Projects", path: "/", component: ProjectCollectionDetails, useAsDefault: true),
      const Route(
          name: "Project", path: "/:id/...", component: ProjectComponent),
      const Route(name: "New", path:"/new", component:ProjectCreateComponent)
    ]
)
class ProjectCollectionComponent
    implements OnInit {

  ProjectCollection model;
  Router router;
  LocationStrategy _locStrategy;


  ProjectCollectionComponent(this.model, this.router, this._locStrategy);

  ngOnInit() {}

  _navigate(List linkParams, {bool newTab: false}){
    if (newTab) {
      // TODO: find better way to respect LocationStrategy.
      String url = router.generate(linkParams).toLinkUrl();
      if (_locStrategy is HashLocationStrategy) {
        url = "/#/${url}";
      }
      window.open(url, "_blank");
    } else {
      router.navigate(linkParams);
    }
  }

  navigateToProject(ID id, {bool newTab: false, bool addToRecent:false}) {
    _navigate(["Project", {"id":"${id}", "addToRecent":addToRecent}], newTab:newTab);
  }
  navigateToProjects(String query, {bool newTab: false}){
    _navigate(["Projects", {"query":query}], newTab:newTab);
  }
}
