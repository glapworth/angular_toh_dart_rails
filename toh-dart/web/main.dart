import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2_tour_of_heroes/app_component.dart';
import 'package:http/http.dart';


import 'package:http/browser_client.dart';


void main() {
  bootstrap(AppComponent, [
    provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])
  ]);
  // Simplify bootstrap provider list to [BrowserClient]
  // once there is a fix for:
  // https://github.com/dart-lang/angular2/issues/37
}

