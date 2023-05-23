// ignore_for_file: unused_element
// ignore_for_file: unused_import

import 'dart:math';
import 'package:vlsm_core/src/vlsm_core_exceptions.dart';

class IPv4{

  late String _address, _subnetMask, _prefix;
  late List<int> _octetAddress, _octetSubnetMask;
  late int _prefixNumber;

  //Validation Section

  String _addressValidation(String address){
    address = address.replaceAll(' ', '');
    if(address.split('').where((element) => element=='.').length!=3 || address.length<7 || address.split('.').length!=4){
      throw AddressFormattingException();
    }
    return address;
  }

  String _addressOctetListValidation(List<int> listOfOctets){
    if(listOfOctets.length<4){
      throw ShortOctetListException();
    }
    if(listOfOctets.length>4){
      throw LongOctetListException();
    }
    if(!listOfOctets.every((element) => 0<=element && element <=256)){
      throw OctetOutOfRangeException();
    }
    return listOfOctets.map((e) => e.toString()).join('.');
  }

  String _subnetMaskValidation(String subnetMask){
    subnetMask = subnetMask.replaceAll(' ', '');
    if(subnetMask.split(''). where((element) => element=='.').length!=3 || subnetMask.length<7 || address.split('.').length!=4){
      throw SubnetMaskFormattingException();
    }
    return subnetMask;
  }

  String _prefixValidation(String prefix){
    prefix = prefix.replaceAll(' ', '');
    if(!prefix.contains('/') || prefix.split('').where((element) => element=='/').length>1){
      throw PrefixFormattingException();
    }
    int number = int.tryParse(prefix.split('/')[1])??0;
    if(prefix.split('').length!=3 ||number>32){
      throw LongPrefixException();
    }
    if(number<0){
      throw ShortPrefixException();
    }
    return prefix;
  }

  int _prefixNumberValidation(int prefix){
    if(0<=prefix && prefix<=255){
      return prefix;
    }
    throw PrefixOutOfRangeException();
  }

  //Formated to Octet

  List<int> _octetAddressFormatting(String address)=>address.split('.').map((e) => int.tryParse(e)??0).toList();
  
  List<int> _octetSubnetMaskFormatting(String subnetMask) => subnetMask.split('.').map((e) => int.tryParse(e)??0).toList();

  //Octet to formated
  String _octetdAddressToFormatedAddress(List<int> octetAddress)=>octetAddress.map((element)=>element.toString()).join('.');

  String _octetdSubnetMaskToFormatedSubnetMask(List<int> subnetMask)=> subnetMask.map((element)=>element.toString()).join('.');
  
  // Formated prefix to number prefix
  int _formatedPrefixToPrefixNumber(String prefixFormated)=>int.parse(prefixFormated.split('/')[1]);

  //Prefix number to formated prefix
  String _prefixNumberToFormatedPrefix(int prefix) => "/$prefix";

  //Section responsible for converting octet subnet mask to prefix number and vice versa.
  int _octetSubnetMaskToPrefixNumber(List<int> octetSubnetMask) => octetSubnetMask.map((e) => e.toRadixString(2)).join().split('').where((element) => element=='1').length;

  List<int> _prefixNumberToOctetSubnetMask(int prefixNumber){
    String binarySubnetMask = _prefixNumberToBinary(prefixNumber);
    List<String> binaryOctetSubnetMask = <String>[];
    for (int i = 0; i < binarySubnetMask.length; i += 8) {
      binaryOctetSubnetMask.add(binarySubnetMask.substring(i, i + 8));
    }
    return binaryOctetSubnetMask.map((e) => int.parse(e, radix: 2)).toList();
  }

  //Prefix number to binary
  String _prefixNumberToBinary(int prefix) => List<String>.generate(prefix, (_) => '1').join()+List<String>.generate(32-prefix, (_) => '0').join();

  //Binary to prefix number
  int _binaryToPrefixNumber(String binary)=>binary.split('').where((element)=>element=='1').length;

  //Formated prefix to formated subnet mask
  String _formatedPrefixToFormatedSubnetMask(String formatedPrefix)=>_prefixNumberToFormatedSubnetMask(_formatedPrefixToPrefixNumber(formatedPrefix));

  //Formated subnet mask to formated prefix
  String _formatedSubnetMaskToFormatedPrefix(String formatedSubnetMask)=>_prefixNumberToFormatedPrefix(_formatedSubnetMaskToPrefixNumber(formatedSubnetMask));

  //Cross section
  int _formatedSubnetMaskToPrefixNumber(String formatedSubnetMask)=>formatedSubnetMask.split('.').map((e) => int.parse(e).toRadixString(2)).join().split('').where((element) => element=='1').length;

  String _prefixNumberToFormatedSubnetMask(int prefixNumber){
    String binarySubnetMask = _prefixNumberToBinary(prefixNumber);
    List<String> binaryOctetSubnetMask = <String>[];
    for (int i = 0; i < binarySubnetMask.length; i += 8) {
      binaryOctetSubnetMask.add(binarySubnetMask.substring(i, i + 8));
    }
    return binaryOctetSubnetMask.map((e) => int.parse(e, radix: 2)).join('.');
  }

  List<int> _formatedPrefixToOctetSubnetMask(String prefixFormated)=>_prefixNumberToOctetSubnetMask(_formatedPrefixToPrefixNumber(prefixFormated));

  String _octetSubnetMaskToPrefixFormated(List<int> octetSubnetMask)=>"/${octetSubnetMask.map((element)=>element.toRadixString(2)).join('').split('').where((element)=>element=='1').length}";
  
  IPv4({required String address, required String subnetMask}){
    //Argument validation
    _address=_addressValidation(address);
    _subnetMask=_subnetMaskValidation(subnetMask);

    //Filling section of other attributes.
    _prefix=_formatedSubnetMaskToFormatedPrefix(_subnetMask);
    _prefixNumber = _formatedPrefixToPrefixNumber(_prefix);

    _octetAddress = _octetAddressFormatting(_address);
    _octetSubnetMask = _octetSubnetMaskFormatting(_subnetMask);
  }

  IPv4.withPrefix({required String address, required String prefix}){
    //Argument validation
    _address = _addressValidation(address);
    _prefix = _prefixValidation(prefix);

    //Filling section of other attributes.
    _prefixNumber=_formatedPrefixToPrefixNumber(_prefix);

    _subnetMask=_formatedPrefixToFormatedSubnetMask(_prefix);

    _octetAddress= _octetAddressFormatting(_address);
    _octetSubnetMask = _octetSubnetMaskFormatting(_subnetMask);
  }

  IPv4.withListOfOctetsAndSubnetMask({required List<int> listOfOctets, required String subnetMask}){
    //Argument validation
    _address = _addressValidation(listOfOctets.map((e) => e.toString()).join('.'));
    _subnetMask = _subnetMaskValidation(subnetMask);

    //Filling section of other attributes.
    _octetAddress=_octetAddressFormatting(_address);
    _octetSubnetMask = _octetSubnetMaskFormatting(_subnetMask);
    _prefixNumber = _octetSubnetMaskToPrefixNumber(_octetSubnetMask);
    _prefix = _prefixNumberToFormatedPrefix(_prefixNumber);
  }

  IPv4.withListOfOctetsAndPrefix({required List<int> listOfOctets, required String prefix}){
    //Argument validation
    _address = _addressOctetListValidation(listOfOctets);
    _prefix = _prefixValidation(prefix);
    
    _subnetMask = _formatedPrefixToFormatedSubnetMask(_prefix);

    _octetAddress=listOfOctets;
    _octetSubnetMask=_formatedPrefixToOctetSubnetMask(_prefix);
    _prefixNumber = _formatedPrefixToPrefixNumber(_prefix);

  }

  IPv4.withFormatedNetworkAddressAndNumericPrefix({required String address, required int prefix}){
    //Argument validation
    _address = _addressValidation(address);
    _prefixNumber = _prefixNumberValidation(prefix);

    //Filling section of other attributes.
    _prefix = _prefixNumberToFormatedPrefix(prefix);

    _octetAddress =_octetAddressFormatting(_address);
    _octetSubnetMask = _formatedPrefixToOctetSubnetMask(_prefix);
    _subnetMask=_prefixNumberToFormatedSubnetMask(_prefixNumber);
  }

  IPv4.withFormatedAddress({required String formatedAddress}){
    //Separation of the formatted address at address and prefix.
    String address = formatedAddress.split('/')[0];
    int prefixNumeric=int.parse(formatedAddress.split('/')[1]);
    
    //Argument validation
    _address = _addressValidation(address);
    _prefix = _prefixNumberToFormatedPrefix(prefixNumeric);
    _prefixNumber=_prefixNumberValidation(prefixNumeric);

    //Filling section of other attributes.
    _octetAddress = _octetAddressFormatting(address);
    _subnetMask = _formatedPrefixToFormatedSubnetMask(_prefix);
    _octetSubnetMask = _octetSubnetMaskFormatting(_subnetMask);

  }

  String get formatedPrefix => _prefix;
  int get prefixNumber => _prefixNumber;

  List<int> get subnetMaskListOfOctets => _octetSubnetMask;
  List<int> get addressListOfOctets => _octetAddress;

  String get subnetMask => _subnetMask;
  String get address => _address;

  String get binarySubnetMask =>_prefixNumberToBinary(_prefixNumber);

  int get size => pow(2,32-_prefixNumber).toInt();


  set setFormatedPrefixString(String prefix){
    _prefix=_prefixValidation(prefix);
    _prefixNumber = _formatedPrefixToPrefixNumber(_prefix);
    _subnetMask = _formatedPrefixToFormatedSubnetMask(_prefix);
    _octetSubnetMask = _formatedPrefixToOctetSubnetMask(_prefix);
  }

  set prefixNumber(int prefix){
    if(prefix<0){
      throw ShortPrefixException();
    }
    if(32<prefix){
      throw LongPrefixException();
    }
    _prefixNumber=prefix;
    _prefix= _prefixNumberToFormatedPrefix(_prefixNumber);
    _subnetMask=_formatedPrefixToFormatedSubnetMask(_prefix);
    _octetSubnetMask = _formatedPrefixToOctetSubnetMask(_prefix);
  }


  IPv4 operator +(int value){
    List<int> localOctetAddress = [..._octetAddress];
    localOctetAddress.last+=value;
    for(int i in [3,2,1]){
      if(localOctetAddress[i]>=256){
        localOctetAddress[i-1]+=localOctetAddress[i]~/256;
        localOctetAddress[i]%=256;
      }
    }
    if(localOctetAddress.first>=256){
      throw AdditionOutOfRangeAddressException();
    }
    return IPv4.withListOfOctetsAndPrefix(listOfOctets: localOctetAddress, prefix: _prefix);
  }

  IPv4 operator - (int value){
    List<int> localOctetAddress = [..._octetAddress];
    localOctetAddress.last-=value;
    for(int i in [3,2,1]){
      if(localOctetAddress[i]<0){
        int temp = localOctetAddress[i].abs()/256 == (localOctetAddress[i].abs()~/256).toDouble() ? localOctetAddress[i].abs()~/256 : (localOctetAddress[i].abs()~/256)+1;
        localOctetAddress[i-1]-=temp;
        localOctetAddress[i]+=temp*256;
      }
    }
    if(localOctetAddress.first<0){
      throw SubtrationOutOfRangeException();
    }
    return IPv4.withListOfOctetsAndPrefix(listOfOctets: localOctetAddress, prefix: _prefix);
  }

  bool operator<(IPv4 that){
    List<int> local = [...that.addressListOfOctets];
    for(int i in [0,1,2,3]){
      if(_octetAddress[i]<local[i]){
        return true;
      }
      else if(_octetAddress[i]>local[i]){
        return false;
      }
    }
    return false;
  }

  bool operator>(IPv4 that){
    List<int> local = [...that.addressListOfOctets];
    for(int i in [0,1,2,3]){
      if(_octetAddress[i]>local[i]){
        return true;
      }
      else if(_octetAddress[i]<local[i]){
        return false;
      }
    }
    return false;
  }


  bool operator<=(IPv4 that){
    return this<that || this==that;
  }

  bool operator>=(IPv4 that){
    return this>that || this==that;
  }


  @override
  int get hashCode => _address.hashCode^_prefix.hashCode^_subnetMask.hashCode;

  @override
  bool operator ==(Object other){
    if(other is IPv4){
      List<int> local = [...other._octetAddress];
      return identical(this,other) || runtimeType == other.runtimeType &&  _octetAddress.asMap().entries.every((element) => element.value == local[element.key]);
    }
    return false;
  }

  @override
  String toString(){
    return """
      Address:$_address
      Sunet Mask:$_subnetMask
      Prefix: $_prefix  
      Total IPS number: $size
      Total Host IPs (usable):${size-2}
    """;
  }

}