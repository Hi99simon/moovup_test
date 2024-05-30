import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/models/user_model.dart';
import 'package:moovup_test/network/api.dart';
import 'package:moovup_test/widgets/user_info_dialog.dart';
import 'package:screenshot/screenshot.dart';

class DataController extends GetxController {
  late GoogleMapController? googleMapController;
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  Rx<List<User>> users = Rx<List<User>>([]);
  Rx<List<User>> selectedUsers = Rx<List<User>>([]);
  Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  Future<void> initUsers() async {
    List<Map<String, dynamic>> response = await UserApi.getUserList();

    List<User> userList = [];
    List<User> validUsers = [];

    for (var user in response) {
      User newUser = User.fromJson(user);
      userList.add(newUser);

      if (newUser.location.latitude != null && newUser.location.longitude != null) {
        validUsers.add(newUser);
      }
    }

    userList.removeWhere((user) => validUsers.contains(user));
    userList.insertAll(0, validUsers);

    users.value = userList;
    selectedUsers.value = validUsers;
    animateCamera(
      latlng: LatLng(
        users.value.first.location.latitude!,
        users.value.first.location.longitude!,
      ),
    );

    for (int i = 0; i < selectedUsers.value.length; i++) {
      var user = selectedUsers.value[i];
      putMarker(
        user.picture,
        user.name.first,
        user.id,
        LatLng(user.location.latitude!, user.location.longitude!),
      );
      if (i == 0) {
        draggableScrollableController.animateTo(
          0.5,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }
    }
  }

  animateCamera({
    required LatLng latlng,
  }) {
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latlng,
          zoom: 14,
        ),
      ),
    );
  }

  Future<void> putMarker(
    String imgPath,
    title,
    String markerId,
    LatLng latLng,
  ) async {
    Uint8List? imgU8 = await _getUserProfileImage(imgPath: imgPath);

    ScreenshotController screenshotController = ScreenshotController();
    await screenshotController
        .captureFromWidget(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imgU8 != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.memory(
                imgU8,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
            ).paddingOnly(bottom: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 8, vertical: 4),
    )
        .then((capturedImage) {
      final BitmapDescriptor markerIcon = BitmapDescriptor.fromBytes(capturedImage);
      final Marker marker = Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: markerIcon,
        onTap: () {
          log("tapped icon $markerId");
          Get.dialog(
            Dialog(
              child: UserInfoDialog(
                user: selectedUsers.value.firstWhere((element) => element.id == markerId),
              ),
            ),
          );
        },
      );
      markers.value = {
        ...markers.value,
        marker,
      };
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
