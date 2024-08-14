import 'dart:math';

import 'package:app_vitavibe/other/review_data/review_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../other/Theme/colors.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/widgets/text_widget.dart';

class DetailedGuidanceScreen extends StatefulWidget {
  final String supplementName,
      supplementUrl,
      supplementsDetails,
      supplementsBenefits,
      interactionWarningOfSupplement,
      supplementDosage;
  DetailedGuidanceScreen(
      {required this.supplementUrl,
      required this.supplementName,
      required this.supplementsDetails,
      required this.interactionWarningOfSupplement,
      required this.supplementDosage,
      required this.supplementsBenefits});

  @override
  State<DetailedGuidanceScreen> createState() => _DetailedGuidanceScreenState();
}

class _DetailedGuidanceScreenState extends State<DetailedGuidanceScreen> {
  late ReviewData reviewData;
  @override
  void initState() {
    super.initState();
  reviewData= ReviewData.generateRandomReview();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions dimensions = AppDimensions(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const TextWidget(text: 'Vita Vibe', fontSize: 24),
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.black12,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      height: dimensions.height * 0.18,
                      width: dimensions.width * 0.35,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black12), // Optional subtle border
                        borderRadius:
                            BorderRadius.circular(12), // Smooth rounded corners
                        gradient: LinearGradient(
                          // Add a gradient for visual interest
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.lightGreenAccent.shade200,
                            Colors.tealAccent.shade400,
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
                          imageUrl: widget.supplementUrl,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          )),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/s.jpg',
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    width: dimensions.width * 0.56,
                    height: dimensions.height * 0.18,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    // color: Colors.blue, // for testing dimensions
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.supplementName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'f',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(
                          'Benefits',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'f',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(
                          'Interaction Warning',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'f',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(
                          'Dosage',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'f',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            // Handle rating change if needed
                          },
                          starCount: 5,
                          rating: 4,
                          size: 20.0,
                          filledIconData: Icons.star_purple500_sharp,
                          halfFilledIconData: Icons.blur_on,
                          color: Colors.green,
                          borderColor: Colors.green,
                          spacing: 0.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Additional detailed content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.supplementsDetails,
                        // 'Here are more detailed information about the Ancient Nutrient product. This section can be used to provide extensive details about the product, including its benefits, possible side effects, and other relevant information that would help the user make an informed decision.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Benefits',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.supplementsBenefits,
                        //'1. Improves digestion.\n2. Boosts immune system.\n3. Provides essential vitamins and minerals.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Interaction Warnings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.interactionWarningOfSupplement,
                        //1. May interact with blood-thinning medications.\n2. Consult with your healthcare provider before starting any new supplement.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Dosage',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.supplementDosage,
                        //  'Take one capsule daily with meals or as directed by your healthcare provider.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Customer Reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Example review
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              reviewData.reviewersName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            SmoothStarRating(
                              allowHalfRating: true,
                              starCount: 5,
                              rating: reviewData.reviewersRating,
                              size: 15.0,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              color: Colors.green,
                              borderColor: Colors.green,
                              spacing: 0.0,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              reviewData.reviewersReviews,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Add more reviews as needed
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
