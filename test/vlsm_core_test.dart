import 'dart:math';

import 'package:test/test.dart';
import 'package:vlsm_core/ipv4_address.dart';

void main() {

  group("Test properties of the object constructed with the default constructor.", (){
    setUp(() {});

    tearDown(() {});

    test("Address property test.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").address, equals('192.168.0.0')));
    test("Address octect list property test.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").addressListOfOctets, equals([192,168,0,0])));

    test("Binary subnet mask propery test.",()=>expect(IPv4(address: "192.168.0.0", subnetMask: "128.0.0.0").binarySubnetMask, equals('1${List<String>.generate(31, (_) => "0").join()}')));

    test("Network submask conversion test to prefix.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").formatedPrefix, equals("/24")));

    test("Network submask conversion test to integer.",()=>expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").prefixNumber, equals(24)));

    test("Definition test of prefix porthole to class instantiation.",(){
      IPv4 object = IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0");
      object.setFormatedPrefixString="/23";
      expect(object.formatedPrefix,equals("/23"));
      });
    
    test("IP range size test.",()=>expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").size, equals(pow(2,8))));
  });

  //Arithmetic test
  test("IPv4Address class addition method test.",() {
    expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+1).address, equals('192.168.10.1'));
  });


  test("Test with subnet mask", () => expect(IPv4(address: "192.168.10.0", subnetMask: "255.255.255.0").prefixNumber,equals(24)));

  //Test of size of a network
  for(int i in List<int>.generate(33, (index) => index)){
    test("Network size test with prefix /$i.", (){
      expect(IPv4.withFormatedNetworkAddressAndNumericPrefix(address: "192.168.10.0", prefix: i).size, equals(pow(2,32-i)));
    });
  }
}
