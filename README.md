# Documentação
Projeto feito com o intuito de auxiliar na manipulação de endereço IPv4.
Pode-se criar um endereço IPv4 chamando a classe homônima. A classe possui mais de um construtor, são eles e seus parâmetros:
## Lista de Exceções

### Formatação

1.[AddressFormattingException](Exceptions/Formatting/address_formatting_exception.dart)

1.1. Definição: Essa exceção será levantada quando o contrutor da classe for evocado, direta ou indiretamente, e o endereço de IP passado como argumento não estiver devidamente formatado no padrão:*"###.###.###.###"*. A mensagem padrão é:*"A ip network address inserted string is not properly formatted."*.

2.[SubnetMaskFormattingException](Exceptions/Formatting/subnetmask_formatting_exception.dart)

2.1. Definição: Essa exceção será levantada quando o construtor da classe for chamado, direta ou indiretamente, e a sub-máscara de rede passada como argumento não estiver devidamente formatada no padrão: *"###.###.###.###"*. A mensagem padrão da classe é:*"A subnet mask address inserted string is not properly formatted."*.

3.[ShortOctetListException](Exceptions/OctetList/short_octet_list.dart)

3.1. Definição: Essa exceção será levantada quando o construtor de classe que tem como argumento uma lista de octetos receber uma lista com tamanho menor que 4. A mensagem padrão da classe é: *"The list of octets passed is less than it should be."*. 

4.[LongOctetListException](Exceptions/OctetList/long_octet_list.dart)

4.1.Definição: Essa exceção será levantada quando o construtor da classe que tem como argumento uma lista de octetos for maior do que deve ser, isto é, tiver mais de quatro elementos na lista.
A mensagem padrão da classe é:*"The list of octets passed is longer than it should be."*.

5.[PrefixFormattingException](Exceptions/Prefix/prefix_formatting_exception.dart)

5.1.Definição: A exceção será levantada quando houver a tentativa atribuição de um valor não apropriado à variável privada *_prefix*, responsável por armazenar o prefixo de rede formatado. A mensagem padrão da classe é:*"The prefix entered is not properly formatted."*.

### Octetos fora do intervalo

6.[OctetsOutOfRangeException](Exceptions/OctetList/octets_out_of_range.dart)

6.1. Definição: Essa exceção será levantada quando um ou mais valores da lista de octetos estiverem fora do apropriado intervalo [0,256]. A mensagem padrão da classe é:*"At least one, or all, of the octets passed are out of range."*.

### Prefixo

7.[LongPrefixException](Exceptions/Prefix/long_prefix.dart)

7.1. Definição: Essa exceção será levantada quando o prefixo passado como argumento for maior do que pode ser:32. A mensagem padrão da classe é:*"The specified prefix is ​longer then should be."*.

8.[ShortPrefixException](Exceptions/Prefix/short_prefix.dart)

8.1. Definição: Essa exceção será levantada quando o prefixo passado como argumento for menor do que pode ser: 0. A mensagem padrão da classe é:*"The entered prefix value is short than should be."*.

9.[PrefixOutOfRangeException](Exceptions/Prefix/prefix_out_of_range.dart)

9.1. Definição: Essa exceção será levantda quando o prefixo passado como argumento estiver fora do intervalo devido: [0,32]. A mensagem padrão da classe é:*"The prefix entered is outside the proper range."*.

### Aritmético

12.[AdditionOutOfRangeException](Exceptions/Arithmetic/addition_out_of_range_address.dart)

12.1.Definição: Essa exceção será levantada quando a adição, método da classe, gerar um IP fora do intervalo apropriado. A mensagem padrão da classe é: *"The addition generates an ip out of range."*.

13.[SubtrationOutOfRangeException](Exceptions/Arithmetic/subtration_out_of_range_address.dart)

13.1. Definição: Essa exceção será levantada quando a subtração, método da classe, gerar um IP fora do intervalo apropriado. A mensagem padrão da classe é:*"The subtration generates an ip out of range."*.
## Contrutores da Classe
### 1.IPv4(address: [address], subnetmask:[subnetmask])
Esse contrutor recebe dois argumentos: o endereço na rede e a máscara de sub-rede associada ao endereço. Ambos devem estar devidamente formatados, no padrão :"###.###.###.###"; se algum deles não estiver devidamente formatado, levantará uma das seguinte exceções: [AddressFormattingException](Exceptions/Formatting/address_formatting_exception.dart) ou [SubnetMaskFormattingException](Exceptions/Formatting/subnetmask_formatting_exception.dart).
### 2.IPv4.withPrefix(address:[address],prefix:[prefix])
Esse construtor recebe dois argumentos: o endereço de rede e o prefixo, ambos devidamente formatados nos respectivos padrões: "###.###.###.###" e "/#". Se o endereço não estiver devidamente formatado, levantará uma das seguintes exceções:[AddressFormattingException](Exceptions/Formatting/address_formatting_exception.dart) ou 5.[PrefixFormattingException](Exceptions/Prefix/prefix_formatting_exception.dart).
### 3.IPv4.withListOfOctetsAndSubnetMask(listOfOctets:[listOfOctets], subnetMask:[subnetMask])
