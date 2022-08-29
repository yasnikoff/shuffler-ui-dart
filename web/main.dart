// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:shuffler_web_ui/app/component/app_component.dart';
import 'package:shuffler_web_ui/core/server.dart' as server;

const bool productionMode = true;

main() {
  if (productionMode) {
        disableDebugTools();
//  print("hostname: ${window.location.hostname}");
//  print("port: ${window.location.port}");
//  print("port parsed: ${int.parse(window.location.port)}");

    bootstrap(App,
        [
          ROUTER_PROVIDERS,
          provide(LocationStrategy, useClass: HashLocationStrategy),
          provide(server.HOST, useValue: "${window.location.host}"),
        ]
    );
  } else {
    bootstrap(App,
        [
          ROUTER_PROVIDERS,
          provide(LocationStrategy, useClass: HashLocationStrategy),
          provide(server.HOST, useValue: "localhost:7474"),
        ]
    );
  }
}
