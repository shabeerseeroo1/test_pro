import 'dart:async';

mixin Validators {
  final mobValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (mob, sink) {
    if (mob
        .trim()
        .isEmpty) {
      sink.addError("Mobile number cannot be empty");
    } else if (mob.trim().contains("/")) {
      sink.addError("Enter a valid mobile number");
    } else if (mob
        .trim()
        .length < 8) {
      sink.addError("Enter a valid mobile number");
    } else {
      sink.add(mob);
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (pass, sink) {
        if (pass.trim().isEmpty){
          sink.addError("Password cannot be empty");
        }else if(pass.trim().length<6){
          sink.addError("Enter a valid password");
        }else{
          sink.add(pass);
        }
      });
}
