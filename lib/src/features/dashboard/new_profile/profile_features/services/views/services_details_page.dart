// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/services_details_page_widget.dart';
// import 'package:vmodel/src/res/assets/app_asset.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';
// import 'package:vmodel/src/shared/buttons/primary_button.dart';
// import 'package:vmodel/src/vmodel.dart';

// class ServicesDetailsPageOld extends StatefulWidget {
//   var serviceName;

//   var serviceType;

//   var serviceCharge;

//   var serviceDelivery;

//   var serviceUsageType;

//   var serviceUsageLength;

//   var serviceDescription;

//   ServicesDetailsPageOld(
//       {super.key,
//       required this.serviceName,
//       required this.serviceType,
//       required this.serviceCharge,
//       required this.serviceDelivery,
//       required this.serviceUsageLength,
//       required this.serviceUsageType,
//       required this.serviceDescription});

//   @override
//   State<ServicesDetailsPageOld> createState() => _ServicesDetailsPageOldState();
// }

// class _ServicesDetailsPageOldState extends State<ServicesDetailsPageOld> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: VWidgetsAppBar(
//         leadingIcon: const VWidgetsBackButton(),
//         appbarTitle: "Services offered",
//         trailingIcon: [
//           IconButton(onPressed: () {}, icon: listSortingIcon),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: VWidgetsServicesDetailsPageWidget(
//                 serviceName: widget.serviceName,
//                 serviceType: widget.serviceType,
//                 serviceCharge: widget.serviceCharge.toString(),
//                 serviceDelivery: widget.serviceDelivery.toString(),
//                 serviceUsageLength: widget.serviceUsageLength,
//                 serviceUsageType: widget.serviceUsageType,
//                 serviceDescription: widget.serviceDescription),
//           ),
//           addVerticalSpacing(6),
//           Padding(
//             padding: const VWidgetsPagePadding.horizontalSymmetric(18),
//             child: VWidgetsPrimaryButton(
//               onPressed: () {},
//               enableButton: true,
//               buttonTitle: "Book Now",
//             ),
//           ),
//           addVerticalSpacing(40),
//         ],
//       ),
//     );
//   }
// }
