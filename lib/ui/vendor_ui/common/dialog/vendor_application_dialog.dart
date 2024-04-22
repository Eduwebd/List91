import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../ps_button_widget_with_round_corner.dart';

class VendorApplicationDialog extends StatefulWidget {
  const VendorApplicationDialog(
      {this.message, this.title, this.onPressed, this.btnTitle,this.icon});
  final String? message, title, btnTitle;
  final Function? onPressed;
  final IconData? icon;

  @override
  _VendorApplicationDialogState createState() => _VendorApplicationDialogState();
}

class _VendorApplicationDialogState extends State<VendorApplicationDialog> {
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

  final VendorApplicationDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget _headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Icon(
                widget.icon,
                color: PsColors.primary500,
              ),
              const SizedBox(
                width: PsDimens.space12,
              ),
              Container(
                width: PsDimens.space160,
                child: Text(
                  widget.title ?? 'Success',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic800 : PsColors.achromatic50,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800 : PsColors.achromatic50,
            ))
      ],
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headerWidget,
              Container(
                padding: const EdgeInsets.only(
                    top: PsDimens.space16, bottom: PsDimens.space24),
                child: Text(
                  widget.message!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              PSButtonWidgetRoundCorner(
                  colorData: Theme.of(context).primaryColor,
                  hasShadow: false,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  titleText: widget.btnTitle!,
                  onPressed: () {
                    
                    widget.onPressed!();
                    //Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
