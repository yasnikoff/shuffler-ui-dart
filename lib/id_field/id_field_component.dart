// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:shuffler_web_ui/core.dart';

@Component(
    selector: 'id-field',
    templateUrl: 'id_field_component.html',
    styleUrls: const ['id_field_component.css'],
)
class IdField implements AfterViewInit {

  @Input() ID value;
  @Input() bool readonly = true;
  @Input() String placeholder = "ID";
  InputElement _inputElement;
  @ViewChild('main') ElementRef shidInput;
  @Output() EventEmitter change = new EventEmitter();

  IdField();

  void onClick() {
    _inputElement.select();
  }

  clear() {
    _inputElement.value = "";
    value=null;
  }

  onChange() {
    try {
      ID newValue = new ID(_inputElement.value);
      value = newValue;
    } catch (e) {
      _inputElement.value = "$value"; //TODO: why?
    }
    change.emit(null);
  }

  @override
  ngAfterViewInit() {
    _inputElement = shidInput.nativeElement;
  }

}
