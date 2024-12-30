import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularContainer extends StatelessWidget {
  CircularContainer({
    Key? key,
    required this.height,
    required this.width,
    this.color,
    this.child,
    this.imgUrl,
  }) : super(key: key);
  final double height;
  final double width;
  Color? color;
  String? imgUrl;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl.toString(),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: child,
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
