import 'package:http/http.dart';
import 'package:meta/meta.dart';

class HttpClient {
  final Client httpClient;
  final String baseUrl;
  final String apiKey;

  HttpClient({
    @required this.httpClient,
    @required this.baseUrl,
    @required this.apiKey,
  });

  Future<Response> get(String path) {
    return httpClient.get(_buildUri(path));
  }

  Uri _buildUri(String path) {
    final uri = Uri.parse(baseUrl);
    final queryParameters = {'api_key': apiKey};

    uri.replace(path: path, queryParameters: queryParameters);
    return uri;
  }
}
