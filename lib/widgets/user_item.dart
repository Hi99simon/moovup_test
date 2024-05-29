import 'package:flutter/material.dart';
import 'package:moovup_test/models/user_model.dart';

class UserItem extends StatefulWidget {
  final User user;
  const UserItem({
    super.key,
    required this.user,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.user.picture),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${widget.user.name.first} ",
                    style: TextStyle(
                        // Add any desired styles for the first name
                        ),
                  ),
                  TextSpan(
                    text: "${widget.user.name.last}",
                    style: TextStyle(
                        // Add any desired styles for the last name
                        ),
                  ),
                ],
              ),
            ),
            Text(widget.user.email),
          ],
        ),
      ],
    );
  }
}
