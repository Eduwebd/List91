import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class SameAsShippingAddressWidget extends StatelessWidget {
  const SameAsShippingAddressWidget({Key? key, this.onChanged,})
      : super(key: key);
 final Function(bool?)?  onChanged;
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderIdProvider>(
      builder: (BuildContext context, OrderIdProvider provider, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(left: PsDimens.space1),
          child: Row(
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
                  value:true,
                  //  provider.isSameAsShippingAddress,
                  onChanged:onChanged
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                       
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: PsDimens.space4),
                    height: PsDimens.space24,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        // 'Same as shipping address',
                        'billing_address_same_shipping'.tr,
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
          ),
        );
      },
    );
  }
}
