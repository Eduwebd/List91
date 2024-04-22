import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/repository/customize_ui_detail_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/product/customize_ui_detail_provider.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class RadioButtonListWidget extends StatefulWidget {
  const RadioButtonListWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<RadioButtonListWidget> createState() => _RadioButtonListWidgetState();
}

class _RadioButtonListWidgetState extends State<RadioButtonListWidget> {
  // String? _selectedValue = '-1';
  late MapEntry<CustomField, SelectedObject> element;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedValue = element.value.idTextController.text;
  // }

  // ignore: always_declare_return_types
  // _updateRadioButton(String? value) {
  //   setState(() {
  //     element.value.valueTextController.text = value!;
  //     element.value.idTextController.text = value!;
  //   });
  // }

  List<Widget> radioButtons(List<CustomizeUiDetail>? dataList) {
    if (dataList != null) {
      return dataList
          .map(
            (CustomizeUiDetail customizeUiDetail) => RadioItem(
                currentValue: element.value.idTextController.text.isEmpty
                    ? '-1'
                    : element.value.idTextController.text,
                title: customizeUiDetail.name ?? '',
                value: customizeUiDetail.id.toString(),
                onUpdate: (String? value) {
                  setState(() {
                    print(value);
                    element.value.valueTextController.text = customizeUiDetail.name!;
                    element.value.idTextController.text = customizeUiDetail.id!;
                   
                  });
                }),
          )
          .toList();
    } else {
      return <Widget>[];
    }
  }

  CustomizeUiDetailProvider? customizeUiDetailProvider;
  @override
  Widget build(BuildContext context) {
    final CustomizeUiDetailRepository repo =
        Provider.of<CustomizeUiDetailRepository>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    element = itemEntryFieldProvider.textControllerMap.entries.firstWhere(
        (MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);
    print(element.key.coreKeyId);
    
    return ChangeNotifierProvider<CustomizeUiDetailProvider?>(
      lazy: false,
      create: (BuildContext context) {
        customizeUiDetailProvider = CustomizeUiDetailProvider(repo: repo);
        customizeUiDetailProvider!.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                languageCode: langProvider.currentLocale.languageCode,
                coreKeyId: widget.customField.coreKeyId));
        return customizeUiDetailProvider;
      },
      child: Consumer<CustomizeUiDetailProvider>(
        builder: (BuildContext context, CustomizeUiDetailProvider provider,
            Widget? child) {
          final List<CustomizeUiDetail>? dataList = provider.dataList.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(widget.customField.name!.tr,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              if (provider.hasData)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: PsDimens.space8,
                    ),
                    ...radioButtons(dataList),
                    const SizedBox(
                      width: PsDimens.space8,
                    ),
                  ],
                )
              else
                const SizedBox()
            ],
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  const RadioItem({
    Key? key,
    required this.currentValue,
    required this.title,
    required this.value,
    required this.onUpdate,
  }) : super(key: key);
  final String title;
  final String currentValue;
  final String value;
  final Function(String? value) onUpdate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Radio<String?>(
            value: value,
            groupValue: currentValue,
            onChanged: onUpdate,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
