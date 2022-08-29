// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import '../collection/project_collection_service.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';

@Component(
  selector: 'create',
  templateUrl: 'project_create_component.html',
  styleUrls: const ['project_create_component.css'])
class ProjectCreateComponent implements OnInit {

  ProjectCollectionComponent _collectionCmp;
  ProjectCollection _collection;
  ProjectCreateComponent(this._collectionCmp, this._collection);

  String path;
  String name;

  ngOnInit() {

  }

  create() async{
    ID newID = await _collection.newProject(path, name:name);
    _collectionCmp.navigateToProject(newID);
  }

}
