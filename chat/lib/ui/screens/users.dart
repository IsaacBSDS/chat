import 'dart:convert';

import 'package:chat/controllers/socket.dart';
import 'package:chat/controllers/users.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/users.dart';
import 'package:chat/ui/routes/names.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/ui/widgets/loader.dart';
import 'package:chat/ui/widgets/modal.dart';
import 'package:chat/utils/responsive.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  _listAllUsers(BuildContext context) async {
    final UsersController usersController = context.read();
    openLoader(context);
    try {
      await usersController.listAllUsers();
      if (!mounted) return;
      closeLoader(context);
    } on UseCaseException catch (e) {
      closeLoader(context);
      openError(context, e.message);
    } catch (e) {
      closeLoader(context);
      openError(context, "Hubo un error.\nIntente de nuevo más tarde.");
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listAllUsers(context);
      final SocketService socketService = context.read();
      final UsersController usersController = context.read();
      socketService.on(
        "user_connect",
        (data) => usersController.updateUsersList(
          UserModel.fromJson(
            json.decode(data),
          ),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final SocketService socketService = context.watch();
    final UsersController usersController = context.watch();
    return Scaffold(
      backgroundColor: CustomColors.weakGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: Session.instance.loginResponse.user?.name ?? "",
          color: CustomColors.purple,
          fontSize: responsive.dp(2.2),
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            socketService.serverStatus != ServerStatus.online
                ? Icons.offline_bolt
                : Icons.check_circle,
            color: socketService.serverStatus != ServerStatus.online
                ? Colors.red
                : Colors.green,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              socketService.disconnect();
              Session.instance.stop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesNames.login,
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
            color: Colors.red,
          )
        ],
      ),
      body: usersController.isUsersListNotEmpty
          ? UsersList(users: usersController.usersListResponse.users!)
          : EmptyUsers(),
    );
  }
}

class EmptyUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    return Center(
      child: CustomText(
        text: "No hay usuarios :)",
        fontWeight: FontWeight.w600,
        fontSize: r.dp(2),
      ),
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
