import 'package:flutter/material.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import '../../../../core/vendor/viewobject/blog.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../sort_widget/ps_dynamic_option.dart';

class BlogView extends StatefulWidget {
  const BlogView({Key? key, required this.blog, required this.heroTagImage})
      : super(key: key);

  final Blog blog;
  final String? heroTagImage;

  @override
  BlogViewState<BlogView> createState() => BlogViewState<BlogView>();
}

class BlogViewState<T extends BlogView> extends State<BlogView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final WidgetProviderDynamic widgetProviderDynamic =
        Utils.psWidgetToProvider(PsConfig.blogDetailsWidgetList);
    return Scaffold(
      appBar: const PsAppbarWidget(appBarTitle: 'Blog Details'),
      body: PSDynamicOptionWidget(
        animationController: animationController,
        scrollController: _scrollController,
        widgetList: widgetProviderDynamic,
        blog: widget.blog,
        heroTagImage: widget.heroTagImage,
      ),
    );
  }
}
