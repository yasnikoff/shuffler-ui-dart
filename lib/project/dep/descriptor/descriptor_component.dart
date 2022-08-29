// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/project/project_service.dart';
import 'package:shuffler_web_ui/project/thumb/project_thumb_component.dart';
import 'dart:html';

import '../dep_service.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';


@Component(
    selector: 'descriptor',
    templateUrl: 'descriptor_component.html',
    styleUrls: const ['descriptor_component.css'],
    directives: const[ProjectThumb],
    providers: const[ProjectService],
    )
class DescriptorComponent implements OnInit {

  DescriptorComponent(this.project, this._collection);

  ProjectService project;
  ProjectCollectionComponent _collection;
  @Input() Descriptor model;


  ngOnInit() async {
    await project.loadId(model.id);
  }

  click(Event event){
    event.preventDefault();
    open();
  }

  open(){
    _collection.navigateToProject(model.id);
  }

}
