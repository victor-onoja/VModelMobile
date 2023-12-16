import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsServicesDetailsPageWidget extends StatelessWidget {
  final String? serviceName;
  final String? serviceDelivery;
  final String? serviceType;
  final String? serviceCharge;
  final String? serviceUsageLength;
  final String? serviceUsageType;
  final String? serviceDescription;

  const VWidgetsServicesDetailsPageWidget({
    super.key,
    required this.serviceName,
    required this.serviceType,
    required this.serviceCharge,
    required this.serviceDelivery,
    required this.serviceUsageLength,
    required this.serviceUsageType,
    required this.serviceDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const VWidgetsPagePadding.horizontalSymmetric(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpacing(20),
          Text(
            serviceName!,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VmodelColors.primaryColor,
                ),
          ),
          addVerticalSpacing(15),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery",
                    style: TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  addVerticalSpacing(5),
                  Text(
                    serviceDelivery!,
                    style: const TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpacing(18),
                  const Text(
                    "Usage Length",
                    style: TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  addVerticalSpacing(5),
                  Text(
                    serviceUsageLength!,
                    style: const TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              addHorizontalSpacing(50),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Per ${serviceType!.toString().capitalizeFirst}",
                    style: const TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  addVerticalSpacing(5),
                  Text(
                    "£$serviceCharge",
                    style: const TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpacing(18),
                  const Text(
                    "Usage Type",
                    style: TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  addVerticalSpacing(5),
                  Text(
                    serviceUsageType!,
                    style: const TextStyle(
                      color: Color.fromRGBO(80, 60, 59, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          addVerticalSpacing(40),
          const Text(
            "Full Description",
            style: TextStyle(
              color: Color.fromRGBO(80, 60, 59, 0.5),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          addVerticalSpacing(6),
          Text(
            serviceDescription!,
            style: const TextStyle(
              color: Color.fromRGBO(80, 60, 59, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
