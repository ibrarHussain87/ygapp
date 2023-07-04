import 'package:flutter/material.dart';

import '../../../model/response/login/login_response.dart';

class UserNotifier extends ChangeNotifier {
  late User user;

  UserNotifier(this.user);

  updateUser(User userNew) {
    user = userNew;
    notifyListeners();
  }

  getUser() {
    return user;
  }
}
