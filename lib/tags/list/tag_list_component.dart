// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import '../tags_service.dart';
import '../tag/tag_component.dart';

@Component(
    selector: 'tag-list',
    templateUrl: 'tag_list_component.html',
    styleUrls: const ['tag_list_component.css'],
    directives: const[TagComponent],
    providers: const[TagService])
class TagList implements OnInit {

  TagService model;

  TagList(this.model);

  ngOnInit() async {
    await model.load();
  }

  int get length {
    return model?.length ?? 0;
  }

}
