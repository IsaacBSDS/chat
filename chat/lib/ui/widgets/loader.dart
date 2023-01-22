import 'package:chat/ui/theme/colors.dart';
import 'package:chat/utils/responsive.dart';
import 'package:flutter/material.dart';

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        primary: false,
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
          width: responsive.wp(25),
          height: responsive.wp(25),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Center(
            child: CircularProgressIndicator(
              color: CustomColors.purple,
            ),
          ),
        )),
      ),
    );
  }
}

openLoader(BuildContext context) {
  showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => const _LoadingIndicator(),
      barrierDismissible: false);
}

closeLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
