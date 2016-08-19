import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'hero.dart';

@Injectable()
class HeroService {
  static final _headers = {'Content-Type': 'application/json'};
  static const _heroesUrl = 'http://localhost:3000/heroes.json'; // URL to web API

  final BrowserClient _http;

  HeroService(this._http);

  Future<List<Hero>> getHeroes() async {
    try {
      final response = await _http.get(_heroesUrl);
      final heroes = _extractData(response)
          .map((value) => new Hero.fromJson(value))
          .toList();
      return heroes;
      } catch (e) {
        throw _handleError(e);
     }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body);

  /*
    Future<Hero> getHero(int id) async =>
      (await getHeroes()).firstWhere((hero) => hero.id == id);
  */
  
  Future<Hero> getHero(int id) async {
    try {
      final response = await _http.get('http://localhost:3000/heroes/${id}.json');
      final hero = new Hero.fromJson(_extractData(response));
//          .map((value) => new Hero.fromJson(value));
      return hero;
    } catch (e) {
        throw _handleError(e);
    }
  }

  Future<Hero> save(dynamic heroOrName) =>
      heroOrName is Hero ? _put(heroOrName) : _post(heroOrName);

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

  Future<Hero> _post(String name) async {
    try {
      final response = await _http.post(_heroesUrl,
          headers: _headers, body: JSON.encode({'name': name}));
      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> _put(Hero hero) async {
    try {
      var url = 'http://localhost:3000/heroes/${hero.id}';
      final response =
          await _http.put(url, headers: _headers, body: JSON.encode(hero));
      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    try {
      var url = 'http://localhost:3000/heroes/${id}';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
