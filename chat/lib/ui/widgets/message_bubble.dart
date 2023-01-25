import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/utils/responsive.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.text,
    required this.uid,
  });

  final String text;
  final String uid;
  @override
  Widget build(BuildContext context) {
    final bool isMe = uid == Session.instance.loginResponse.user!.uid;
    final Responsive responsive = Responsive.of(context);
    return SizedBox(
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: responsive.wp(70)),
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(3),
            vertical: responsive.hp(1),
          ),
          margin: EdgeInsets.symmetric(vertical: responsive.hp(0.2)),
          decoration: BoxDecoration(
            color: isMe ? CustomColors.purple : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: text,
            color: Colors.white,
            fontSize: responsive.dp(1.8),
          ),
        ),
      ),
    );
  }
}
