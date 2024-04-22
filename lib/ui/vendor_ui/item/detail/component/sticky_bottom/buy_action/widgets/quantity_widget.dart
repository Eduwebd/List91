import 'package:flutter/material.dart';
import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({Key? key, this.icon, this.color}) : super(key: key);
  final IconData? icon;
  final Color? color;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: PsDimens.space40,
      width: PsDimens.space40,
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      child: Icon(
        widget.icon,
        color: PsColors.achromatic50,
      ),
    );
  }
}
