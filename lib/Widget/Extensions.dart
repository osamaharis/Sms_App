import 'package:flutter/material.dart';


const USER_INFO = "USER_INFO";
const Role_Permission_data="Role_Permission_data";
const CURRENT_LOCALE = "CURRENT_LOCALE";
const BASE_URL = "http://192.168.0.33:5000/";
const IMG_BASE_URL = "http://192.168.0.33:5000/";
// const BASE_URL = "https://tm.mmcgbl.ae/api/";
// const IMG_BASE_URL = "https://tm.mmcgbl.ae/api/";

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

Map<String, String> getHeader(String key) => {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Key": key
    };


