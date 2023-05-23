class ShortPrefixException implements Exception{

  final String mensagem;

  ShortPrefixException({this.mensagem="The entered prefix value is short than should be."});

  @override
  String toString() {
    return mensagem;
  }

}