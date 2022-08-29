// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import '../dep_service.dart';

@Component(
    selector: 'dep-controls',
    templateUrl: 'dep_controls_component.html',
    styleUrls: const ['dep_controls_component.css'])
class DepControls {

  DepCollection model;

  DepControls(this.model);

}
