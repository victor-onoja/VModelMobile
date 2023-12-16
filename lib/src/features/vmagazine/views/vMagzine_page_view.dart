

import 'package:vmodel/src/features/vmagazine/widgets/vMagzine_page.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsMagazinePageView extends StatefulWidget {

  const VWidgetsMagazinePageView({

    super.key});

  @override
  State<VWidgetsMagazinePageView> createState() => _VWidgetsMagazinePageViewState();
}

class _VWidgetsMagazinePageViewState extends State<VWidgetsMagazinePageView> {

 
 int _currentPage = 0;
 PageController pageController = PageController();

  final List<Widget> _pageList=<Widget>[
    const  VWidgetsVmagazinePage( 
    magazineText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id iaculis eros, ac hendrerit eros. Vestibulum egestas vitae mi sed rutrum. Phasellus et accumsan metus. Sed vitae ipsum at odio consectetur volutpat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque dictum ligula ligula, ut sollicitudin mauris ultrices ultrices. Maecenas magna risus, gravida eget orci ac, vestibulum rutrum risus. Cras ut mattis augue, at sagittis nisl. Praesent interdum odio vitae lacus finibus dignissim. Quisque fermentum ultrices dui, vel fringilla metus lobortis in. Fusce et tortor sed tortor auctor vestibulum. Aenean et odio sem. Vivamus laoreet luctus neque, non sagittis mi pellentesque a. Vivamus rutrum euismod turpis et congue. Integer id ipsum aliquet, placerat erat quis, vestibulum velit. Pellentesque condimentum velit justo, vitae porttitor lectus dignissim eget.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id iaculis eros, ac hendrerit eros. Vestibulum egestas vitae mi sed rutrum. Phasellus et accumsan metus. Sed vitae ipsum at odio consectetur volutpat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque dictum ligula ligula, ut sollicitudin mauris ultrices ultrices. Maecenas magna risus, gravida eget orci ac, vestibulum rutrum risus. Cras ut mattis augue, at sagittis nisl. Praesent interdum odio vitae lacus finibus dignissim. Quisque fermentum ultrices dui, vel fringilla metus lobortis in. Fusce et tortor sed tortor auctor vestibulum. Aenean et odio sem. Vivamus laoreet luctus neque, non sagittis mi pellentesque a. Vivamus rutrum euismod turpis et congue. Integer id ipsum aliquet, placerat erat quis, vestibulum velit. Pellentesque condimentum velit justo, vitae porttitor lectus dignissim eget.",
    magazineImages: "assets/images/trendMagazines/v_mag_1.png",
    textColor: VmodelColors.primaryColor ,
    ),
   const VWidgetsVmagazinePage( magazineText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id iaculis eros, ac hendrerit eros. Vestibulum egestas vitae mi sed rutrum. Phasellus et accumsan metus. Sed vitae ipsum at odio consectetur volutpat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque dictum ligula ligula, ut sollicitudin mauris ultrices ultrices. Maecenas magna risus, gravida eget orci ac, vestibulum rutrum risus. Cras ut mattis augue, at sagittis nisl. Praesent interdum odio vitae lacus finibus dignissim. Quisque fermentum ultrices dui, vel fringilla metus lobortis in. Fusce et tortor sed tortor auctor vestibulum. Aenean et odio sem. Vivamus laoreet luctus neque, non sagittis mi pellentesque a. Vivamus rutrum euismod turpis et congue. Integer id ipsum aliquet, placerat erat quis, vestibulum velit. Pellentesque condimentum velit justo, vitae porttitor lectus dignissim eget.",
   magazineImages: "assets/images/trendMagazines/popular2.png",),
   const VWidgetsVmagazinePage( magazineText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id iaculis eros, ac hendrerit eros. Vestibulum egestas vitae mi sed rutrum. Phasellus et accumsan metus. Sed vitae ipsum at odio consectetur volutpat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque dictum ligula ligula, ut sollicitudin mauris ultrices ultrices. Maecenas magna risus, gravida eget orci ac, vestibulum rutrum risus. Cras ut mattis augue, at sagittis nisl. Praesent interdum odio vitae lacus finibus dignissim. Quisque fermentum ultrices dui, vel fringilla metus lobortis in. Fusce et tortor sed tortor auctor vestibulum. Aenean et odio sem. Vivamus laoreet luctus neque, non sagittis mi pellentesque a. Vivamus rutrum euismod turpis et congue. Integer id ipsum aliquet, placerat erat quis, vestibulum velit. Pellentesque condimentum velit justo, vitae porttitor lectus dignissim eget.",
   magazineImages: "assets/images/trendMagazines/popular1.png",),
  ];
  
  

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: VWidgetsAppBar(
      leadingIcon: const VWidgetsBackButton(),
      appbarTitle: "",
      elevation: 0,
      trailingIcon:  [
        IconButton(onPressed: (){}, icon: 
        const NormalRenderSvg(
                    svgPath: VIcons.searchIcon,
                  ),
                  )
      ],
     ),
      body: Stack(
        children: [
        PageView(
                  scrollDirection: Axis.horizontal, 
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,           
                  padEnds: true,
                  children:_pageList,
   
                  onPageChanged: (value) {
                      setState(() {
                      _currentPage = value;
                    });
                  },
                ),
         
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Align(
              alignment: Alignment.bottomCenter,
               child: Container(
                padding: const EdgeInsets.symmetric(vertical :4, horizontal: 8),
                decoration: const BoxDecoration(
                  color: VmodelColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                ),

                 child: Text(
                    "${_currentPage + 1} of ${_pageList.length}",
                    style:  Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w300,
                          color: VmodelColors.white,
                        ),
                  ),
               ),
             ),
           ),
           
           
        ],
      )
    );
  }
}