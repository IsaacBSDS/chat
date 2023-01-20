import 'package:chat/routes/names.dart';
import 'package:chat/theme/colors.dart';
import 'package:chat/utils/responsive.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_text.dart';
import 'package:chat/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: CustomColors.weakGrey,
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: responsive.wp(100),
          height: responsive.hp(100),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: responsive.wp(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: responsive.hp(5)),
                FlutterLogo(size: responsive.dp(14)),
                SizedBox(height: responsive.hp(2)),
                CustomText(
                  text: "Chat :)",
                  fontSize: responsive.dp(4),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: responsive.hp(10)),
                _TextFormFieldShadow(
                  child: CustomTextFormField(
                    hintText: "username",
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: responsive.dp(2),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(2)),
                _TextFormFieldShadow(
                  child: CustomTextFormField(
                    hintText: "password",
                    obscureText: true,
                    maxLines: 1,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: responsive.dp(2),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(3)),
                SizedBox(
                  width: responsive.wp(100),
                  height: responsive.hp(5.5),
                  child: CustomButtom(
                    color: CustomColors.purple,
                    child: CustomText(
                      text: "Ingresar",
                      fontWeight: FontWeight.w600,
                      fontSize: responsive.dp(2),
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(height: responsive.hp(10)),
                CustomText(
                  text: "¿No tienes cuenta?",
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: responsive.dp(1.5),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RoutesNames.register),
                  child: CustomText(
                    text: "Crea una ahora!",
                    fontSize: responsive.dp(1.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: responsive.hp(8)),
                CustomText(
                  text: "Terminos y condiciones de uso",
                  fontSize: responsive.dp(1.2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFormFieldShadow extends StatelessWidget {
  final Widget child;
  const _TextFormFieldShadow({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.2),
              offset: const Offset(0, 5),
              blurRadius: 10)
        ],
      ),
      child: child,
    );
  }
}
