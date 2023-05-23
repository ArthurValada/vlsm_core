class AddressFormattingException implements Exception{
  final String mensagem;

  AddressFormattingException({this.mensagem="A ip network address inserted string is not properly formatted."});

  @override
  String toString(){
    return mensagem;
  }
}