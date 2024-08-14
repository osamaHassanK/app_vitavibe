// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/health_tip_bloc/health_tip_bloc.dart';
// import '../../bloc/health_tip_bloc/health_tip_event.dart';
// import '../../bloc/health_tip_bloc/health_tip_state.dart';
//
// class HealthTipsCarousel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HealthTipsBloc()..add(FetchHealthTips()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Health Tips'),
//         ),
//         body: BlocBuilder<HealthTipsBloc, HealthTipsState>(
//           builder: (context, state) {
//             if (state is HealthTipsInitial) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is HealthTipsError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else if (state is HealthTipsLoaded) {
//               return Column(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     child: PageView.builder(
//                       itemCount: state.tips.length,
//                       scrollDirection: Axis.horizontal,
//                       onPageChanged: (index) {
//                         context.read<HealthTipsBloc>().add(UpdateCurrentIndex(index));
//                       },
//                       itemBuilder: (context, index) {
//                         final tip = state.tips[index];
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Health Tips',
//                               style: TextStyle(
//                                 color: Colors.blue, // AppColor.primaryColor,
//                                 fontFamily: 'f',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.83,
//                               child: Text(
//                                 tip,
//                                 style: TextStyle(
//                                   overflow: TextOverflow.visible,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10), // Space between the carousel and dots
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       state.tips.length,
//                           (index) => Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: state.currentIndex == index ? Colors.blue : Colors.grey, // Highlight current dot
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return SizedBox(); // Empty widget if state doesn't match
//           },
//         ),
//       ),
//     );
//   }
// }
