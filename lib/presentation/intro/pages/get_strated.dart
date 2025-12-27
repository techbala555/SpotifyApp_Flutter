import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_images.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/core/config/theme/app_colors.dart';
import 'package:spotify_app/presentation/choose_mode/pages/choose_mode.dart';

class GetStratedPage extends StatefulWidget {
  const GetStratedPage({super.key});

  @override
  State<GetStratedPage> createState() => _GetStratedPageState();
}

class _GetStratedPageState extends State<GetStratedPage>
    with SingleTickerProviderStateMixin {
  bool _isNavigating = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onGetStarted() async {
    if (_isNavigating) return; 
    setState(() => _isNavigating = true);

    await _controller.forward();
    await _controller.reverse();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChooseModePage()),
    ).then((_) {
      if (mounted) setState(() => _isNavigating = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 900;

    return Scaffold(
      body: Stack(
        children: [
          // ================= BLURRED BACKGROUND (FILL) =================
          Positioned.fill(
            child: Image.asset(
              AppImages.introBg,
              fit: BoxFit.cover,
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          // ================= ACTUAL IMAGE =================
          Center(
            child: Image.asset(
              AppImages.introBg,
              fit: BoxFit.contain,
              width: isWideScreen ? size.width * 0.55 : size.width,
            ),
          ),

          // ================= CONTENT =================
          SafeArea(
            child: Center(
              child: Container(
                width: isWideScreen ? 520 : double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 50 : 30,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    // ================= LOGO =================
                    SvgPicture.asset(
                      AppVectors.logo,
                      height: 40,
                    ),

                    const Spacer(),

                    // ================= TITLE =================
                    const Text(
                      "Enjoy Listening Music",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= DESCRIPTION =================
                    const Text(
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= BUTTON =================
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: BasicAppButton(
                        title: "Get Started",
                        height: 70,
                        onPressed: _isNavigating ? null : _onGetStarted,
                      ),
                    ),

                    const SizedBox(height: 20),
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
