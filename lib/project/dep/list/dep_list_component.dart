// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/project/dep/dep_service.dart';

import'../dep/dep_component.dart';


@Component(
    selector: 'dep-list',
    templateUrl: 'dep_list_component.html',
    styleUrls: const ['dep_list_component.css'],
    directives: const[DepComponent],
    )
class DepList implements OnInit {

  DepCollection model;

  DepList(this.model);

  ngOnInit() {
  }

  get deps => model?.items?.values;

}
