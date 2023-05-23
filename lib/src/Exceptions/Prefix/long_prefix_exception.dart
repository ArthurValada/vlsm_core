class LongPrefixException implements Exception{

  final String mensagem;

  LongPrefixException({this.mensagem="The specified prefix is ​longer then should be."});

  @override
  String toString() {
    return mensagem;
  }

}