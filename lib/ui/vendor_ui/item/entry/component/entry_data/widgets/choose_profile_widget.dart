import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/vendor_list.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChooseProfileWidget extends StatelessWidget {
  const ChooseProfileWidget({Key? key, required this.flag}) : super(key: key);

  final String flag;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final ItemEntryFieldProvider provider =
        Provider.of<ItemEntryFieldProvider>(context);

    final List<VendorList>? profileList =
        provider.itemEntryField.data?.vendorList?.toList();

    profileList?.add(VendorList(
        id: PsConst.USER_PROFILE,
        name: userProvider.user.data?.name ?? '',
        currencyId: '',
        currencySymbol: '',
        logo: DefaultPhoto(imgPath: userProvider.user.data?.userCoverPhoto)));

    if (profileList != null) {
      return Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                top: PsDimens.space12,
                right: PsDimens.space16),
            child: Row(
              children: <Widget>[
                Text('choose_profile_to_upload'.tr,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(' *',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: PsDimens.space44,
            padding: const EdgeInsets.only(
                left: PsDimens.space12, right: PsDimens.space19),
            margin: const EdgeInsets.only(
                top: PsDimens.space12,
                left: PsDimens.space16,
                right: PsDimens.space16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space4),
              border: Border.all(color: PsColors.text400),
            ),
            child: Center(
              child: DropdownButton<String>(
                value: provider.selectedVendorId,
                hint: Text(
                  'choose_profile'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: PsColors.text400),
                ),
                elevation: 2,
                isExpanded: true,
                underline: const SizedBox(),
                icon: Icon(Icons.keyboard_arrow_down,
                    color: Utils.isLightMode(context)
                        ? PsColors.text700
                        : PsColors.achromatic400),
                items: profileList.map((VendorList vendor) {
                  return DropdownMenuItem<String>(
                    value: vendor.id,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 28,
                          height: 28,
                          child: PsNetworkCircleImageForUser(
                            photoKey: '',
                            imagePath: vendor.logo!.imgPath,
                            boxfit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: PsDimens.space8),
                        Text(
                          vendor.name!,
                          maxLines: 1,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: flag == PsConst.EDIT_ITEM
                    ? null
                    : (String? newValue) {
                        provider.changeSelectedVendorId(newValue ?? '');
                        if (provider.chooseThisProfile == true &&
                            newValue != null) {
                          provider.replaceVendorProfile(newValue);
                        }
                      },
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: PsColors.achromatic500,
                ),
                child: Checkbox(
                  checkColor: Utils.isLightMode(context)
                      ? PsColors.achromatic50
                      : PsColors.achromatic800,
                  activeColor: Theme.of(context).primaryColor,
                  value: provider.chooseThisProfile,
                  onChanged: (bool? value) {
                    provider.changeAlwaysChooseOption(value);
                    if (value! && provider.selectedVendorId != null)
                      provider.replaceVendorProfile(provider.selectedVendorId!);
                    else
                      provider.replaceVendorProfile(PsConst.NO_PROFILE);
                  },
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        'always_choose_profile'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
