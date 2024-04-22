import 'package:flutter/material.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';

import '../../../custom_ui/vendor_applicaion/component/vendor_application_form_view.dart';
import '../../common/ps_app_bar_widget.dart';

class VendorApplicationFormContainerView extends StatefulWidget {
    const VendorApplicationFormContainerView({Key? key, required this.flag, required this.vendorUser})
      : super(key: key);

  final String? flag;
   final VendorUser vendorUser; 
  @override
  _VendorApplicationFormContainerViewState createState() => _VendorApplicationFormContainerViewState();
}

class _VendorApplicationFormContainerViewState extends State<VendorApplicationFormContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop(){
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        _requestPop();
      },
      child: Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'vendor_application_title'.tr,
        ),
        body: CustomVendorApplicationFormView(
          animationController: animationController,
          flag: widget.flag,
          vendorUser: widget.vendorUser,
        ),
      ),
    );
  }
}
