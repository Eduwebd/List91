// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../config/ps_colors.dart';
// import '../../../../../../core/vendor/utils/utils.dart';

// import '../../../../../../../core/vendor/constant/ps_dimens.dart';
// import '../../../../../../../core/vendor/provider/product/added_item_provider.dart';
// import '../../../../../../../core/vendor/provider/user/user_provider.dart';

// class VendorItemAndFollowerCount extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//     final AddedItemProvider addedItemProvider =
//         Provider.of<AddedItemProvider>(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         const Icon(
//           Icons.inventory_2,
//           size: 20,
//         ),
//         Text(addedItemProvider.itemList.data!.length.toString(),
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Utils.isLightMode(context)
//                     ? PsColors.primary500
//                     : PsColors.text400,
//                 fontSize: 16)),
//         Text('Products ',
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Utils.isLightMode(context)
//                     ? PsColors.text500
//                     : PsColors.text400,
//                 fontSize: 16)),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: PsDimens.space10),
//           child: Container(
//             height: PsDimens.space32,
//             child: VerticalDivider(
//               color: PsColors.text300,
//               thickness: 1,
//             ),
//           ),
//         ),
//         const Icon(
//           Icons.person,
//           size: 20,
//         ),
//         Text(userProvider.user.data!.followerCount!,
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Utils.isLightMode(context)
//                     ? PsColors.primary500
//                     : PsColors.text400,
//                 fontSize: 16)),
//         Text('Followers ',
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Utils.isLightMode(context)
//                     ? PsColors.text500
//                     : PsColors.text400,
//                 fontSize: 16)),
//       ],
//       //)
//       // ),
//     );
//   }
// }
