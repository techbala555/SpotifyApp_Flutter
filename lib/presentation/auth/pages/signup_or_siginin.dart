import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/button/appbar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_images.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/core/config/theme/app_colors.dart';
import 'package:spotify_app/presentation/auth/pages/sign_in.dart';
import 'package:spotify_app/presentation/auth/pages/sign_up.dart';

class SignupOrSiginin extends StatefulWidget {
  const SignupOrSiginin({super.key});

  @override
  State<SignupOrSiginin> createState() => _SignupOrSigininState();
}

class _SignupOrSigininState extends State<SignupOrSiginin>
    with SingleTickerProviderStateMixin {
  bool _isNavigating = false;

  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _navigate(Widget page) async {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);

    await _animController.forward();
    await _animController.reverse();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ).then((_) {
      if (mounted) setState(() => _isNavigating = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 700;

    return Scaffold(
      body: Stack(
        children: [
          const BasicAppbar(),

          // ================= BACKGROUND PATTERNS =================
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.toppattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottompattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBg),
          ),

          // ================= CONTENT =================
          SafeArea(
            child: Center(
              child: Container(
                width: isWideScreen ? 480 : double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 40 : 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ================= LOGO =================
                    SvgPicture.asset(
                      AppVectors.logo,
                      height: 50,
                    ),

                    const SizedBox(height: 40),

                    // ================= TITLE =================
                    const Text(
                      "Enjoy Listening to Music",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // ================= DESCRIPTION =================
                    const Text(
                      "Spotify is the best way to listen to awesome music anytime, anywhere.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // ================= ACTION BUTTONS =================
                    Row(
                      children: [
                        Expanded(
                          child: ScaleTransition(
                            scale: _scaleAnim,
                            child: BasicAppButton(
                              title: "Register",
                              onPressed: _isNavigating
                                  ? null
                                  : () {
                                      _navigate(const SignUp());
                                    },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextButton(
                            onPressed: _isNavigating
                                ? null
                                : () {
                                    _navigate(const SignIn());
                                  },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
