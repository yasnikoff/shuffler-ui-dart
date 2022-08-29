// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/src/common/forms.dart';
import 'package:shuffler_web_ui/project/dep/deps.dart';
import 'package:shuffler_web_ui/tags/tags.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/html/doc_title_mixin.dart';

import '../component/project_component.dart';
import '../project_service.dart';
import '../thumb/project_thumb_component.dart';

@Component(
    selector: 'project-details',
    templateUrl: 'project_details_component.html',
    styleUrls: const ['project_details_component.css'],
    directives: const[
      ProjectThumb, TAG_DIRECTIVES, DEP_DIRECTIVES, FORM_DIRECTIVES],
    providers: const [
      const Provider(Owner, useExisting: ProjectService)
    ],
    )
class ProjectDetails
    extends ComponentBase
    with DocTitle
    implements AfterViewInit, OnInit {

  ProjectService model;
  ProjectComponent cmp;


  @ViewChild(TagList) TagList tagList;
  @ViewChild(TagAdd) TagAdd tagAdd;

  ProjectDetails(this.cmp) {
    model = cmp.model;
  }

  ngOnInit() async {
    await model.load(params: {"addToRecent":"true"});

    var title = model.name;
    if (title == "") title = "${model.id}";
    if (title == "") title = "project";
    this.title=title;
  }

  ngAfterViewInit() {
    tagAdd.add.listen((Tag tag) {
      this.tagList.model.add([tag]);
    });
  }

  formSubmit() {
    model.save();
  }

  openInExplorer() {
    model.loadJson(path: "open");
  }

  openDuplicate() {
    cmp.router.navigate(["Duplicate"]);
  }
}
