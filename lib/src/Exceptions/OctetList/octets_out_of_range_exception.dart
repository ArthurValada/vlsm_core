class OctetOutOfRangeException implements Exception{

  final String mensagem;

  OctetOutOfRangeException({this.mensagem="At least one, or all, of the octets passed are out of range."});

  @override
  String toString(){
    return mensagem;
  }

}