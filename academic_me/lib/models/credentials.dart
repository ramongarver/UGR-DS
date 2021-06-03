import 'dart:convert';


class Credentials {
  static String baseAddress = 'clados.ugr.es';
  static String applicationName = 'DS6/api/v1/';

  static String username = 'admin';
  static String password = 'admin';
  static String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
