import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/assets/main_assets_path.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class MapSearch extends ConsumerStatefulWidget {
  const MapSearch({super.key});

  @override
  ConsumerState<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends ConsumerState<MapSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(VmodelAssets1.mapImage))
        ),
        child: Stack(
          children: [
             Positioned(
              top: 50,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                            ),
                            child:CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(VmodelAssets1.mapAvatar1),
                                backgroundColor:VmodelColors.greyColor,
                              ) ,
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: VmodelColors.grey.withOpacity(0.6),
                            shape: BoxShape.circle
                          ),
                          child: IconButton(
                            onPressed: (){}, 
                            icon:  RenderSvg(
                            svgPath: VIcons.searchIcon, color: VmodelColors.white,
                          ),)
                        ),
                         SizedBox(width: 5,),
                         Container(
                          padding: EdgeInsets.all(1),
                          height: 35,
                          width: 140,
                          decoration: BoxDecoration(
                            color: VmodelColors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(60)
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: VmodelColors.white,
                                child:CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage("assets/images/puppy.jpeg"),
                                backgroundColor: VmodelColors.greyColor,
                              ) ,
                              ),
                              SizedBox(width: 30,),
                              Center(
                                child: Text("Bolton", textAlign: TextAlign.center, style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.w600, color: VmodelColors.white),),
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                      Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                       color: Colors.grey.withOpacity(0.4),
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                        onPressed: (){}, 
                        icon:  RenderSvg(
                        svgPath: VIcons.menuSettings, color:VmodelColors.white,
                      ),)
                    )
                  ],
                ),
              )),

              Positioned(
                bottom: 40,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    
                      Stack(
                         clipBehavior: Clip.none,
                        children: [
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: AssetImage(VmodelAssets1.mapAvatar2),
                                    backgroundColor:VmodelColors.white,
                                  ),
                              ),
                              ),
                          ),
                          Positioned(
                            bottom: -12,
                            left: -15,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: VmodelColors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                child: Text("My BitMoji", style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 11),),
                              ),
                            )
                            )
                        ],
                      ),

                        Stack(
                         clipBehavior: Clip.none,
                        children: [
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: AssetImage(VmodelAssets1.mapAvatar1),
                                    backgroundColor:VmodelColors.white,
                                  ),
                              ),
                              ),
                          ),
                          Positioned(
                            bottom: -12,
                            left: -7,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: VmodelColors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                child: Text("Places", style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 11),),
                              ),
                            )
                            )
                        ],
                      ),

                        Stack(
                         clipBehavior: Clip.none,
                        children: [
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: AssetImage(VmodelAssets1.mapAvatar2),
                                    backgroundColor:VmodelColors.white,
                                  ),
                              ),
                              ),
                          ),
                          Positioned(
                            bottom: -12,
                            left: -7,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: VmodelColors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                child: Text("Friends", style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 11),),
                              ),
                            )
                            )
                        ],
                      ),

                    ],
                   ),
                )
              )
          ],
        ),
      ),
    );
  }
}