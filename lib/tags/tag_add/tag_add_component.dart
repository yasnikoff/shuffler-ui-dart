// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/tags/tags_service.dart';
import 'dart:html';

@Component(
  selector: 'tag-add',
  templateUrl: 'tag_add_component.html',
  styleUrls: const ['tag_add_component.css'])
class TagAdd implements AfterViewInit {

  EventEmitter<Tag>add = new EventEmitter<Tag>();
  InputElement inputElement;
  @ViewChild("InputElement") ElementRef inputElementRef;

  TagAdd();

  ngAfterViewInit() {
    inputElement = inputElementRef.nativeElement;
  }

  onAdd(event){
    String name = event.target.value;
    inputElement.value = "";
    if(name.trim()=="")return;
    add.emit(new Tag(name));
  }

}
