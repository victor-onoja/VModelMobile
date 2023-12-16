import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/features/create_contract/views/preview_contract.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/typography/textstyle.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/date_picker/v_picker.dart';
import 'package:vmodel/src/shared/text_fields/counting_textfield.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field_with_logos.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/res/res.dart';

class CreateContractView extends StatefulWidget {
  const CreateContractView({super.key});

  @override
  State<CreateContractView> createState() => _CreateContractViewState();
}

class _CreateContractViewState extends State<CreateContractView> {
  int offeredPrice = 350;
  String dropdownTypeValue = 'Hybrid';
  String dropdownPaymentValue = 'Monthly';
  TextEditingController dateTime = TextEditingController();

  LogoDropDownObject? val = LogoDropDownObject(
    logo: SvgPicture.asset(
      VIcons.paypal,
      width: 30,
      height: 20,
    ),
    logoValue: "Paypal",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon:  VWidgetsBackButton(),
        
        backgroundColor: Colors.white,
       appbarTitle: "Create a Contract",
      ),

      body: SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(20),
              const VWidgetsPrimaryTextFieldWithTitle(
                label: "Name",
                hintText: "Ex. Jane Cooper",
              ),
              addVerticalSpacing(15),
              const VWidgetsPrimaryTextFieldWithTitle(
                label: "Compaign Name",
                hintText: "Ex. Vmagazine",
              ),
              addVerticalSpacing(15),

              VWidgetsPrimaryTextFieldWithTitle(
                label: "Contract length",
                minLines: 1,
                hintText: "Date",
                suffixIcon: const Icon(
                  Icons.calendar_month_rounded,
                  size: 24,
                ),
                controller: dateTime,
                onTap: () {
                  VWidgetsDatePickerUI.openVModelDateTimeDialog(
                      selection: (val) {
                        DateFormat date = DateFormat('dd/MM/yyyy');
                        setState(() {
                          dateTime.text = date.format(val).toString();
                        });
                      },
                      context: context);
                },

                //validator: ValidationsMixin.isNotEmpty(value),
                //keyboardType: TextInputType.emailAddress,
                //onSaved: (){},
              ),

              addVerticalSpacing(15),
              Text("Price offered", style: VmodelTypography2.kBoldTextStyle),
              addVerticalSpacing(15),
             VWidgetsCountingTextField(
              boxWidth: 60.w,
              hintText: offeredPrice.toString(), 
              onTapMinus: () {
                        setState(() {
                          if (offeredPrice >= 50) {
                            offeredPrice = offeredPrice - 50;
                          }
                        });
                      },
              onTapPlus:  () {
                        setState(() {
                          offeredPrice = offeredPrice + 50;
                        });
                      }, 
              ),

             
              addVerticalSpacing(15),
              VWidgetsDropDownTextField(
                fieldLabel: "Type",
                hintText: "",
                options: const ["On-site", "Hybrid", "Remote"],
                //getLabel: (String value) => value,
                value: dropdownTypeValue,
                onChanged: (val) {
                  setState(() {
                    dropdownTypeValue = val;
                  });
                },
              ),
              addVerticalSpacing(15),

              if (dropdownTypeValue != "Remote")
                Column(
                  children: [
                    const VWidgetsPrimaryTextFieldWithTitle(
                      label: "Address",
                      hintText: "Ex. 12 Mayfield Rd",
                    ),
                    addVerticalSpacing(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: VWidgetsPrimaryTextFieldWithTitle(
                            label: "Postal Code",
                            hintText: "Ex. E13 8ES",
                          ),
                        ),
                        addHorizontalSpacing(10),
                        const Flexible(
                          child: VWidgetsPrimaryTextFieldWithTitle(
                            label: "City",
                            hintText: "Ex. London",
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpacing(15),
                  ],
                ),

              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                child: VWidgetsDropDownTextFieldWithLogos(
                  fieldLabel: "Payment method",
                  fieldLabelWidget: Text(
                    "Payment Method",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor.withOpacity(1),
                        ),
                  ),
                  hintText: "",
                  options: [
                    LogoDropDownObject(
                      logo: SvgPicture.asset(
                        VIcons.card,
                        width: 30,
                        height: 20,
                      ),
                      logoValue: "Personal ****3456",
                    ),
                    LogoDropDownObject(
                      logo: SvgPicture.asset(
                        VIcons.paypal,
                        width: 30,
                        height: 20,
                      ),
                      logoValue: "Paypal",
                    ),
                    LogoDropDownObject(
                      logo: const Text(""),
                      logoValue: "New payment card",
                    ),
                  ],
                  value: val!.logoValue,
                  onChanged: (value) {
                    setState(() {
                      val!.logoValue = value;
                    });
                  },
                ),
              ),
              addVerticalSpacing(15),

              VWidgetsDropDownTextField(
                fieldLabel: "Frequency of Payments",
                hintText: "",
                options: const ["Bi-Monthly", "Monthly", "Quaterly", "Upfront"],
                value: dropdownPaymentValue,
                onChanged: (val) {
                  setState(() {
                    dropdownPaymentValue = val;
                  });
                },

              ),
              addVerticalSpacing(15),
             
              addVerticalSpacing(15),
              VWidgetsPrimaryButton(
                onPressed: () { HapticFeedback.lightImpact();
                  navigateToRoute(context, const PreviewContractView());
                },
                buttonTitle: 'Continue',
                enableButton: true,
              ),
              addVerticalSpacing(40),
            ],
          ),
        ),
    );
  }
}
