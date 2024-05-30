import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moovup_test/controller/data_controller.dart';
import 'package:moovup_test/models/user_model.dart';
import 'package:moovup_test/widgets/user_item.dart';

class UserList extends StatefulWidget {
  final ScrollController scrollController;
  final Function(User) onTap;
  const UserList({
    super.key,
    required this.scrollController,
    required this.onTap,
  });

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DataController controller = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          //  physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          controller: widget.scrollController,
          shrinkWrap: true,
          itemCount: controller.users.value.length,
          itemBuilder: (context, index) {
            return UserItem(
              user: controller.users.value[index],
            ).paddingOnly(
              bottom: 16,
            );
          }),
    );
  }
}
