import 'dart:math';

import 'package:app_vitavibe/other/firebase/addfeedback.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {


  FeedbackBloc() : super (FeedbackState()) {
    on<SubmitFeedback>(_onSubmitFeedback);
    on<ChangeFeedback>(_onChangeFeedback);
  }

  _onChangeFeedback(ChangeFeedback event, Emitter<FeedbackState> emit) {
    emit(state.copyWith(feedback: event.newFeedback));
  }


  Future<void> _onSubmitFeedback(SubmitFeedback event,
      Emitter<FeedbackState> emit) async {
    emit(state.copyWith(feedbackStatus: FeedbackStatus.feedbackLoading));
    try {

      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await addFeedback(user.email??'user Feedback' , state.feedback);
        emit(state.copyWith(feedbackStatus: FeedbackStatus.feedbackSubmitted));
      } else {
        emit(state.copyWith(feedbackStatus: FeedbackStatus.feedbackFailed,message: 'No feedback to submit.'));
        }
    } catch (e) {
      emit(state.copyWith(feedbackStatus: FeedbackStatus.feedbackFailed,message: '${e}'));
    }
  }
}
