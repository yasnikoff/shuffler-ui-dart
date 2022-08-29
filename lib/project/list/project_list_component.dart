// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/repo/repo_service.dart';
import 'package:shuffler_web_ui/project/card/project_card_component.dart';

@Component(
    selector: 'project-list',
    templateUrl: 'project_list_component.html',
  directives: const[ROUTER_DIRECTIVES, ProjectCard],
    styleUrls: const ['project_list_component.css'])
class ProjectList implements OnInit {

  RepoService repo;

  @Input() List<ID> ids;

  ProjectList(this.repo);

  ngOnInit() {

  }

}
