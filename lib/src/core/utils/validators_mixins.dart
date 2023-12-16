import '../../res/strings.dart';

extension NullOrEmpty on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
  // bool get isNotEmptyOrNull => this == null || (this?.isEmpty ?? true);
}

mixin VValidatorsMixin {
  static String? isEmailValid(String? email) {
    RegExp validPattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    if (validPattern.hasMatch(email)) {
      return null;
    } else {
      return "Email is invalid";
    }
    // if (!email.contains('@')) {
    //   return 'Email is invalid';
    // }
    // return null;
  }

  //A function that validate user entered password
  static String? validatePassword(String? value) {
    //Todo maybe allow spaces in password
    RegExp validPattern = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    String password = value ?? '';
    if (password.isEmpty) {
      return "Password is required";
    }
    if (validPattern.hasMatch(password)) {
      return null;
    } else {
      return " Password should contain Capital, small letter & Number & Special";
    }
  }

  static String? isPasswordsssValid(String? password) {
    if (password == null || password.length >= 8) {
      return 'Password must contain at least 8 characters.';
    }
    if (!password.contains('@')) {
      return 'Password must include one uppercase letter and one special character.';
    }
    return null;
  }

  static String? isNotEmpty(String? value, {String? field}) {
    if (value == null || value.isEmpty) {
      return field != null ? '' : '';
      // return field != null ? '$field is required' : 'Required';
    }
    return null;
  }

  static String? isDropdownNotEmpty(String? value, {String? field}) {
    if (value == null || value.isEmpty) {
      return '';
      // return field != null ? '$field is required' : 'Required';
    }
    return null;
  }

  static String? isUsernameValid(String value) {
    if (value.isNotEmpty && (value.length >= 5 && value.length <= 20)) {
      // Pattern pattern = r'^[A-Za-z0-9_.]+$';
      Pattern pattern = r'^[A-Za-z0-9\-\.]+$';
      RegExp regex = RegExp(pattern.toString());
      return (!regex.hasMatch(value))
          ? "Username should only contain characters A-Z 0-9 . and -"
          : null;
    } else {
      return "Username should be between 5 to 20 characters.";
    }
  }

  static String? isPhoneValid(String? phone) {
    //pattern: at least 11 digits and starts with '+'
    String pattern = r'^\+\d{11,}$';
    RegExp regex = RegExp(pattern);
    if (phone == null || phone.isEmpty) return "Phone number is required";
    if (!regex.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
    // if (phone == null || phone.isEmpty || phone.length < 11) {
    //   return 'Phone Number is required';
    // }
    // return null;
  }

  static String? isNameValid(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static String? isURLValid(String? url) {
    print('[222] lllllll ${url}');
    String pattern =
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";
    // r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
    // r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)";
    RegExp regex = RegExp(pattern);
    // if (url == null || url.isEmpty) return "Website url is required";
    if (url == null || url.isEmpty) return null;
    if (!regex.hasMatch(url)) {
      return 'Please enter a valid website address';
    } else {
      return null;
    }
  }

  static String? isPinValid(String? pin) {
    if (pin == null || pin.isEmpty) {
      return 'Pin is required';
    }
    return null;
  }

  static String? isBirthDateValid(DateTime? birthDate) {
    if (birthDate == null) {
      return 'Birth Date is required';
    } else if (birthDate.year > DateTime.now().year - 15) {
      return 'You must be at least 16 years old';
    }
    return null;
  }

  static bool isUserNameValidator(String value) {
    bool? isUserName = false;

    if (isEmailValid(value) == null) {
      isUserName = false;
    } else {
      isUserName = true;
    }
    return isUserName;
  }

  static String? isHeightValid(String? value, {isRequired = false}) {
    if (isRequired) {
      if (value == null || value.isEmpty) {
        return 'Height is required';
      }
    } else {
      if (value == null || value.isEmpty) return null;
    }

    final height = double.tryParse(value);
    // If height is not in acceptable range or
    // height is null means value is not a number return error text
    // if(height == null || value.isEmpty) return 'Height required';
    if (height == null || height < 50.0 || height > 300.0) {
      return 'Valid range (50 - 300)';
    } else {
      return null;
    }
  }

  static String? isWeightValid(String? value) {
    if (value == null || value.isEmpty) return null;
    final weight = double.tryParse(value);

    // If weight is not in acceptable range or
    // weight is null means value is not a number return error text
    if (weight == null || weight < 30.0 || weight > 300.0) {
      return 'Valid range (30 - 300)';
    } else {
      return null;
    }
  }

  static String? isChestValid(String? value) {
    if (value == null || value.isEmpty) return null;
    final chest = double.tryParse(value);

    // If chest is not in acceptable range or
    // chest is null means value is not a number return error text
    if (chest == null || chest < 10.0 || chest > 100.0) {
      return 'Valid range (10 - 100)';
    } else {
      return null;
    }
  }

  static String? isMinimumLengthValid(String? value, int minLength,
      {required String field}) {
    if (value == null || value.isEmpty) {
      return '$field is required';
    } else if (value.length < minLength) {
      return 'Minimum of $minLength required';
    }
    return null;
  }

  static String? isMaximumLengthValid(String? value, int maxLength,
      {required String field}) {
    if (value == null || value.isEmpty) {
      return '';
    } else if (value.length > maxLength) {
      return 'Maximum of $maxLength required';
    }
    return null;
  }

  //
  static String? isValidServicePrice(String? value, {required String field}) {
    if (value == null || value.isEmpty) {
      return '';
    } else {
      final price = double.tryParse(value);
      if (price == null) {
        return 'Please provide a valid value';
      } else if (price < 5.0) {
        return '${VMString.poundSymbol}5 minimum';
      }
    }
    return null;
  }

  static String? isValidDiscount(String? value, {required String field}) {
    if (value == null || value.isEmpty) {
      return '$field is required';
    } else {
      final discount = int.tryParse(value);
      if (discount == null) {
        return 'Please provide a valid value';
      } else if (discount < 5) {
        return '5% minimum';
      } else if (discount > 80) {
        return '80% maximum';
      }
    }
    return null;
  }

//Todo refactor to use previous Bio validator
  static String? isSignUpBioValid(String? value, {required String field}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    } else if (value.length < 200) {
      return 'Minimum of 200 characters required';
    } else {
      return null;
    }
  }
}
