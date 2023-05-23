import 'ipv4_address.dart';

class IPv4Network extends IPv4{
  IPv4Network({required String address, required String subnetMask}):super(address: address, subnetMask: subnetMask);

  IPv4Network.withPrefix({required String address, required String prefix}):super.withPrefix(address: address, prefix: prefix);

  IPv4Network.withListOfOctetsAndSubnetMask({required List<int> listOfOctets, required String subnetMask}):super.withListOfOctetsAndSubnetMask(listOfOctets: listOfOctets, subnetMask: subnetMask);

  IPv4Network.withListOfOctetsAndPrefix({required List<int> listOfOctets, required String prefix}):super.withListOfOctetsAndPrefix(listOfOctets: listOfOctets, prefix: prefix);

  IPv4Network.withFormatedNetworkAddressAndNumericPrefix({required String address, required int prefix}):super.withFormatedNetworkAddressAndNumericPrefix(address: address, prefix: prefix);

  IPv4Network.withFormatedAddress({required String formatedAddress}):super.withFormatedAddress(formatedAddress: formatedAddress);

  List<IPv4> get ipAddresses => List<IPv4>.generate(size-2, (index) => this+(index+1));

  IPv4 get broadcast => this+size-1;

  isIn(IPv4 address){
    return ipAddresses.any((element) => element == address);
  }
}