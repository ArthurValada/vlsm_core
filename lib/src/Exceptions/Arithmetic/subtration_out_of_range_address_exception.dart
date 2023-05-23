class SubtrationOutOfRangeException implements Exception{

  final String mensagem;

  SubtrationOutOfRangeException({this.mensagem="The subtration generates an ip out of range."});

  @override
  String toString() {
    return mensagem;
  }

}