// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';
import 'package:shuffler_web_ui/repo/details/repo_details_component.dart';
import 'package:shuffler_web_ui/repo/repo_service.dart';
import 'package:shuffler_web_ui/html/doc_title_mixin.dart';
import 'package:shuffler_web_ui/core.dart';

@Component(
    selector: 'repo',
    templateUrl: 'repo_component.html',
    styleUrls: const ['repo_component.css'],
    directives: const[
      RepoDetails,
      ROUTER_DIRECTIVES
    ],
    providers: const[
      RepoService,
    ]
)
@RouteConfig(
    const[
      const Route(path: "/", component: RepoDetails),
      const Route(name: "Projects",
          path: "projects/...",
          component: ProjectCollectionComponent,
          useAsDefault: true),
    ]
)
class RepoComponent extends ComponentBase with DocTitle
    implements OnInit {

  RepoService model;
  RouteParams params;

  RepoComponent(this.model, this.params);

  ngOnInit() {
    model.name = params.get('repo');
//    this.title = model.name;
  }

}


