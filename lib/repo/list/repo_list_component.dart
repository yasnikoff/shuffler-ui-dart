// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/repo/repo_service.dart';

@Component(
    selector: 'repo-list',
    templateUrl: 'repo_list_component.html',
    styleUrls: const ['repo_list_component.css']
, directives: const[ROUTER_DIRECTIVES]
)
class RepoList implements OnInit {
  Server _server;
  Router _router;
  Map<String, String> repos;

  RepoList(this._server, this._router);

  Future<Null> ngOnInit() async {
    this.repos = await RepoService.getRepos(_server);
  }

  openRepo(String name) {
    _router.navigate(['Repo', {'repo':name}]);
  }
}
