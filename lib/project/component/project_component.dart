// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/project/details/project_details_component.dart';
import 'package:shuffler_web_ui/project/duplicate/project_duplicate_component.dart';

import '../project_service.dart';


@Component(
    selector: 'project-input',
    templateUrl: 'project_component.html',
    styleUrls: const ['project_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [ProjectService]
)
@RouteConfig(
    const[
      const Route(path: "/", component: ProjectDetails, useAsDefault: true),
      const Route(name: "Duplicate", path: "duplicate", component: ProjectDuplicate),
    ]
)
class ProjectComponent
    implements OnInit {

  ProjectService model;
  RouteParams _params;
  Router router;

  ProjectComponent(this.model, this._params, this.router);

  ngOnInit() async{
    setParams(_params); // before async gap!
    // Otherwise children can load before params are set.

    await model.loaded;
  }

  setParams(RouteParams params) async{
    var idStr = params.get('id');
    if (idStr != null) {
      await model.loadId(new ID(idStr));
    }
  }

  String get origin=>model?.origin?.toString() ?? "";

  set origin(String value){
//    print("setting origin via project input: $value");
    model.origin.string = value;
//    print("model id: ${model.origin}");
  }


}
