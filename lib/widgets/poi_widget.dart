import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapp/utils/api_service.dart';

class POIWidget extends StatefulWidget {
  final MaplibreMapController? mapController;

  POIWidget({this.mapController});

  @override
  _POIWidgetState createState() => _POIWidgetState();
}

class _POIWidgetState extends State<POIWidget> {
  List<Symbol> _poiSymbols = [];
  Map<Symbol, Map<String, dynamic>> _poiData = {};

  @override
  void initState() {
    super.initState();
    if (widget.mapController != null) {
      _fetchPOIs();
    }
  }

  Future<void> _fetchPOIs() async {
    try {
      final data = await ApiService.fetchPOIs(
        27.7192873, 85.3238007, // Replace with dynamic location if needed
      );
      _plotPOIs(data);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching POIs: $e");
    }
  }

  Future<void> _plotPOIs(Map<String, dynamic> data) async {
    setState(() {
      _poiSymbols.clear();
      _poiData.clear();
    });

    for (var poi in data['places']) {
      final latLng = LatLng(poi['lat'], poi['lng']);

      try {
        final symbol = await widget.mapController!.addSymbol(
          SymbolOptions(
            geometry: latLng,
            iconImage: "assets/ic_marker.png",
            textField: poi['name'] ?? '',
            textOffset: Offset(0, 2),
          ),
        );
        _poiSymbols.add(symbol);
        _poiData[symbol] = poi;

        widget.mapController!.onSymbolTapped.add((symbol) {
          Fluttertoast.showToast(msg: "Clicked on: ${_poiData[symbol]!['name']}");
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Error adding symbol: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
