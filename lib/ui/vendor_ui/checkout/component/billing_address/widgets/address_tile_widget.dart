import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class AddressTileWidget extends StatelessWidget {
  const AddressTileWidget(
      {Key? key, this.titleAddress, this.subtitleAddress, this.onTap})
      : super(key: key);
  final String? titleAddress;
  final String? subtitleAddress;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        subtitle: Text(subtitleAddress ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: PsColors.text400)),
        title: Text(
          titleAddress ?? '',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 100,
            width: 40,
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Utils.isLightMode(context)
                  ? PsColors.text800
                  : PsColors.achromatic200,
            )));
  }
}
