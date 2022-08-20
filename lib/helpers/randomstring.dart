import 'dart:math';

class RandomString {
  int? len;
  Random? _random;
  RandomString({this.len=5}) : _random = Random();

  String generate(){
    return String.fromCharCodes(
        List.generate(len!, (index) => _random!.nextInt(26) + 97));
  }
}
