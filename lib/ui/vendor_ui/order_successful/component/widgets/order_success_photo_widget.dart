import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderSuccessfulPhotoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 265,
      height: 235,
      child: SvgPicture.asset('assets/images/order_success.svg',
          width: double.infinity, height: 400),
    );
  }
}
