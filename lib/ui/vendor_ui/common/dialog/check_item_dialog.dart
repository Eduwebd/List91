import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class CheckOutDialog extends StatefulWidget {
  const CheckOutDialog({this.message, this.title});
  final String? message;
  final String? title;
  @override
  _CheckOutDialogState createState() => _CheckOutDialogState();
}

class _CheckOutDialogState extends State<CheckOutDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CheckOutDialog widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: Text(
        widget.title!,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Utils.isLightMode(context)
                ? PsColors.text800
                : PsColors.achromatic50,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      content: Text(
        widget.message!,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14,
              color: PsColors.text700,
              fontWeight: FontWeight.w400,
            ),
      ),
      actions: <Widget>[
        PSButtonWidgetRoundCorner(
            colorData: Theme.of(context).primaryColor,
            hasShadow: false,
            // width: 51,
            // height: 36,
            titleText: 'dialog__ok'.tr,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
      // child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      // Text(
      //   'Sold Out'.tr,
      //   textAlign: TextAlign.start,
      //   style: TextStyle(
      //       color: Utils.isLightMode(context)
      //           ? PsColors.text800
      //           : PsColors.achromatic50,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600),
      // ),
      //         // _headerWidget,
      //         Container(
      //           padding: const EdgeInsets.only(
      //               top: PsDimens.space16, bottom: PsDimens.space24),
      // child: Text(
      //   widget.message!,
      //   maxLines: 4,
      //   overflow: TextOverflow.ellipsis,
      //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
      //         fontSize: 14,
      //         color: PsColors.text700,
      //         fontWeight: FontWeight.w400,
      //       ),
      //           ),
      //         ),
      // PSButtonWidgetRoundCorner(
      //     colorData: Theme.of(context).primaryColor,
      //     hasShadow: false,
      //     width: 51,
      //     height: 36,
      //     titleText: 'dialog__ok'.tr,
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     }),
      //       ],
      //     ))
    );
  }
}
