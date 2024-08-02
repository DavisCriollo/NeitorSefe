

import 'package:encrypt/encrypt.dart';
class Encryptation {

  //  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

  static final key = Key.fromSecureRandom(32);
  static final iv = IV.fromSecureRandom(16);
  static final encrypter = Encrypter(AES(key));


static encrytpAES(text){
  final encrypted=encrypter.encrypt(text,iv:iv);

 

  print(encrypted.bytes);
  print(encrypted.base16);
  print(encrypted.base64);
 return encrypted;
}


static decryptAES(text){
 return encrypter.decrypt(text,iv:iv);
   
}
  
}