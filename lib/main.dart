import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Map(),
    );
  }
}

const MAPBOX_ACCESS_TOKEN =
    // "pk.eyJ1IjoieWRnZ2dnIiwiYSI6ImNsMmc1Z2YzbjAwbjQzZW13b3dxbHQ1c24ifQ.RuRSZjLvfCYD6m_tExfEoQ";
    'pk.eyJ1IjoiZGllZ292ZWxvcGVyIiwiYSI6ImNrdGppMnh0bjFjZ3MzMm5sejRtcTlwbTQifQ.lwdbukS6p7bBWBuk2URBKg';
const MAPBOX_STYLE = 'mapbox/dark-v10';

const MARKER_COLOR = Color(0xFFf75e63);
const MARKER_SIZE_EXPANDED = 45.0;
const MARKER_SIZE_SHRINKED = 35.0;

final _myLocation = LatLng(37.49794587164024, 127.02761007446635);

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];

      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(
                  () {
                    _pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut);
                    print('Selected: ${mapItem.title}');
                  },
                );
              },
              child:
                  // [_LocationMarker1(
                  //   selected: _selectedIndex == i,
                  // ),
                  _LocationMarker1(
                      selected: _selectedIndex == i, mapMarker: mapItem),
              // ],
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('Macgyver'),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.person_pin_circle_rounded),
            onPressed: () => null,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: _myLocation,
            ),
            nonRotatedLayers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/ydgggg/cl2j2qkk8002t14mjde1a3ngm/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieWRnZ2dnIiwiYSI6ImNsMmc1Z2YzbjAwbjQzZW13b3dxbHQ1c24ifQ.RuRSZjLvfCYD6m_tExfEoQ',
                // 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              MarkerLayerOptions(
                markers: _markers,
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                      height: 60,
                      width: 60,
                      point: _myLocation,
                      builder: (_) {
                        return _MyLocationMarker(_animationController);
                      }),
                ],
              ),
            ],
          ),
          // Add a pageview
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class _LocationMarker extends StatefulWidget {
//   const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

//   final bool selected;

//   @override
//   State<_LocationMarker> createState() => _LocationMarkerState();
// }

// class _LocationMarkerState extends State<_LocationMarker> {
//   @override
//   Widget build(BuildContext context) {
//     final size = widget.selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;

//     return Center(
//       child: AnimatedContainer(
//         height: size,
//         width: size,
//         duration: const Duration(milliseconds: 400),
//         // child: Image.asset(mapMarker.logo),
//         child: Image.asset('lib/assets/marker.png'),
//       ),
//     );
//   }
// }

class _LocationMarker1 extends StatelessWidget {
  const _LocationMarker1({
    Key? key,
    required this.mapMarker,
    required bool selected,
  }) : super(key: key);

  final MapMarker mapMarker;
  @override
  Widget build(BuildContext context) {
// class _LocationMarker1 extends StatefulWidget {
//   const _LocationMarker1({Key? key, this.selected = false}) : super(key: key);

//   final bool selected;

//   @override
//   State<_LocationMarker1> createState() => _LocationMarker1State();
// }

// class _LocationMarker1State extends State<_LocationMarker1> {
    // @override
    // Widget build(BuildContext context) {
    //   final size = widget.selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;

    //   var mapMarker;
    return Center(
      child: AnimatedContainer(
        height: 35,
        width: 35,
        duration: const Duration(milliseconds: 400),
        child: Image.asset(mapMarker.marker),
        // child: Image.asset('lib/assets/marker.png'),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key})
      : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    final size = 50.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size * newValue,
              width: size * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MARKER_COLOR.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: MARKER_COLOR,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            mapMarker.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              mapMarker.title,
                              style: _styleTitle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              mapMarker.address,
                              style: _styleAddress,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,

////////////////업체 클릭시 업체 상세페이지//////////////////////////

                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mapMarker.title,
                                      style: _styleTitle,
                                    ),

                                    /////////////// 맥북, 아이폰 구분 필요
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                '맥북',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                '아이패드',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                '아이폰',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: Text(
                                                '액세서리',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /////////////// 아이콘
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.bookmark_border,
                                              size: 35,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text('저장하기'),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 60),
                                        Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.call,
                                              size: 35,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text('전화걸기'),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 60),
                                        Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.edit_note,
                                              size: 35,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text('리뷰쓰기'),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Container(
                                        width: 500,
                                        child: Divider(
                                          color:
                                              Color.fromARGB(95, 158, 158, 158),
                                          thickness: 1.0,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            SizedBox(width: 10),
                                            Text(
                                              mapMarker.address,
                                              style: _styleAddress,
                                            ),
                                          ],
                                        ),

                                        ///////영업시간 데이터 필요
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 45),
                                                    child: Icon(Icons.schedule),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 45),
                                                child: Text('영업시간'),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('월-금 09:00~20:00'),
                                                  SizedBox(height: 5),
                                                  Text('토요일 09:00~20:00'),
                                                  SizedBox(height: 5),
                                                  Text('일요일 휴무')
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Container(
                                        width: 500,
                                        child: Divider(
                                          color:
                                              Color.fromARGB(95, 158, 158, 158),
                                          thickness: 1.0,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '맥가이버에 등록된 만족도',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                ///////데이터 필요

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '4.0',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(
                                        Icons.star,
                                        size: 40,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40,
                                        color:
                                            Color.fromARGB(255, 216, 216, 216),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Container(
                                    width: 500,
                                    child: Divider(
                                      color: Color.fromARGB(95, 158, 158, 158),
                                      thickness: 1.0,
                                    ),
                                  ),
                                ),

                                /////데이터 필요
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('맥가이버에 등록된 업체 평균 대비 12% 저렴합니다.'),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Container(
                                    width: 500,
                                    child: Divider(
                                      color: Color.fromARGB(43, 190, 188, 188),
                                      thickness: 10.0,
                                    ),
                                  ),
                                ),

                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'Review',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      DefaultTabController(
                                        length: 4,
                                        initialIndex: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: TabBar(
                                                labelColor: Colors.black,
                                                unselectedLabelColor:
                                                    Color.fromARGB(
                                                        255, 182, 182, 182),
                                                tabs: [
                                                  Tab(
                                                    text: '맥북',
                                                  ),
                                                  Tab(
                                                    text: '아이패드',
                                                  ),
                                                  Tab(
                                                    text: '아이폰',
                                                  ),
                                                  Tab(
                                                    text: '액세서리',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      color: Color.fromARGB(
                                                          186, 255, 255, 255),
                                                      width: 0.5),
                                                ),
                                              ),
                                              child: TabBarView(
                                                children: <Widget>[
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        '등록된 리뷰가 없습니다.',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        '등록된 리뷰가 없습니다.',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        '등록된 리뷰가 없습니다.',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        '등록된 리뷰가 없습니다.',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),

////////////////업체 클릭시 업체 상세페이지//////////////////////////

                    color: Colors.amber,
                    // color: MARKER_COLOR,
                    elevation: 6,
                    child: Text(
                      'More',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
