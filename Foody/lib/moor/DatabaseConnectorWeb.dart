import 'package:moor/moor_web.dart';

class DatabaseConnectorWeb {

  WebDatabase openConnectionWeb() {
    print('build moor database for Web');
    return WebDatabase('db' , logStatements: true);
  }
}