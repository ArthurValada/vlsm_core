class PrefixOutOfRangeException implements Exception{

  final String mensagem;

  PrefixOutOfRangeException({this.mensagem="The prefix entered is outside the proper range."});

  @override
  String toString(){
    return mensagem;
  }

}