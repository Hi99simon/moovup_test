import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  static const CameraPosition _hongKongCentre = CameraPosition(
    target: LatLng(22.3193, 114.1694),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _hongKongCentre,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.20,
            maxChildSize: 0.60,
            controller: draggableScrollableController,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                child: Container(
                  height: 800,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
