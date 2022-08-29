// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/project/component/project_component.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';

@Component(
  selector: 'duplicate',
  templateUrl: 'project_duplicate_component.html',
  styleUrls: const ['project_duplicate_component.css'],
    providers:const[],
    )
class ProjectDuplicate extends Service implements OnInit {

  ProjectComponent cmp;
  ProjectCollectionComponent projects;

  ProjectDuplicate(ProjectComponent project, this.projects):super(project.model){
    cmp=project;
  }

  ngOnInit() {

  }

  @override
  String get pathSegment => "duplicate";

  duplicate(String newPath, String newName){
    cmp.model.duplicate(newPath, newName:newName).then((ID newID){
      projects.router.navigate(["Project", {"id":"$newID"}]);
    }).catchError((Error err){

    });
  }
}
