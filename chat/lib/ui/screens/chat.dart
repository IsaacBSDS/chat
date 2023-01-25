// ignore_for_file: must_be_immutable

import 'package:chat/controllers/socket.dart';
import 'package:chat/models/users.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/ui/widgets/custom_text_form_field.dart';
import 'package:chat/ui/widgets/message_bubble.dart';
import 'package:chat/utils/responsive.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();

  final TextEditingController controller = TextEditingController();

  final List<MessageBubble> _messages = [];
  String from = "";

  dynamic listenMessage(dynamic data) {
    from = data["from"];
    _messages.add(
      MessageBubble(
        text: data["message"],
        uid: data["from"],
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    final SocketService socketService = context.read();
    socketService.on("message", (data) => listenMessage(data));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    final SocketService socketService = context.watch();
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: BackButton(color: CustomColors.purple),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: r.dp(1.5),
              backgroundColor: CustomColors.purple.withOpacity(0.5),
              child: CustomText(
                text: user.username.substring(0, 2),
                color: Colors.white,
                fontSize: r.dp(1.3),
              ),
            ),
            const SizedBox(width: 10),
            CustomText(
              text: user.username,
              color: CustomColors.purple,
              fontSize: r.dp(1.6),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: r.wp(3),
                    right: r.wp(3),
                    bottom: r.hp(1),
                  ),
                  reverse: true,
                  itemCount: from == user.uid ? _messages.length : 0,
                  itemBuilder: (context, index) => from == user.uid
                      ? _messages.reversed.toList()[index]
                      : SizedBox.fromSize(),
                ),
              ),
            ),
            _InputMessage(
              focusNode,
              controller,
              onChanged: (value) {
                _messages.add(
                  MessageBubble(
                    text: controller.text,
                    uid: Session.instance.loginResponse.user!.uid,
                  ),
                );
                setState(() {});
                // mandar mensaje
                socketService.emit("message", {
                  "from": Session.instance.loginResponse.user!.uid,
                  "to": user.uid,
                  "message": controller.text.trim()
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InputMessage extends StatelessWidget {
  const _InputMessage(this.focusNode, this.controller,
      {required this.onChanged});

  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);

    return Container(
      color: Colors.grey.withOpacity(0.18),
      height: focusNode.hasFocus ? r.hp(8) : r.hp(10),
      padding: EdgeInsets.symmetric(horizontal: r.wp(4), vertical: r.hp(1)),
      width: r.wp(100),
      child: Row(
        crossAxisAlignment: focusNode.hasFocus
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: r.hp(5),
              child: CustomTextFormField(
                controller: controller,
                focusNode: focusNode,
                hintText: "Escribe tu mensaje",
                onChanged: (String value) {},
              ),
            ),
          ),
          SizedBox(
            width: r.wp(3),
          ),
          Container(
            height: r.hp(5.5),
            width: r.hp(5.5),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: CustomColors.purple.withOpacity(0.8),
              child: InkWell(
                onTap: () {
                  if (controller.text.trim().isEmpty) return;
                  onChanged(controller.text);
                  controller.clear();
                },
                splashColor: CustomColors.purple,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: r.dp(2.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
