// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import '../dep_service.dart';
import '../descriptor/descriptor_component.dart';
import 'package:shuffler_web_ui/project/collection/component/project_collection_component.dart';

@Component(
  selector: 'dep',
  templateUrl: 'dep_component.html',
  styleUrls: const ['dep_component.css'],
    directives: const[DescriptorComponent],
    )
class DepComponent implements OnInit {

  DepComponent(this._collection);

  @Input() Dep model;
  ProjectCollectionComponent _collection;

  ngOnInit() {}

  open(){
    _collection.navigateToProject(model.depData.id);
  }

}
