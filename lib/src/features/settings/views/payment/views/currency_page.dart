import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  String dropDownCurrencyTypeValue = "£ British Pound (GBP)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Currency",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpacing(25),
              VWidgetsDropDownTextField(
                // fieldLabel: "Currency Type",
                hintText: "",
                options: const [
                  "£ British Pound (GBP)",
                  "\$ American Dollar (USD)",
                ],
                value: dropDownCurrencyTypeValue,
                onChanged: (val) {
                  dropDownCurrencyTypeValue = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
