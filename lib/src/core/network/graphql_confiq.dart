import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/core/network/urls.dart';

import '../cache/credentials.dart';

class GraphQlConfig {
  GraphQlConfig._privateConstructor();

  /**
  static GraphQlConfig instance = GraphQlConfig._privateContructor();
  static final token = VModelSharedPrefStorage().getString('token');
  static AuthLink authLink = AuthLink(getToken: () async {
    // if (token.isEmpty) {
    // token = await VModelSharedPrefStorage().getString('token') ?? '';
    // token =  (await VCredentials.inst.getUserCredentials() ?? '') as String;
    // }
    // return 'Bearer $token';
    return 'Bearer ${await token}';
  });
      */

  static String _restToken = '';
  static String get restToken => _restToken;
  static GraphQlConfig instance = GraphQlConfig._privateConstructor();
  // static final token = VModelSharedPrefStorage().getString('token');
  static var _token = VCredentials.inst.getUserCredentials();
  static get token => _token;
  // static String token = '';
  // late HiveStore store;
  // GraphQlConfig._privateConstructor() {
  //    store = HiveStore.open(path: 'my/cache/path');
  // }

  static AuthLink authLink = AuthLink(getToken: () async {
    final String? tk = await token;
    if (tk == null || tk.isEmpty) {
      // token = await VModelSharedPrefStorage().getString('token') ?? '';
      // token =  (await VCredentials.inst.getUserCredentials() ?? '') as String;
    }
    return 'Bearer $tk';
  });

  static Link link = authLink.concat(httpLink);
  static HttpLink httpLink = HttpLink(
    VUrls.baseUrl,
  );
  GraphQLClient client() {
    return GraphQLClient(link: link, cache: GraphQLCache());
    // return GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));
  }

  // initH

  updateToken(String newToken) {
    _token = Future.value(newToken);
  }

  updateRestToken(String newToken) {
    _restToken = newToken;
    VCredentials.inst.setRestToken(_restToken);
  }
}
