import 'package:flutter/material.dart';
import 'package:moovup_test/models/user_model.dart';
import 'package:moovup_test/network/api.dart';
import 'package:moovup_test/widgets/user_item.dart';

class UserList extends StatefulWidget {
  final ScrollController scrollController;
  const UserList({super.key,required this.scrollController});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<Map<String, dynamic>> response = await UserApi.getUserList();
    if (response != null) {
      List<User> userList = [];
      for (var user in response) {
        userList.add(User.fromJson(user));
      }
      setState(() {
        users = userList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserItem(user: users[index]);
        });
  }
}
