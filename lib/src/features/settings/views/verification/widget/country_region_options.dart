import 'package:country_list/country_list.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsCountryRegions extends StatefulWidget {
  final VoidCallback? onTap;
  const VWidgetsCountryRegions({required this.onTap, Key? key})
      : super(key: key);

  @override
  State<VWidgetsCountryRegions> createState() => _VWidgetsCountryRegionsState();
}

class _VWidgetsCountryRegionsState extends State<VWidgetsCountryRegions> {
  List<Country> defaultCountries = Countries.list;
  List<Country> filteredCountries = Countries.list;
  String typingText = "";
  TextEditingController typingTextController = TextEditingController();
  changeTypingState(String val) {
    typingText = val;

    List<Country>? iterable = [];

    if (typingText.isNotEmpty) {
      iterable = defaultCountries
          .where((element) =>
              element.name.toLowerCase().contains(typingText.toLowerCase()))
          .toList(growable: true);
      filteredCountries = iterable;
    } else {
      filteredCountries = defaultCountries;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "ID country or region",
        appBarHeight: 50,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            VWidgetsPrimaryTextFieldWithTitle(
              hintText: "Search country here",
              onChanged: (val) {
                changeTypingState(val);
              },
              controller: typingTextController,
              //!Switching photo functionality with map search till photo search is ready

              // suffixIcon: IconButton(
              //   onPressed: () {},
              //   padding: const EdgeInsets.only(right: 0),
              //   icon: const RenderSvgWithoutColor(
              //     svgPath: VIcons.searchNormal,
              //     svgHeight: 24,
              //     svgWidth: 24,
              //   ),
              // ),
            ),
            addVerticalSpacing(30),
            Expanded(
              child: ListView.builder(
                itemCount: typingText.isEmpty
                    ? defaultCountries.length
                    : filteredCountries.length,
                itemBuilder: (_, index) {
                  Country country = filteredCountries[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          country.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Divider(
                        height: 3.h,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
