// test/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:neuralboost/services/auth_service.dart';

void main() {
  test('create account', () async {
    AuthService authService = AuthService();
    bool isCreated =
        await authService.createAccount('test@example.com', 'password');
    expect(isCreated, true);
  });

  test('sign in with google', () async {
    AuthService authService = AuthService();
    bool isLoggedIn = await authService.signInWithGoogle();
    expect(isLoggedIn, true);
  });
}
