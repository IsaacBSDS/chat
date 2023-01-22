import 'package:chat/models/users.dart';
import 'package:chat/ui/routes/names.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/utils/responsive.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final List<UserModel> users = [
    UserModel(
      online: true,
      username: "Sac Nara",
      name: "Isaac Daniel",
      uid: "1a",
    ),
    UserModel(
      online: false,
      username: "Sac Boop",
      name: "Isaac Benavides",
      uid: "2a",
    ),
    UserModel(
      online: true,
      username: "Isaac",
      name: "Isaac",
      uid: "3a",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.weakGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: Session.instance.loginResponse.user!.name,
          color: CustomColors.purple,
        ),
        leading: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app,
            ),
            color: Colors.red,
          )
        ],
      ),
      body: UsersList(users: users),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);

    return RefreshIndicator(
      color: CustomColors.purple,
      onRefresh: () async {},
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: users.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          final UserModel user = users[index];
          return ListTile(
            onTap: () => Navigator.of(context).pushNamed(
              RoutesNames.chat,
              arguments: user,
            ),
            title: CustomText(
              text: user.username,
              fontWeight: FontWeight.w600,
              fontSize: r.dp(1.8),
            ),
            subtitle: CustomText(
              text: user.name,
              fontWeight: FontWeight.w500,
              fontSize: r.dp(1.6),
            ),
            leading: CircleAvatar(
              backgroundColor: CustomColors.purple.withOpacity(0.5),
              child: CustomText(
                text: user.username.substring(0, 2),
                color: Colors.white,
              ),
            ),
            trailing: CircleAvatar(
              radius: r.dp(0.5),
              backgroundColor: user.online ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
