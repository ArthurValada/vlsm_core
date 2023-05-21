import 'dart:math';

import 'package:test/test.dart';
import 'package:vlsm_core/ipv4_address.dart';

void main() {

  group("Test properties of the object constructed with the default constructor.", (){

    test("Address property test.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").address, equals('192.168.0.0')));
    test("Address octect list property test.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").addressListOfOctets, equals([192,168,0,0])));

    test("Binary subnet mask propery test.",() => expect(IPv4(address: "192.168.0.0", subnetMask: "128.0.0.0").binarySubnetMask, equals('1${List<String>.generate(31, (_) => "0").join()}')));

    test("Network submask conversion test to prefix.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").formatedPrefix, equals("/24")));

    test("Network submask conversion test to integer.",() => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").prefixNumber, equals(24)));

    test("Definition test of prefix porthole to class instantiation.",(){
      IPv4 object = IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0");
      object.setFormatedPrefixString="/23";
      expect(object.formatedPrefix,equals("/23"));
    });
    
    test("IP range size test.",() => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").size, equals(pow(2,8))));

    test("Life Assignment Test of Sub-Network Mask.",() => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").subnetMask, equals("255.255.255.0")));

    test("String partition test formatted from the network submascara on an octet list.",() => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").subnetMaskListOfOctets,equals([255,255,255,0])));

    test("Class conversion test into string",() => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0").toString(),equals(
      """
      Address:192.168.0.0
      Sunet Mask:255.255.255.0
      Prefix: /24  
      Total IPS number: 256
      Total Host IPs (usable):254
    """)));
  });

  group("IPV4 class arithmetic tests", (){

    group("Section of addition methods.", (){

      test("Unit addition method test.",() => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+1).address, equals('192.168.10.1')));

      test("Octet addition test.",() => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+256).address, equals("192.168.11.0")));

      test("Two octet addition test.",() => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+(256*256)).address, equals("192.169.10.0")));

      test("Three octet addition test.", () => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+(256*256*256)).address, equals("193.168.10.0")));

      test("Four octet addition test.", () => expect(() => IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")+(256*256*256*256), throwsException));

    });

    group("Subtraction Methods Section.", (){
      
      test("Unit subtraction method test.",() => expect((IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0")-1).address,equals("192.168.0.0")));

      test("Octet subtraction test.",() => expect((IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0")-256).address, equals("192.167.255.1")));

      test("Two octet subtraction test.",() => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")-(256*256)).address, equals("192.167.10.0")));

      test("Three octet subtraction test.", () => expect((IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")-(256*256*256)).address, equals("191.168.10.0")));

      test("Four octet subtraction test.", () => expect(() => IPv4.withPrefix(address: "192.168.10.0", prefix: "/24")-(256*256*256*256), throwsException));
      
    });
  });

  group("Group of tests on the correct relief between prefix length and network size.", (){
    for(int i in List<int>.generate(33, (index) => index)){
      test("Teste com o prefixo /$i",() => expect(IPv4.withFormatedNetworkAddressAndNumericPrefix(address: "192.168.0.0", prefix: i).size, equals(pow(2,32-i).toInt())));
    }
  });

  group("Relational operators test.", (){

    group("Operator tests less than.", (){
      
      test("Test to give true.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")<IPv4(address:"192.168.0.1", subnetMask: "255.255.255.0"), equals(true)));

      test("Test to give false.", () => expect(IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0")<IPv4(address:"192.168.0.0", subnetMask: "255.255.255.0"), equals(false)));

    });

    group("Tests to the operator greater than.", (){

      test("Test to give true.", () => expect(IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0")>IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0"), equals(true)));

      test("Test to give false.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")>IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0"), equals(false)));

    });

    group("Smaller or equal operator tests.", (){

      test("Testing if it is smaller.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")<=IPv4(address: "192.168.0.1", subnetMask: "255.255.255.0"), equals(true)));

      test("Testing if it's the same.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")<=IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0"), equals(true)));

      test("Testing if it is not smaller or equal.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")<=IPv4(address: "192.167.0.1", subnetMask: "255.255.255.0"), equals(false)));

    });

    group("Testing the operator greater or equal.", (){
      test("Testing if it's bigger.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")>=IPv4(address: "192.167.0.0", subnetMask: "255.255.255.0"), equals(true)));

      test("Testing if it's the same.", () => expect(IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0")>=IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0"), equals(true)));

      test("Testing if it is not larger or equal.",() => expect(IPv4(address: "192.167.0.0", subnetMask: "255.255.255.0")>=IPv4(address: "192.168.0.0", subnetMask: "255.255.255.0"), equals(false)));
    });
  });
}