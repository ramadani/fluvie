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

  Future<Response> get(String path, {Map<String, dynamic> queryParams}) {
    return httpClient.get(_buildUri(path, queryParams: queryParams));
  }

  Uri _buildUri(String path, {Map<String, dynamic> queryParams}) {
    final Map<String, dynamic> queryParameters = {'api_key': apiKey};
    queryParameters.addAll(queryParams);

    final uri = Uri.parse(baseUrl);

    return uri.replace(
        path: "${uri.path}$path", queryParameters: queryParameters);
  }
}
