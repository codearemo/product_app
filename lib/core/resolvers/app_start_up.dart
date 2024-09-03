
import 'package:assessment/core/storage.dart';

class AppSetUp {
  Future initStorage(Storage storage) async {
    await storage.initStorage();
  }
}