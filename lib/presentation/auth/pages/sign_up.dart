import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/widgets/button/appbar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/presentation/auth/pages/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height * 0.75),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: _onRegister,
                    title: "Create Account",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= TITLE =================

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  // ================= FULL NAME =================

  Widget _fullNameField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Full name is required";
        }
        if (value.length < 3) {
          return "Name must be at least 3 characters";
        }
        return null;
      },
    );
  }

  // ================= EMAIL =================

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }

  // ================= PASSWORD =================

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  // ================= ACTION =================

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Name: ${_nameController.text}");
      debugPrint("Email: ${_emailController.text}");
      debugPrint("Password: ${_passwordController.text}");
    }
  }

  // ================= SIGN IN =================

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SignIn()),
              );
            },
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
