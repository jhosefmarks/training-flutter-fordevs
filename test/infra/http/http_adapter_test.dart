import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordevs/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body
  }) async {
    final headers = { 
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }

    return null;
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    PostExpectation mockRequest() =>
      when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode, { String body: '{"any_key":"any_value"}' }) =>
      mockRequest().thenAnswer((_) async => Response(body, statusCode));

    setUp(() {
      mockResponse(200);
    });

    test('Should calls post with correct values', () async {
      await sut.request(url: url, method: 'post', body: { 'any_key': 'any_value' });

      verify(client.post(
        url,
        headers: { 
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: '{"any_key":"any_value"}'
      ));
    });

    test('Should calls post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(
        any,
        headers: anyNamed('headers')
      ));
    });

    test('Should return data if post returns 200', () async {
      final future = await sut.request(url: url, method: 'post');

      expect(future, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final future = await sut.request(url: url, method: 'post');

      expect(future, null);
    });

    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');

      final future = await sut.request(url: url, method: 'post');

      expect(future, null);
    });

    test('Should return null if post returns 204 with data', () async {
      mockResponse(204);

      final future = await sut.request(url: url, method: 'post');

      expect(future, null);
    });
  });
}