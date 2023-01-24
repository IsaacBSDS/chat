// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat/controllers/register.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_button.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/ui/widgets/custom_text_form_field.dart';
import 'package:chat/ui/widgets/loader.dart';
import 'package:chat/ui/widgets/modal.dart';
import 'package:chat/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  _register(BuildContext context) async {
    final RegisterController registerController = context.read();
    openLoader(context);
    try {
      final bool response = await registerController.register();
      closeLoader(context);
      if (response) {
        openError(
          context,
          "Usuario creado :)",
          onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
        );
      }
    } on UseCaseException catch (e) {
      closeLoader(context);
      openError(context, e.message);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      closeLoader(context);
      openError(context, "Hubo un error.\nIntente de nuevo más tarde.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final RegisterController registerController = context.watch();

    return Scaffold(
      backgroundColor: CustomColors.weakGrey,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                    text: "Registrarse :)",
                    fontSize: responsive.dp(4),
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: responsive.hp(8)),
                  _TextFormFieldShadow(
                    child: CustomTextFormField(
                      iconColor: CustomColors.purple,
                      controller: registerController.usernameController,
                      hintText: "Usuario",
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: responsive.dp(2),
                        color: CustomColors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(2)),
                  _TextFormFieldShadow(
                    child: CustomTextFormField(
                      textInputType: TextInputType.visiblePassword,
                      iconColor: CustomColors.purple,
                      controller: registerController.passwordController,
                      hintText: "Contraseña",
                      obscureText: true,
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: responsive.dp(2),
                        color: CustomColors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(2)),
                  _TextFormFieldShadow(
                    child: CustomTextFormField(
                      textInputType: TextInputType.visiblePassword,
                      iconColor: CustomColors.purple,
                      controller: registerController.nameController,
                      hintText: "Nombre",
                      maxLines: 1,
                      prefixIcon: Icon(
                        Icons.person_pin,
                        size: responsive.dp(2),
                        color: CustomColors.purple,
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
                        text: "Registrarse",
                        fontWeight: FontWeight.w600,
                        fontSize: responsive.dp(2),
                      ),
                      onTap: () => _register(context),
                    ),
                  ),
                  SizedBox(height: responsive.hp(5)),
                  CustomText(
                    text: "¿Ya tienes cuenta?",
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.dp(1.5),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: CustomText(
                      text: "Ingresa!",
                      fontSize: responsive.dp(1.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: responsive.hp(6)),
                  CustomText(
                    text: "Terminos y condiciones de uso",
                    fontSize: responsive.dp(1.2),
                  )
                ],
              ),
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
