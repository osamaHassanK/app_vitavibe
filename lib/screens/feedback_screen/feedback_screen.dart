import 'package:app_vitavibe/other/widgets/glowingbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feedback_bloc/feedback_bloc.dart';
import '../../bloc/feedback_bloc/feedback_event.dart';
import '../../bloc/feedback_bloc/feedback_state.dart';
import '../../other/app_dimensions/app_dimensions.dart';

class AddFeedbackScreen extends StatelessWidget {
  const AddFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = AppDimensions(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'VitaVibe',
          style: TextStyle(
            fontFamily: 'f',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            FeedbackBloc(),
        child: BlocListener<FeedbackBloc, FeedbackState>(
          listener: (context, state) {
            if (state.feedbackStatus == FeedbackStatus.feedbackSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Feedback submitted successfully!'),
                ),
              );
            } else if (state.feedbackStatus == FeedbackStatus.feedbackFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: dimensions.height * 0.02),
                      Image.asset(
                        'assets/images/pills.png',
                        scale: 4,
                      ),
                      const Text(
                        'We value your feedback!',
                        style: TextStyle(
                          fontFamily: 'f',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Please share your thoughts about the app below:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'f',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        maxLines: 6,
                        onChanged: (feedback) {
                          context.read<FeedbackBloc>().add(
                              ChangeFeedback(newFeedback: feedback));
                        },
                        decoration: InputDecoration(
                          labelText: 'Your Feedback',
                          labelStyle: const TextStyle(fontFamily: 'f'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(fontFamily: 'f'),
                      ),
                      const SizedBox(height: 20),

                      BlocBuilder<FeedbackBloc, FeedbackState>(
                        builder: (context, state) {
                          return
                            state.feedbackStatus == FeedbackStatus.feedbackLoading ?
                            CircularProgressIndicator():
                            GlowingButton(
                            onPressed: () {

                              if (state.feedback.isNotEmpty) {
                                context.read<FeedbackBloc>().add(
                                    SubmitFeedback(state.feedback));
                              } else if (state.feedback == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Feedback cannot be empty'),
                                  ),
                                );
                              }
                            },
                            title: 'Submit',
                            height: dimensions.height * 0.08,
                            width: dimensions.width * 0.3,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
