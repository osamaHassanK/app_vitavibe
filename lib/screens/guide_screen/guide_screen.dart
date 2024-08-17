import 'package:app_vitavibe/bloc/dashboard_bloc/dashboard_event.dart';
import 'package:app_vitavibe/bloc/health_tip_bloc/health_tip_bloc.dart';
import 'package:app_vitavibe/other/Theme/colors.dart';
import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:app_vitavibe/other/widgets/glowingbuttonwidget.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/dashboard_bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_bloc/dashboard_state.dart';

Widget guideScreenWidget(BuildContext context,
    //String? imageUrl,
    List<Map<String,dynamic>> tips) {
  AppDimensions dimensions = AppDimensions(context);
  String? userName = FirebaseAuth.instance.currentUser?.displayName;

  return BlocProvider(
  create: (context) => HealthTipBloc(),
  child: Container(
    height: dimensions.height,
    width: dimensions.width,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         Navigator.pushNamed(context, '/profile');
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //         child: CircleAvatar(
          //           radius: 20.0,
          //           backgroundImage: imageUrl == null || imageUrl.isEmpty
          //               ? const AssetImage('assets/images/user.png')
          //               : CachedNetworkImageProvider(imageUrl),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: dimensions.width*0.01),
          //     Text(
          //       "Welcome, ${userName ?? ''}",
          //       style: TextStyle(fontSize: 18, fontFamily: 'f'),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 0,left: 12,right: 10),
            child: Row(
              children: [
                Text(
                  'AI-Based Suggestions',
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontFamily: 'f',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GlowingButton(onPressed: () {
                  Navigator.pushNamed(context,'/aiBasedMedicineSuggestions' );
                }, title: 'Click Here', height: dimensions.height*0.05, width:dimensions.width*0.25,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12),
            child: Text(
              'Health Tips',
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontFamily: 'f',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
             // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(12),
              //   // border: Border.all(color: Colors.grey),
              //   // boxShadow: [
              //   //   BoxShadow(
              //   //     color: Colors.grey.withOpacity(0.3),
              //   //     spreadRadius: 2,
              //   //     blurRadius: 5,
              //   //     offset: Offset(0, 3), // changes position of shadow
              //   //   ),
              //   // ],
              // ),
              height: dimensions.height * 0.13,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlocBuilder<HealthTipBloc, HealthTipState>(
                      builder: (context, state) {
                        if (tips.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          );
                        }
                        return CarouselSlider.builder(
                          itemCount: tips.length,
                          itemBuilder: (context, index, realIndex) {
                            final tip = tips[index];
                            final tipText = tip['tip'] ?? '';

                            return Container(
                              //width: dimensions.width * 0.88,
                            //  margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  tipText,
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: dimensions.height*0.1,
                            aspectRatio: 21/9,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.9, // Adjust the visible part of neighboring slides
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 5),
                child: SizedBox(
                  height: dimensions.height*0.06,
                  width: dimensions.width*0.89,
                  child: TextFormField(
                    onChanged: (searchInput) {
                      String transformedInput = searchInput.isNotEmpty
                          ? searchInput[0].toUpperCase() +
                              searchInput.substring(1).toLowerCase()
                          : '';
                      context
                          .read<DashboardBloc>()
                          .add(SearchSupplement(transformedInput));
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          '[a-zA-Z ]')), // Allows only alphabets and spaces
                    ],
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelStyle: const TextStyle(fontFamily: 'f'),
                      hintText: 'Search Supplement',
                      hintStyle: const TextStyle(fontFamily: 'f'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: dimensions.height * 0.5,
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('supplements')
                      .where('name',
                          isGreaterThanOrEqualTo: state.searchBarValue)
                      .where('name',
                          isLessThanOrEqualTo: '${state.searchBarValue}\uf8ff')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong: ${snapshot.error}',
                          style: TextStyle(
                            fontFamily: 'f',
                            color: AppColor.primaryColor,
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.data?.docs.isEmpty == true) {
                      return Center(
                        child: Text(
                          'No supplements found',
                          style: TextStyle(
                            fontFamily: 'f',
                            color: AppColor.primaryColor,
                          ),
                        ),
                      );
                    }
                    final supplements = snapshot.data!.docs;

                    return ListView.builder(
                        itemCount: supplements.length,
                        itemBuilder: (context, index) {
                          final supplementDoc = supplements[index];
                          final supplementData =
                              supplementDoc.data() as Map<String, dynamic>;
                          final supplementImageUrl =
                              supplementData['image_url'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detailed-guidance',
                                arguments: {
                                  'supplementUrl': supplementImageUrl,
                                  'supplementName': supplementData['name'],
                                  'supplementsDetails':
                                      supplementData['detail'],
                                  'interactionWarningOfSupplement':
                                      supplementData['interaction_warning'],
                                  'supplementDosage': supplementData['dosage'],
                                  'supplementsBenefits':
                                      supplementData['benefits'],
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                    height: dimensions.height * 0.18,
                                    width: dimensions.width * 0.35,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors
                                              .black12), // Optional subtle border
                                      borderRadius: BorderRadius.circular(
                                          12), // Smooth rounded corners
                                      gradient: LinearGradient(
                                        // Add a gradient for visual interest
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.lightGreenAccent.shade200,
                                          Colors.tealAccent.shade400
                                        ],
                                      ),
                                      boxShadow: [
                                        // Subtle shadow for depth
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: supplementImageUrl,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/s.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Container(
                                  width: dimensions.width * 0.56,
                                  height: dimensions.height * 0.18,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  //  color: Colors.blue, for testing dimensions
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${supplementData['name']}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'f',
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const Text(
                                        'Benefits',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'f',
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const Text(
                                        'Interation Warning',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'f',
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      const Text(
                                        'Dosage',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'f',
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      // const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            'Rating: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'f',
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text(
                                            '${supplementData['rating']} ',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'f',
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                      // SmoothStarRating(
                                      //     allowHalfRating: false,
                                      //     onRatingChanged: (v) {
                                      //       // rating = v;
                                      //       // setState(() {});
                                      //     },
                                      //     starCount: 6,
                                      //     rating: (supplementData['rating'] as num?)?.toDouble() ?? 0.0,
                                      //     size: 20.0,
                                      //     filledIconData: Icons.star_purple500_sharp,
                                      //     halfFilledIconData: Icons.star_outline_sharp,
                                      //     color: Colors.green,
                                      //     borderColor: Colors.green,
                                      //     spacing:0.0
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  ),
);
}
