import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'hero.dart';

@Injectable()
class HeroSearchService {
  final BrowserClient _http;

  HeroSearchService(this._http);

  Future<List<Hero>> search(String term) async {
    try {
      final response = await _http.get('http://localhost:3000/heroes.json');
      return _extractData(response)
          .map((json) => new Hero.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body);

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
