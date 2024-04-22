import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class OrderIdAndDateWidget extends StatelessWidget {
  const OrderIdAndDateWidget({Key? key, this.id, this.date}) : super(key: key);
  final String? date;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            date ?? '',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Utils.isLightMode(context)? PsColors.text800:PsColors.text50),
          ),
          Text(
            id ?? '',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:Utils.isLightMode(context)? PsColors.text800:PsColors.text50),
          )
        ],
      ),
    );
  }
}
