import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widgets/button/appbar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/domain/usecases/auth/signup.dart';
import 'package:spotify_app/presentation/auth/pages/sign_in.dart';
import 'package:spotify_app/presentation/root/pages/root.dart';
import 'package:spotify_app/service_locator.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _registerText(),
              const SizedBox(height: 40),

              _fullNameField(context),
              const SizedBox(height: 20),

              _emailField(context),
              const SizedBox(height: 20),

              _passwordField(context),
              const SizedBox(height: 30),

              BasicAppButton(
                title: "Create Account",
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                    params: CreateUserReq(
                      fullName: _fullName.text.toString(),
                      email: _email.text.toString().toString(),
                      password: _password.text,
                    ),
                  );
                  result.fold(
                    (l) {
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => RootPage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= TITLE =================

  Widget _registerText() {
    return const Text(
      "Register",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    );
  }

  // ================= FULL NAME =================

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  // ================= EMAIL =================

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  // ================= PASSWORD =================

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  // ================= SIGN IN =================

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account?"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignIn()),
              );
            },
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
