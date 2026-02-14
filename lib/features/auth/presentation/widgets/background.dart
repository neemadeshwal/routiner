import 'package:flutter/material.dart';
import 'package:routiner/core/constants/assets_constants.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 350,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesAssets.authBg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
