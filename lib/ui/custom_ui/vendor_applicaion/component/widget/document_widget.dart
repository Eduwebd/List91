import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../vendor_ui/vendor_applicaion/component/widget/document_widget.dart';

class CustomDocumentWidget extends StatefulWidget {
  const CustomDocumentWidget(
      {Key? key,
      required this.isStar,
      required this.documentController,
      required this.flag,
      required this.vendorUser})
      : super(key: key);
  final bool isStar;
  final TextEditingController documentController;
  final String? flag;
  final VendorUser vendorUser;
  @override
  State<CustomDocumentWidget> createState() => _CustomDocumentWidgetState();
}

class _CustomDocumentWidgetState extends State<CustomDocumentWidget> {
  @override
  Widget build(BuildContext context) {
    return DocumentWidget(
      isStar: widget.isStar, documentController: widget.documentController,
      flag: widget.flag,
      vendorUser: widget.vendorUser,
    );
  }
}
