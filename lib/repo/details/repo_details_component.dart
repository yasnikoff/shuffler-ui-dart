// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/repo/repo_service.dart';
import 'package:shuffler_web_ui/id_field/id_field_component.dart';
import 'package:shuffler_web_ui/project/list/project_list_component.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/html/doc_title_mixin.dart';

@Component(
    selector: 'repo-details',
    templateUrl: 'repo_details_component.html',
    styleUrls: const ['repo_details_component.css'],
    directives: const [ROUTER_DIRECTIVES, IdField, ProjectList],
    providers: const [ProjectList])
class RepoDetails extends ComponentBase
    with DocTitle
    implements OnInit {

  RepoService model;
  ProjectList projectList;

  RepoDetails(this.model, this.projectList);

  Future<Null> ngOnInit() async {
    await model.load();
    this.title=model.name;
    await model.loadRecent();
  }

   List<ID> get projects{
    return model.projects;
  }

}
