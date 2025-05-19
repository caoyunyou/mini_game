import 'package:flutter/material.dart';

class MuyuAssetsImage extends StatelessWidget{
  final String image;
  // final VoidCallback onTap;
  final VoidCallback onTap;
  final double height;

  const MuyuAssetsImage({super.key,required this.image,required this.onTap, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          image,
          height: height,//图片高度
        ),
      )
    );
  }

}