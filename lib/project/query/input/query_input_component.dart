// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/core.dart';
import 'package:shuffler_web_ui/project/query/query_service.dart';

const OpaqueToken QUERY = const OpaqueToken('query');

@Component(
    selector: 'query-input',
    templateUrl: 'query_input_component.html',
    styleUrls: const ['query_input_component.css'],
    providers: const[QueryService],
    )
class ProjectsQueryInput implements OnInit, AfterViewInit {

  ProjectsQueryInput(this.service, @Inject(QUERY) query) {
    this._query = query;
  }

  QueryService service;
  @ViewChild('query') ElementRef queryInputRef;

  String _query;
  InputElement queryInput;
  @Output() EventEmitter<String> onChange = new EventEmitter<String>();
  @Output() EventEmitter<List<ID>> onResultLoaded = new EventEmitter<List<ID>>();


  ngOnInit() {
//    loadResult(_query);

    if (!service.isValidQuery(_query)) {
      return;
    }
//    print("QueryInputComponent.onInit(): _query: $_query");
    service.load(_query).then((List<ID> result) {
//      print("QueryInputComponent: rsult loaded: $result");
      onResultLoaded.emit(result);
    });
  }

  @override
  ngAfterViewInit() {
    queryInput = queryInputRef.nativeElement;
    queryInput?.value = _query;
    queryInput.onChange.listen((Event event){
      onQueryInputChange(queryInput.value);
    });
  }

//  String get query => _query;

  /*set query(String newValue) {
    if (!service.isValidQuery(newValue)) {
      return;
    }
    _query = newValue;
    change.emit(newValue);

    loadResult();
  }*/
/*
  loadResult(String query) {

  }*/

  onQueryInputChange(String value) {
    print("QueryInputComponent.onQueryChange($value);");
    print("type of value: ${value.runtimeType}");
    onChange.emit(value);
  }

  clear() {
    onChange.emit('');
  }

}

