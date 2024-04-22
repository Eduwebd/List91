import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/vendor_search_parameter_holder.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_button_widget.dart';

class LatestVendorFilterView extends StatefulWidget {
  const LatestVendorFilterView({Key? key}) : super(key: key);

  @override
  State<LatestVendorFilterView> createState() => _LatestVendorFilterViewState();
}

List<String> viewBy = <String>['Relevance', 'Top Engaged', 'Latest Joined'];

String selectedValue = 'Relevance';
String selectedRadioValue = 'High';
late PsValueHolder psValueHolder ;
VendorSearchParameterHolder vendorSearchParameterHolder =
    VendorSearchParameterHolder();

class _LatestVendorFilterViewState extends State<LatestVendorFilterView> {
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    return Scaffold(
      appBar: PsAppbarWidget(
        appBarTitle: 'search__filter'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: PsDimens.space20, horizontal: PsDimens.space10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'View By',
                style: TextStyle(fontSize: 18),
              ),

              //// Drop Down Container
              Container(
                margin: const EdgeInsets.only(
                    top: PsDimens.space10, bottom: PsDimens.space20),
                decoration: BoxDecoration(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic50
                      : PsColors.achromatic800,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.5), // You can customize the shadow color
                      spreadRadius: 0.8,
                      blurRadius: 3, // changes the position of the shadow
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedValue,
                  elevation: 8,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: viewBy.map((String text) {
                    return DropdownMenuItem<String>(
                      value: text,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PsDimens.space14),
                        child: Text(
                          text,
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (mounted) {
                      setState(() {
                        selectedValue = newValue ?? 'Relevance';
                      });
                    }
                  },
                ),
              ),

              const Text(
                'Listings',
                style: TextStyle(fontSize: 18),
              ),

              //// Radio (High & Low)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /// High Radio
                  Row(
                    children: <Widget>[
                      // ignore: always_specify_types
                      Radio(
                        activeColor: PsColors.primary500,
                        value: 'High',
                        groupValue: selectedRadioValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRadioValue = value.toString();
                          });
                        },
                      ),
                      const Text('High',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),

                  /// Low Radio
                  Row(
                    children: <Widget>[
                      // ignore: always_specify_types
                      Radio(
                        activeColor: PsColors.primary500,
                        value: 'Low',
                        groupValue: selectedRadioValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRadioValue = value.toString();
                          });
                        },
                      ),
                      const Text('Low',
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ],
                  ),
                  const SizedBox()
                ],
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PsDimens.space6),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.8,
                                blurRadius: 2)
                          ]),
                      child: PSButtonWidget(
                        colorData: Utils.isLightMode(context)
                            ? PsColors.achromatic50
                            : PsColors.achromatic800,
                        textColorData: Utils.isLightMode(context)
                            ? PsColors.achromatic800
                            : PsColors.achromatic50,
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              selectedValue = 'Relevance';
                              selectedRadioValue = 'High';
                            });
                          }
                        },
                        titleText: 'Rest'.tr,
                      ),
                    ),
                  ),
                  const SizedBox(width: PsDimens.space10),
                  Expanded(
                    child: PSButtonWidget(
                      onPressed: () {
                        // vendorSearchParameterHolder.searchterm = '';
                        // vendorSearchParameterHolder.ownerUserId =
                        //     psValueHolder.loginUserId;
                        // vendorSearchParameterHolder.orderBy =
                        //     PsConst.FILTERING__NAME;
                        // vendorSearchParameterHolder.orderType =
                        //     PsConst.FILTERING__DESC;
                        // vendorSearchParameterHolder.status = PsConst.TWO;
                        // vendorSearchParameterHolder.productRelation =
                        //     <VendorProductRelation>[];

                        Navigator.pop(context);
                      },
                      titleText: 'blue_mark_apply'.tr,
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
