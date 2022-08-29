// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import '../tags_service.dart';

@Component(
  selector: 'tag',
  templateUrl: 'tag_component.html',
  styleUrls: const ['tag_component.css'])
class TagComponent {

  @Input() Tag model;
  TagComponent();

  remove(){
    model.list.remove([model]);
  }
}
