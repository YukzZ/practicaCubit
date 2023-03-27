import 'package:flutter_app/objectbox.g.dart';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';

class DataBaseController{
  static late final Store store;

  Future<void> initDataBase() async{
    final appDocumentsDirextory = await getApplicationDocumentsDirectory();

    store = Store(
      getObjectBoxModel(), 
      directory: path.join(appDocumentsDirextory.path, 'test_db'),
    );
  }
}
