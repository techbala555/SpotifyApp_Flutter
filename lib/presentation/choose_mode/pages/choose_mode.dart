import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/config/assets/app_images.dart';
import 'package:spotify_app/core/config/assets/app_vectors.dart';
import 'package:spotify_app/core/config/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.choosemodebg),
              ),
            ),
          ),

          Container(color: Colors.black.withOpacity(0.15)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                Spacer(),
                Text(
                  "Choose Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xff30393c).withOpacity(0.5),
                            shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(AppVectors.sun,
                          fit: BoxFit.none,),
                        ),
                      ),
                    ),
                    SizedBox(width: 40,),
                     Container(
                      height: 80,
                      width: 80,
                     decoration: BoxDecoration(
                        color: Color(0xff30393c).withOpacity(0.5),
                        shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(AppVectors.moon,
                          fit: BoxFit.none,),
                    ),
                  ],
                ),
               
                SizedBox(height: 80),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ChooseModePage(),
                      ),
                    );
                  },
                  title: "Continue",
                  height: 60,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),

    );
  }
}