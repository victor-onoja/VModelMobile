import 'package:vmodel/src/features/vmagazine/views/vMagzine_page_view.dart';
// import 'package:vmodel/src/features/vmagazine/views/vmagzine_page_view.dart';
import 'package:vmodel/src/features/vmagazine/widgets/vMagazine_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VMagazineBody extends StatelessWidget {
  final bool? check;
  const VMagazineBody({super.key, this.check});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1.0,
                  color: check == false
                      ? const Color(0xffDEDEDE)
                      : VmodelColors.white,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_outlined,
                      color: check == false
                          ? VmodelColors.blackColor
                          : VmodelColors.white),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: VModelTypography1.primaryfontName,
                      color: check == false
                          ? VmodelColors.text
                          : VmodelColors.white),
                  hintText: "Search Vell Magazine...",
                  constraints: const BoxConstraints(maxHeight: 40),
                  contentPadding: const EdgeInsets.only(top: 11, left: 15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently Viewed',
                  style: TextStyle(
                    fontSize: 17,
                    color:
                        check == false ? const Color(0xFF523938) : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Avenir',
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                  color:
                      check == false ? const Color(0xFF523938) : Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 230,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addHorizontalSpacing(10),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/v_mag_1.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/v_mag_2.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/v_mag_1.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New & Trending',
                  style: TextStyle(
                    fontSize: 17,
                    color:
                        check == false ? const Color(0xFF523938) : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Avenir',
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                  color:
                      check == false ? const Color(0xFF523938) : Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 230,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addHorizontalSpacing(10),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/v_mag_new2.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/v_mag_news.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/popular1.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 17,
                    color:
                        check == false ? const Color(0xFF523938) : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Avenir',
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                  color:
                      check == false ? const Color(0xFF523938) : Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 230,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addHorizontalSpacing(10),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/popular2.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/popular1.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                  VWidgetsMagazineCoverCard(
                      image: 'assets/images/trendMagazines/popular2.png',
                      onTap: () {
                        navigateToRoute(
                            context, const VWidgetsMagazinePageView());
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
