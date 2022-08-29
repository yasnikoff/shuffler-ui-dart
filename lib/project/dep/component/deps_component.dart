// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/project/dep/dep_service.dart';


@Component(
    selector: 'deps',
    templateUrl: 'deps_component.html',
    styleUrls: const ['deps_component.css'],
    providers: const[DepCollection],
    )
class DepsComponent implements OnInit {

  DepCollection model;

  DepsComponent(this.model);

  ngOnInit() async{
    await model.load();
  }

}
