class CurrencyStore {
  /// Valor en memoria del símbolo/código de moneda seleccionado.
  /// Inicialmente mantiene 'S/' como valor por defecto (Perú).
  static String symbol = 'S/';

  static void set(String s) {
    if (s.isNotEmpty) symbol = s;
  }

  static String get() => symbol;
}
