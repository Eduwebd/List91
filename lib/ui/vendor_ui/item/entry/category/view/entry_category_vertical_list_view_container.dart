import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../common/ps_app_bar_widget.dart';
import '../component/entry_category_vertical_list_view.dart';

class EntryCategoryVerticalListViewContainer extends StatefulWidget {
  const EntryCategoryVerticalListViewContainer({
    this.isFromChat});
  final bool? isFromChat;

  @override
  _EntryCategoryVerticalListView createState() {
    return _EntryCategoryVerticalListView();
  }
}

class _EntryCategoryVerticalListView
    extends State<EntryCategoryVerticalListViewContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;  
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;
  final ScrollController scrollController = ScrollController();

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && psValueHolder!.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

   @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);

    if (!isConnectedToInternet && psValueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
     return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        if (!mounted) {
          return Future<void>.value(false);
        }
        Navigator.pop(context);
        return Future<void>.value(true);
      },
      child: Scaffold(
        appBar: const PsAppbarWidget(
          appBarTitle: '',
        ),
        body: Column(
          children: <Widget>[
            EntryCategoryVerticalListView(
              animationController: animationController!,
              isFromChat: widget.isFromChat),
          ],
        )),         
    );
  }
}
