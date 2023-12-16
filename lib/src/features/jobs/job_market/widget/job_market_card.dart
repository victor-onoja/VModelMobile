import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsJobMarketCard extends StatelessWidget {
  final String? userName;
  final String? imagePath;
  final String? address;
  final String? time;
  // final String? gender;
  final String? fees;

  final VoidCallback? onPressedShare;
  final VoidCallback? onTapCard;

  const VWidgetsJobMarketCard(
      {required this.userName,
      required this.imagePath,
      required this.address,
      required this.time,
      // required this.gender,
      required this.fees,

      required this.onPressedShare,
      required this.onTapCard,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Card(
       
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                  // constraints: BoxConstraints.expand(
                  //   height: screenSize.height * 0.125,
                  // ),
                  //padding: EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[

                       Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RenderSvg(
                            svgPath: VIcons.shareIcon,
                            svgHeight: 23,
                            svgWidth: 23,
                            color: VmodelColors.white,
                            // color: Color(0xff543B3A),
                          ),
                        ),
                      ),

                       Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RenderSvg(
                            svgPath: VIcons.unlikedIcon,
                            svgHeight: 23,
                            svgWidth: 23,
                            color: VmodelColors.white,
                            // color: Color(0xff543B3A),
                          ),
                        ),
                      ),

                       Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Tilly’s Bakery Services",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: VmodelColors.white, fontWeight: FontWeight.w600, fontSize: 14
                            ),),
                        ),
                      ),


                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("2 Days ago",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: VmodelColors.white, fontWeight: FontWeight.w500, fontSize: 12
                            ),),
                        ),
                      ),
                    ],
                  )
              ),
              //-----------

              addVerticalSpacing(10),
              //-----------------------
              Text("Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models, 2 female models and one camera man. Interested parties should apply below, thanks!",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: VmodelColors.primaryColor, fontWeight: FontWeight.w500, fontSize: 11.sp, wordSpacing: 5),
              ),

              addVerticalSpacing(20),
              //-----------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  JobInfo(svgPath: VIcons.locationIcon, title: address!,),
                  // JobInfo(svgPath: VIcons.humanIcon, title: gender!,),
                  JobInfo(svgPath: VIcons.clockIcon, title:  time!,),
                  JobInfo(svgPath: VIcons.walletIcon, title:  "\$$fees",),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



class JobInfo extends StatelessWidget {
  const JobInfo({Key? key, required this.title, required this.svgPath}) : super(key: key);

  final String title;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           RenderSvg(
            svgPath: svgPath,
            svgHeight: 14,
            svgWidth: 14,
            color: VmodelColors.primaryColor,
          ),
          addHorizontalSpacing(7),
          Flexible(
            child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(
                  fontWeight: FontWeight.w500,

                  color: Theme.of(context).primaryColor,
                  fontSize: 11.sp),
            ),
          ),
        ],
      ),
    );
  }
}
