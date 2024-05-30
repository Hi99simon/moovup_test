import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/controller/data_controller.dart';
import 'package:moovup_test/models/user_model.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    DataController controller = Get.find();

    double? latitude = user.location.latitude;
    double? longitude = user.location.longitude;
    bool hasLocation = latitude != null && longitude != null;
    return Material(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          // Add your onTap logic here

          if (!hasLocation) return;

          LatLng latLng = LatLng(latitude, longitude);
          controller.animateCamera(latlng: latLng);
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFCCCCCC),
              backgroundImage: NetworkImage(user.picture),
              radius: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${user.name.first} ",
                          style: const TextStyle(
                            color: Color(0xFF2F2F2F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: user.name.last,
                          style: const TextStyle(
                            color: Color(0xFF2F2F2F),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Color(0xFFA6A6A6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (hasLocation) ...[
              Icon(
                Icons.location_on,
                color: Colors.pink,
                size: 24,
              )
            ]
          ],
        ).paddingAll(8),
      ),
    );
  }
}
