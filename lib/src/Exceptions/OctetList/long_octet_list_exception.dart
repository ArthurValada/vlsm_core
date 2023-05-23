class LongOctetListException implements Exception{

  final String mensagem;

  LongOctetListException({this.mensagem="The list of octets passed is longer than it should be."});

  @override
  String toString() {
    return mensagem;
  }

}