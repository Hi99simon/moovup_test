import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:moovup_test/models/user_model.dart';

class UserItem extends StatefulWidget {
  final User user;
  final Function(User) onTap;
  const UserItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
          onTap: () {
            widget.onTap(widget.user);
          },
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(
                  0xFFF7F7F7,
                ),
                backgroundImage: NetworkImage(widget.user.picture),
                radius: 24,
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
                            color: Color(
                              0xFF2F2F2F,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // Add any desired styles for the first name
                          ),
                        ),
                        TextSpan(
                          text: "${widget.user.name.last}",
                          style: TextStyle(
                            color: Color(
                              0xFF2F2F2F,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // Add any desired styles for the last name
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(
                      color: Color(
                        0xFFA6A6A6,
                      ),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(8)),
    );
  }
}
