/// Clase de utilidades para validaciones de datos
/// Contiene 5 funciones de validación para el sistema de CI/CD
class Validator {
  /// Valida si un email tiene un formato correcto
  /// Retorna true si el email es válido, false en caso contrario
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Valida si una contraseña cumple con los requisitos mínimos
  /// Debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    
    return hasUppercase && hasLowercase && hasDigit;
  }

  /// Valida si un número de teléfono tiene un formato válido
  /// Debe contener solo dígitos y tener entre 8 y 15 caracteres
  static bool isValidPhoneNumber(String phone) {
    if (phone.isEmpty) return false;
    
    final phoneRegex = RegExp(r'^\d{8,15}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Valida si un monto es válido para transacciones
  /// Debe ser mayor a 0 y menor o igual a 1,000,000
  static bool isValidAmount(double amount) {
    return amount > 0 && amount <= 1000000;
  }

  /// Valida si una fecha es válida y no está en el futuro
  /// Retorna true si la fecha es válida y no es posterior a hoy
  static bool isValidDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    return !dateOnly.isAfter(today);
  }

  /// Valida si un texto no está vacío y no contiene solo espacios
  static bool isNotEmpty(String text) {
    return text.trim().isNotEmpty;
  }
}
