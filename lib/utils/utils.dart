import 'dart:math';

class Utils {
  static const alphabet = 'abcdefghijklmnopqrstuvwxyz';
  static Random rnd = Random();

  static String generateInternalId() {
    String id = '';
    for (int i = 0; i < 10; ++i) {
      id += alphabet[rnd.nextInt(alphabet.length)];
    }
    return 'internal-bullseye-$id';
  }
}