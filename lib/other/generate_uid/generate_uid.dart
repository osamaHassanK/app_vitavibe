import 'dart:math';

int generateValidId() {
  final random = Random();
  return random.nextInt(2147483647); // Generate a positive 32-bit integer
}
