import 'package:latlong2/latlong.dart';

class MapMarker1 {
  const MapMarker1(
      {required this.image,
      required this.title,
      required this.address,
      required this.location,
      required this.marker});

  final String image;
  final String title;
  final String address;
  final LatLng location;
  final String marker;
}

final _locations = [
  LatLng(37.5029568, 127.046507),
  LatLng(37.5264966, 127.027651),
  LatLng(37.5041551, 127.046395),
  LatLng(37.5180913, 127.022185),
  LatLng(37.5259285, 127.029438),
  LatLng(37.4910143, 127.031596),
  LatLng(37.5257578, 127.027232),
];

const _path = 'lib/assets/';

final mapMarkers = [
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_marcos.png',
    title: '아이픽스 강남수리센터',
    address: '서울 강남구 테헤란로 322 \n한신인터밸리24빌딩 1층 \n서관 115호',
    location: _locations[0],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_paavo.png',
    title: '아이픽스존\n압구정 아이폰수리',
    address: '서울 강남구 압구정로 164',
    location: _locations[1],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_papa_jhons.jpeg',
    title: '아이폰119 강남 선릉 \n아이폰 수리센터',
    address: '서울 강남구 테헤란로 323 \n휘닉스오피스텔 지하1층 25호',
    location: _locations[2],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_pizza_hut.png',
    title: 'Pizza Hut',
    address: 'Address Hut 123',
    location: _locations[3],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_pizza_patron.jpeg',
    title: ' Patron',
    address: 'Address Patron 123',
    location: _locations[4],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_pump_house.jpeg',
    title: 'Pump House',
    address: 'Address Pump 123',
    location: _locations[5],
  ),
  MapMarker1(
    marker: '${_path}marker.png',
    image: '${_path}logo_super_pizza.jpeg',
    title: 'Super Pizza',
    address: 'Address Super 123',
    location: _locations[6],
  ),
];
