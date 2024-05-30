import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/models/user_model.dart';
import 'package:moovup_test/network/api.dart';
import 'package:screenshot/screenshot.dart';

class DataController extends GetxController {
  late GoogleMapController? googleMapController;
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  Rx<List<User>> users = Rx<List<User>>([]);
  Rx<List<User>> selectedUsers = Rx<List<User>>([]);
  RxSet<Marker> markers = RxSet<Marker>();
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  Future<void> initUsers() async {
    List<Map<String, dynamic>> response = await UserApi.getUserList();

    List<User> userList = [];
    List<User> validUsers = [];

    for (var user in response) {
      User newUser = User.fromJson(user);
      userList.add(newUser);

      if (newUser.location != null && newUser.location!.latitude != null && newUser.location!.longitude != null) {
        validUsers.add(newUser);
      }
    }

    users.value = userList;
    selectedUsers.value = validUsers;
  }

  Future<void> putMarker(
    ScreenshotController screenshotController,
    String imgPath,
    title,
    Color markerColor,
    String markerId,
    LatLng latLng,
  ) async {
    Uint8List? imgU8 = await _getUserProfileImage(imgPath: imgPath);

    await screenshotController
        .captureFromWidget(
      Transform.scale(
        scale: Get.pixelRatio / 3.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imgU8 != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.memory(
                  imgU8,
                  height: 24,
                  width: 24,
                ),
              ).paddingOnly(bottom: 4),
            // Other widget content
          ],
        ).paddingSymmetric(horizontal: 8, vertical: 4),
      ),
    )
        .then((capturedImage) {
      final BitmapDescriptor markerIcon = BitmapDescriptor.fromBytes(capturedImage);
      final Marker marker = Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: markerIcon,
        onTap: () {
          // Get.back();
          log("tapped icon");
        },
      );
      markers.add(marker);
      update();
      log("marker added");
    });
  }

  Future<Uint8List?> _getUserProfileImage({required String imgPath}) async {
    try {
      final response = await http.get(Uri.parse(imgPath));
      return response.bodyBytes;
    } catch (e) {
      log("Error fetching user profile image: $e");
      return null;
    }
  }
}
