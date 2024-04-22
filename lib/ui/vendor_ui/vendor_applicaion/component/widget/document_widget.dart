import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';

class DocumentWidget extends StatefulWidget {
  const DocumentWidget(
      {Key? key,
      required this.isStar,
      required this.documentController,
      required this.flag,
      required this.vendorUser})
      : super(key: key);

  final bool isStar;
  final TextEditingController documentController;
  final VendorUser vendorUser;
  final String? flag;

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  List<PlatformFile>? documentPath;

  @override
  Widget build(BuildContext context) {

    String? text = '';
    final VendorUserProvider provider =
        Provider.of<VendorUserProvider>(context, listen: false);


    if (widget.flag == PsConst.EDIT_ITEM) {
      text = widget.documentController.text;
    } else if (documentPath == null) {
      text = 'venodr_document_drop_file'.tr;
    } else {
      text = widget.documentController.text;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(
              left:(Directionality.of(context) == TextDirection.rtl)?0:PsDimens.space16 ,
              right:(Directionality.of(context) == TextDirection.rtl)?PsDimens.space16:0 ,
               bottom: PsDimens.space10),
          child: Row(
            children: <Widget>[
              Text('vendor_business_document'.tr,
                  style: Theme.of(context).textTheme.titleMedium!),
              if (widget.isStar)
                Text('*',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor))
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            try {
              documentPath = (await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowMultiple: false,
                      allowedExtensions: <String>['pdf']))
                  ?.files;
            } on PlatformException catch (e) {
              print('Unsupported operation' + e.toString());
            } catch (ex) {
              print(ex);
            }
            if (documentPath != null) {
              setState(() {
                provider.documentPath = documentPath![0].path;
                widget.documentController.text = documentPath![0].name;
                print(documentPath![0].path);
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.only(
                left: PsDimens.space16, right: PsDimens.space16),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(PsDimens.space4),
              color: PsColors.achromatic500,
              child: Row(
                children: <Widget>[
                  Container(
                    height: PsDimens.space44,
                    margin: const EdgeInsets.only(
                      top: PsDimens.space4,
                      bottom: PsDimens.space4,
                      left: PsDimens.space4,
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PsColors.achromatic500,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.only(
                        left: PsDimens.space14, right: PsDimens.space14),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_upward,
                          color: PsColors.accent800,
                        ),
                        const SizedBox(
                          width: PsDimens.space12,
                        ),
                        Text(
                          'vendor_document_upload_file'.tr,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800
                                      : PsColors.text50,
                                  fontWeight:
                                      FontWeight.normal //PsColors.achromatic50
                                  ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text500
                            : PsColors.text50,
                        fontWeight: FontWeight.normal //PsColors.achromatic50
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // if (widget.vendorUser.isRejectedVendor && documentPath == null)
        //   Padding(
        //     padding: const EdgeInsets.only(
        //         left: PsDimens.space16,
        //         bottom: PsDimens.space4,
        //         top: PsDimens.space10),
        //     child: Row(
        //       children: <Widget>[
        //         Text('Please upload a valid business document.'.tr,
        //             style: Theme.of(context)
        //                 .textTheme
        //                 .bodySmall!
        //                 .copyWith(color: PsColors.error500)),
        //       ],
        //     ),
        //   ),
      ],
    );
  }
}
