import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/widgets/user_list.dart';

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
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Image.asset(
                  "assets/word_logo.png", // Note the correct asset path
                  height: 36,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: false,
                      initialCameraPosition: _hongKongCentre, // Assuming you have defined this variable
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ).paddingSymmetric(horizontal: 16),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.20,
            maxChildSize: 0.60,
            controller: draggableScrollableController, // Assuming you have defined this variable
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 4,
                      blurRadius: 16,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tap to lookup your friend's position",
                      style: TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ).paddingSymmetric(horizontal: 16).paddingOnly(
                          top: 16,
                        ),
                    Expanded(
                        child: UserList(
                      scrollController: scrollController,
                      onTap: (user) {
                        HapticFeedback.heavyImpact();
                      },
                    ).paddingAll(8)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
