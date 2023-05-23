class AdditionOutOfRangeAddressException implements Exception{

  final String mensagem;

  AdditionOutOfRangeAddressException({this.mensagem="The addition generates an ip out of range."});

  @override
  String toString(){
    return mensagem;
  }

}