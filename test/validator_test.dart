import 'package:flutter_test/flutter_test.dart';
import 'package:vanguardmoney/core/utils/validator.dart';

void main() {
  group('Validator Tests', () {
    /// Test 1: Validación de email
    test('isValidEmail should return true for valid emails', () {
      expect(Validator.isValidEmail('usuario@example.com'), true);
      expect(Validator.isValidEmail('test.user@domain.co'), true);
      expect(Validator.isValidEmail('user123@gmail.com'), true);
    });

    test('isValidEmail should return false for invalid emails', () {
      expect(Validator.isValidEmail(''), false);
      expect(Validator.isValidEmail('invalidemail'), false);
      expect(Validator.isValidEmail('user@'), false);
      expect(Validator.isValidEmail('@domain.com'), false);
      expect(Validator.isValidEmail('user@domain'), false);
    });

    /// Test 2: Validación de contraseña
    test('isValidPassword should return true for valid passwords', () {
      expect(Validator.isValidPassword('Password123'), true);
      expect(Validator.isValidPassword('SecurePass1'), true);
      expect(Validator.isValidPassword('MyP4ssw0rd'), true);
    });

    test('isValidPassword should return false for invalid passwords', () {
      expect(Validator.isValidPassword('short'), false);
      expect(Validator.isValidPassword('alllowercase123'), false);
      expect(Validator.isValidPassword('ALLUPPERCASE123'), false);
      expect(Validator.isValidPassword('NoNumbers'), false);
      expect(Validator.isValidPassword(''), false);
    });

    /// Test 3: Validación de número de teléfono
    test('isValidPhoneNumber should return true for valid phone numbers', () {
      expect(Validator.isValidPhoneNumber('12345678'), true);
      expect(Validator.isValidPhoneNumber('987654321'), true);
      expect(Validator.isValidPhoneNumber('123456789012345'), true);
    });

    test('isValidPhoneNumber should return false for invalid phone numbers', () {
      expect(Validator.isValidPhoneNumber(''), false);
      expect(Validator.isValidPhoneNumber('1234567'), false); // Muy corto
      expect(Validator.isValidPhoneNumber('1234567890123456'), false); // Muy largo
      expect(Validator.isValidPhoneNumber('12345abc'), false); // Contiene letras
      expect(Validator.isValidPhoneNumber('+123456789'), false); // Contiene símbolos
    });

    /// Test 4: Validación de monto
    test('isValidAmount should return true for valid amounts', () {
      expect(Validator.isValidAmount(100.0), true);
      expect(Validator.isValidAmount(0.01), true);
      expect(Validator.isValidAmount(1000000.0), true);
      expect(Validator.isValidAmount(500.50), true);
    });

    test('isValidAmount should return false for invalid amounts', () {
      expect(Validator.isValidAmount(0), false);
      expect(Validator.isValidAmount(-100), false);
      expect(Validator.isValidAmount(1000001), false);
      expect(Validator.isValidAmount(-0.01), false);
    });

    /// Test 5: Validación de fecha
    test('isValidDate should return true for valid dates', () {
      final today = DateTime.now();
      final yesterday = today.subtract(Duration(days: 1));
      final lastYear = DateTime(today.year - 1, today.month, today.day);
      
      expect(Validator.isValidDate(today), true);
      expect(Validator.isValidDate(yesterday), true);
      expect(Validator.isValidDate(lastYear), true);
    });

    test('isValidDate should return false for future dates', () {
      final today = DateTime.now();
      final tomorrow = today.add(Duration(days: 1));
      final nextYear = DateTime(today.year + 1, today.month, today.day);
      
      expect(Validator.isValidDate(tomorrow), false);
      expect(Validator.isValidDate(nextYear), false);
    });
  });
}
