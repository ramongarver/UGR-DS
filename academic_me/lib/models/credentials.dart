import 'dart:convert';


class Credentials {
  static String baseAddress = 'clados.ugr.es';
  static String applicationName = 'DS6/api/v1/';

  static String _username = 'admin';
  static String _password = 'admin';
  static String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
}
