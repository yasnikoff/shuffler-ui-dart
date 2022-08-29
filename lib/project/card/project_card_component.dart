// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/id_field/id_field_component.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';
import 'package:shuffler_web_ui/project/collection/project_collection_service.dart';

import '../project_service.dart';
import'../thumb/project_thumb_component.dart';

@Component(
    selector: 'project-card',
    templateUrl: 'project_card_component.html',
    styleUrls: const ['project_card_component.css'],
    providers: const [ProjectCollection, ProjectService],
    directives: const[IdField, ProjectThumb]
)
class ProjectCard implements OnInit {

  @Input() ID id;

  ProjectService project;
  ProjectCollectionComponent _collectionCmp;

  ProjectCard(this.project, this._collectionCmp);


  @override
  ngOnInit() {
    project.loadId(id);
  }

  static const int _middleButton = 1;

  bool _isNewTabClick(MouseEvent event){
//    print("event.button: ${event.button}");
//    print("event.buttons:${event.buttons}");
    return event.button == _middleButton || event.ctrlKey;
  }


  onClick(MouseEvent event) {
    bool newTab =false;
    if(_isNewTabClick(event)){
      newTab = true;
      event.preventDefault();
    }
    _collectionCmp.navigateToProject(id, newTab: newTab, addToRecent: true);
  }
}


