import 'package:hive/hive.dart';

class IdGenerator {
  Box<int> idBox;

  IdGenerator(this.idBox);

  int getNextId() {
    if (idBox.isEmpty) {
      idBox.put('lastId', 0);
      return 0;
    } else {
      int lastId = idBox.get('lastId')!;
      int newId = lastId + 1;
      idBox.put('lastId', newId);
      return newId;
    }
  }
}
