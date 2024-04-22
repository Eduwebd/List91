import 'package:flutter/material.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../custom_ui/user/blocked_user/component/blocked_user_list_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class BlockUserContainerView extends StatefulWidget {
  @override
  _BlockUserContainerViewState createState() => _BlockUserContainerViewState();
}

class _BlockUserContainerViewState extends State<BlockUserContainerView>
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
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
        appBar: PsAppbarWidget(appBarTitle: 'more__block_user_title'.tr),
        body: CustomBlockedUserListView(
          animationController: animationController,
        ),
      ),
    );
  }
}
