import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/core/network/urls.dart';

import '../cache/local_storage.dart';

@Deprecated("Config in use is lib/src/core/network/graphql_confiq.dart")
class GraphQlConfig {
  GraphQlConfig._privateContructor();

  static GraphQlConfig instance = GraphQlConfig._privateContructor();
  static final token = VModelSharedPrefStorage().getString('token');
  static HttpLink httpLink = HttpLink(VUrls.baseUrl,
      defaultHeaders: {'Authorization': 'Bearer $token'});

  GraphQLClient client() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}
