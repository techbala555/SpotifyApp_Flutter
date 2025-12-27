import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_images.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/core/config/theme/app_colors.dart';
import 'package:spotify_app/presentation/auth/pages/signup_or_siginin.dart';
import 'package:spotify_app/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 600; 

    return Scaffold(
      body: Stack(
        children: [
          // ================= BACKGROUND IMAGE =================
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(AppImages.choosemodebg),
              ),
            ),
          ),

          // ================= DARK OVERLAY =================
          Container(color: Colors.black.withOpacity(0.25)),

          // ================= CONTENT =================
          SafeArea(
            child: Center(
              child: Container(
                width: isWideScreen ? 500 : double.infinity, // responsive width
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 40 : 30,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ================= LOGO =================
                    SvgPicture.asset(
                      AppVectors.logo,
                      height: 40,
                    ),

                    const Spacer(),

                    // ================= TITLE =================
                    const Text(
                      "Choose Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= MODE OPTIONS =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _modeItem(
                          context,
                          icon: AppVectors.sun,
                          label: "Light Mode",
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.light);
                          },
                        ),
                        const SizedBox(width: 40),
                        _modeItem(
                          context,
                          icon: AppVectors.moon,
                          label: "Dark Mode",
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.dark);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 80),

                    // ================= CONTINUE BUTTON =================
                    BasicAppButton(
                      title: "Continue",
                      height: 70,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupOrSiginin(),
                          ),
                        );
                      },
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

  // ================= MODE ITEM =================

  Widget _modeItem(
    BuildContext context, {
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xff30393c).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  icon,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
