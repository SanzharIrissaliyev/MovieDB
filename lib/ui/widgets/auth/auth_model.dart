import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themovedb/domain/api_client/api_client.dart';
import 'package:themovedb/domain/data_providers/session_data_providers.dart';
import 'package:themovedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;
  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Введите email и пароль';

      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
    } catch (e) {
      _errorMessage = 'Nepravilno логин и пароль';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Neizvestnaya oshibka';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);

    unawaited(Navigator.of(context).pushReplacementNamed(
      MainNavigationRouteNames.mainScreen,
    ));
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;

//   const AuthProvider({
//     Key? key,
//     required this.model,
//     required Widget child,
//   }) : super(key: key, notifier: model, child: child);

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget =
//         context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }

//   static AuthProvider of(BuildContext context) {
//     final AuthProvider? result =
//         context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     assert(result != null, 'No AuthProvider found in context');
//     return result!;
//   }
// }




