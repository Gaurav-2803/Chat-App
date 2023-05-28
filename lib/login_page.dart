import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/login_txt_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final Uri _githubUrl = Uri.parse("https://github.com/Gaurav-2803/");
  final Uri _linkedinUrl =
      Uri.parse("https://www.linkedin.com/in/gaurav-agrawal-dev/");
  final _form_key = GlobalKey<FormState>();
  final user_name_controller = TextEditingController();
  final password_controller = TextEditingController();

  Future<void> login_user(BuildContext context) async {
    if (_form_key.currentState != null && _form_key.currentState!.validate()) {
      if (kDebugMode) {
        print(user_name_controller.text);
        print(password_controller.text);
        await context.read<AuthService>().loginUser(user_name_controller.text);
        Navigator.pushReplacementNamed(
          context,
          '/chat',
          arguments: user_name_controller.text,
        );
        print("Login Successsful");
      }
    } else {
      if (kDebugMode) {
        print("Login Unsuccesssful");
      }
    }
  }

  Widget _buildHeader(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Let's Sign You In",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.red,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        verticalSpacing(12),
        const Text(
          textAlign: TextAlign.center,
          "Welcome Back!\nYou've been missed :)",
          style: TextStyle(
            fontSize: 25,
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        verticalSpacing(24),
        Image.asset(
          "assets/atc_logo.jpg",
          height: 200,
          width: 200,
        ),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _form_key,
          child: Column(
            children: [
              verticalSpacing(24),
              txt_form_field(
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return "Wrong Username";
                  } else if (value != null && value.isEmpty) {
                    return "No Username";
                  }
                  return null;
                },
                controller: user_name_controller,
                hintText: "Type your Username",
              ),
              verticalSpacing(24),
              txt_form_field(
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return "Password length invalid";
                  } else if (value != null && value.isEmpty) {
                    return "No Password";
                  }
                  return null;
                },
                controller: password_controller,
                hintText: "Type your Password",
                obscureTxt: true,
              ),
            ],
          ),
        ),
        verticalSpacing(24),
        ElevatedButton(
          onPressed: () async {
            await login_user(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        verticalSpacing(12),
        InkWell(
          splashColor: Colors.blue,
          onTap: () async {
            if (kDebugMode) {
              print("Forgot Single Tap");
            }
          },
          child: const Text(
            "Forgot Password",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalSpacing(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterSocialButton(
              onTap: () async {
                if (!await launchUrl(
                  _githubUrl,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch this url!');
                }
              },
              mini: true,
              buttonType: ButtonType.github,
            ),
            horizontalSpacing(24),
            FlutterSocialButton(
              onTap: () async {
                if (!await launchUrl(
                  _linkedinUrl,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch this url!');
                }
              },
              mini: true,
              buttonType: ButtonType.linkedin,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _buildHeader(context),
                        _buildForm(context),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildForm(context),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                _buildForm(context),
                _buildFooter(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
