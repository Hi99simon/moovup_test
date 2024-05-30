import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moovup_test/models/user_model.dart';

class UserInfoDialog extends StatefulWidget {
  final User user;
  const UserInfoDialog({
    super.key,
    required this.user,
  });

  @override
  State<UserInfoDialog> createState() => _UserInfoDialogState();
}

class _UserInfoDialogState extends State<UserInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Container(
        decoration: BoxDecoration(color: Color(0xffFAFAFA), borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Profile",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 16,
                  ),
                )
              ],
            ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFCCCCCC),
              ),
              child: ClipOval(
                child: Image.network(
                  widget.user.picture,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "${widget.user.name.first} ${widget.user.name.last}",
              style: TextStyle(
                color: Color(0xff2F2F2F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.user.email}",
              style: TextStyle(
                color: Color(0xff2F2F2F),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ).paddingAll(
          16,
        ),
      ),
    );
  }
}
