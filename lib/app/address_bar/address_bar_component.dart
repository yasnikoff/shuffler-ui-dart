// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:path/path.dart';

@Component(
    selector: 'address-bar',
    templateUrl: 'address_bar_component.html',
    styleUrls: const ['address_bar_component.css'])
class AddressBar implements OnInit {

  Router _router;
  dynamic debugValue;
  List<Part> _parts = [];
  Context pathContext = new Context(style:Style.url);

  AddressBar(this._router);

  ngOnInit() {
    _router.subscribe((String path) {

      List<String> pathAndQuery = path.split(";");
      List<String> parts = pathContext.split(pathAndQuery[0]);
      _parts.clear();

      for (int i = 0; i < parts.length; i++) {
        _parts.add(new Part(Uri.decodeComponent(parts[i]), joinAll(parts.take(i+1))));
      }
    });
  }

  List<Part> get parts {
    return _parts;
  }
}

class Part {
  final String name;
  final String link;

  Part(this.name, this.link);
}
