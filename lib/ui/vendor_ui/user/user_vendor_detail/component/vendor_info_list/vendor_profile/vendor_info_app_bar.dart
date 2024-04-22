import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';



class UserVendorInfoListViewAppBar extends StatefulWidget {
  const UserVendorInfoListViewAppBar({
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    required this.items,
    required this.onItemSelected,
  });
  // : assert(items.length >= 2 && items.length <= 5);

  @override
  _UserVendorInfoListViewAppBarState createState() {
    return _UserVendorInfoListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<UserVendorInfoListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
}

class _UserVendorInfoListViewAppBarState
    extends State<UserVendorInfoListViewAppBar> {
  _UserVendorInfoListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<UserVendorInfoListViewAppBarItem> items;
  int? selectedIndexNo;

  ValueChanged<int> onItemSelected;

  Widget _buildItem(UserVendorInfoListViewAppBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width / 3,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.title + '  ',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: PsColors.text800,
                    //isSelected ? item.mainColor ?? (Theme.of(context).primaryColor) : Utils.isLightMode(context) ? PsColors.text500: PsColors.text50,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(
            height: PsDimens.space16,
          ),
          if (isSelected)
            Divider(
              color: Theme.of(context).primaryColor,
              height: 1,
              thickness: 1.5,
            )
          else
            Divider(
              height: PsDimens.space1,
              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50,
              thickness: 0.2,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedIndexNo = widget.selectedIndex;
    return Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space16,
        ),
        width: double.infinity,
        height: 52,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount:1,
            itemBuilder: (BuildContext context, int index) {
              final UserVendorInfoListViewAppBarItem item = items[index];
              return InkWell(
                onTap: () {
                  onItemSelected(index);
                  setState(() {
                    selectedIndexNo = index;
                  });
                },
                child: _buildItem(item, selectedIndexNo == index),
              );
            }));
  }
}

class UserVendorInfoListViewAppBarItem {
  UserVendorInfoListViewAppBarItem(
      {required this.title,
      this.mainColor,
      Color? activeBackgroundColor,
      this.inmainColor,
      Color? inactiveBackgroundColor})
      : activeBackgroundColor = activeBackgroundColor ?? PsColors.primary50,
        inactiveBackgroundColor =
            inactiveBackgroundColor ?? PsColors.achromatic500.withOpacity(0.2);

  final String title;
  final Color? mainColor;
  final Color? activeBackgroundColor;
  final Color? inmainColor;
  final Color inactiveBackgroundColor;
}
