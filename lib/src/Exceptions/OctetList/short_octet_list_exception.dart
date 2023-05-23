class ShortOctetListException implements Exception{

  final String mensagem;

  ShortOctetListException({this.mensagem="The list of octets passed is less than it should be."});

  @override
  String toString(){
    return mensagem;
  }

}