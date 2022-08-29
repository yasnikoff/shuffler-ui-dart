// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/project/project_service.dart';

@Component(
    selector: 'project-thumb',
    templateUrl: 'project_thumb_component.html',
    styleUrls: const ['project_thumb_component.css'])
class ProjectThumb implements AfterViewInit {

  ProjectService project;
  @Input() String size = "64px";
  @ViewChild('img') ElementRef imgElementRef;
  ImageElement img;

  ProjectThumb(this.project);

  ngAfterViewInit() {
    img = imgElementRef.nativeElement;
    project.loaded.listen((_) => img.src = project.previewPath);
  }

  String get sizeStyle => size;

}
