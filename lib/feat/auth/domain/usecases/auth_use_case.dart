class AuthUseCase {
  bool call(String password) {
    Map<String, String> mapa = {')': '(', '}': '{', ']': '['};
    List<String> pila = [];

    for (var caracter in password.split('')) {
      if (mapa.containsKey(caracter)) {
        String tope = pila.isNotEmpty ? pila.removeLast() : '#';
        if (mapa[caracter] != tope) {
          return false;
        }
      } else {
        pila.add(caracter);
      }
    }

    return pila.isEmpty;
  }
}
