import 'package:equatable/equatable.dart';

enum FeedbackStatus { feedbackInitial, feedbackLoading,feedbackFailed,feedbackSubmitted }

class FeedbackState extends Equatable {
  final String feedback;
  final String message;
  final FeedbackStatus feedbackStatus;
  const FeedbackState(
      {this.feedback = '',
      this.message = '',
      this.feedbackStatus = FeedbackStatus.feedbackInitial});

  FeedbackState copyWith({
    String? feedback,
    FeedbackStatus? feedbackStatus,
   String? message})
  {
    return FeedbackState(
        feedback: feedback ?? this.feedback,
        feedbackStatus: feedbackStatus ?? this.feedbackStatus,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props =>
      [feedback, message, feedbackStatus];
}
