class PrefixFormattingException implements Exception{

  final String mensagem;

  PrefixFormattingException({this.mensagem="The prefix entered is not properly formatted."});

  @override
  String toString() {
    return mensagem;
  }

}