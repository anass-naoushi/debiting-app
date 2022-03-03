class FormValidators{
  static String? isNotEmptyField(String? fieldText){
    if(fieldText==null|| fieldText.trim().isEmpty){
      return 'Empty field';
    }else{
      return null;
    }
  }
  static String? isValidEmail(String? email){
    if(email==null|| email.trim().isEmpty){
      return 'Enter a valid email';
    }else if(!email.trim().contains('@')){
      return 'Enter a valid email';
    }else {
      return null;
    }
  }
  static String? isValidPassword(String? password){
    if(password==null|| password.trim().isEmpty){
      return 'Enter a valid password';
    }else if(password.trim().length<8){
      return 'Password must be 8 characters minimum';
    }else{
      return null;
    }
  }
  static String? isNumber(String? number){
    if(number==null||number.trim().isEmpty){
      return 'Enter a valid amount';
    }else if(num.tryParse(number.trim())==null){
      return 'Enter only numbers';
    }
  }
}