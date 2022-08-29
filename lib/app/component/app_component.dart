// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/repo/component/repo_component.dart';
import 'package:shuffler_web_ui/repo/list/repo_list_component.dart';

import '../address_bar/address_bar_component.dart';


@Component(
    selector: 'app',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const[ROUTER_DIRECTIVES, AddressBar],
    providers: const[Server, RepoComponent,

    ])
@RouteConfig(
    const[
      const Route(
          path: "/repos/",
          name: "Repos",
          component: RepoList,
          useAsDefault: true),
      const Route(
          path: "/repos/:repo/...", name: "Repo", component: RepoComponent)
    ]
)
class App {
  App();
}
