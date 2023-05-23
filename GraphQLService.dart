import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final String _baseUrl = 'https://example.com/graphql';

  late Dio _dio;
  late GraphQLClient _client;

  GraphQLService() {
    _dio = Dio();
    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(_baseUrl, httpClient: _dio),
    );
  }

  Future<QueryResult> performQuery(String query, {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    final result = await _client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    return result;
  }
}

