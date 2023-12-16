import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/service_packages_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/views/new_add_services_homepage.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../../shared/empty_page/empty_page.dart';
import '../../../../../shared/popup_dialogs/confirmation_popup.dart';
import '../../../../dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';

class BookingPricesSettingsPage extends ConsumerStatefulWidget {
  const BookingPricesSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BookingPricesSettingsPageState();
}

class _BookingPricesSettingsPageState
    extends ConsumerState<BookingPricesSettingsPage> {
  final _textStyle = VModelTypography1.normalTextStyle
      .copyWith(fontWeight: FontWeight.w600, fontSize: 59.sp);

  @override
  Widget build(BuildContext context) {
    final myServices = ref.watch(servicePackagesProvider(null));

    // final notifierR = ref.watch(registerProvider.notifier);
    // VSettingsController controller = Get.find<VSettingsController>();

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Services",
        trailingIcon: [
          IconButton(
            onPressed: () {
              navigateToRoute(
                  context,
                  const AddNewServicesHomepage(
                    servicePackage: null,
                  ));
              //showPackageDialog(context);
            },
            splashRadius: 24,
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Iconsax.shop_add),
          ),
        ],
      ),
      body: myServices.when(data: (values) {
        // return value.fold((p0) => Text(p0.message), (p0) {
        if (values.isEmpty) {
          return const Center(
            child: EmptyPage(
              svgPath: VIcons.cameraIcon,
              svgSize: 50,
              subtitle: 'Create a new service!',
            ),
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            HapticFeedback.lightImpact();
            ref.refresh(servicePackagesProvider(null).future);
          },
          child: ListView.separated(
            shrinkWrap: true,
            // physics: ScrollPhysics(),
            padding: const VWidgetsPagePadding.all(18),
            itemCount: values.length,
            separatorBuilder: (context, index) {
              // if (index < value.length - 1) {
              //   return const Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //     child: Divider(
              //       thickness: 0.2,
              //       color: VmodelColors.vModelprimarySwatch,
              //       height: 4,
              //     ),
              //   );
              // } else {
              //   return const SizedBox
              //       .shrink(); // To remove the separator after the last item
              // }
              return const SizedBox.shrink();
            },
            itemBuilder: (context, index) {
              var item = values[index];

              return VWidgetsServicesCardWidget(
                serviceName: item.title,
                // Todo {service fix}
                // bannerUrl: item.bannerUrl,
                bannerUrl: null,
                discount: item.percentDiscount,
                serviceType: "Per ${item.servicePricing}",
                serviceCharge: item.price,
                serviceLocation: item.serviceType.simpleName,
                serviceDescription: item.description,
                date: item.createdAt.getSimpleDate(),
                onTap: () {
                  navigateToRoute(
                      context, AddNewServicesHomepage(servicePackage: item));
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => VWidgetsConfirmationPopUp(
                      popupTitle: "Delete",
                      popupDescription:
                          "Are you sure you want to delete the service",
                      onPressedYes: () async {
                        goBack(context);
                        VLoader.changeLoadingState(true);
                        await ref
                            .read(servicePackagesProvider(null).notifier)
                            .deleteService(item.id);
                        VLoader.changeLoadingState(false);
                        // if(context.mounted) {
                        //   goBack(context);
                        // }
                      },
                      onPressedNo: () {
                        goBack(context);
                      },
                    ),
                  );
                },
              );
            },
          ),
          // );
          // }
        );
      }, error: (err, stackTrace) {
        return Text('There was an error showing albums $err');
      }, loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    );
  }

  // void showPackageDialog(BuildContext context,
  //     {ServicePackageModel? servicePackage}) {
  //   showDialog(
  //     context: context,
  //     builder: ((context) {
  //       return NewServicePackageDialog(package: servicePackage);
  //     }),
  //   );
  // }
}
