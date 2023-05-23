class SubnetMaskFormattingException implements Exception{

  final String mensagem;

  SubnetMaskFormattingException({this.mensagem="A subnet mask address inserted string is not properly formatted."});

  @override
  String toString(){
    return mensagem;
  }
}