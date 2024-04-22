import 'package:flutter/material.dart';

import '../../../../config/ps_config.dart';
import '../component/activity_log_view.dart';

class ActivityLogContainerView extends StatefulWidget {
  @override
  _ActivityLogContainerViewState createState() =>
      _ActivityLogContainerViewState();
}

class _ActivityLogContainerViewState extends State<ActivityLogContainerView>
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
      child: ActivityLogView(
          animationController: animationController, scaffoldKey: scaffoldKey),
    );
  }
}
