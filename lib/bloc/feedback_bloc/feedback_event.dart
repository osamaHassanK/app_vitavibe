import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}

class ChangeFeedback extends FeedbackEvent{
  final String newFeedback;
  ChangeFeedback({required this.newFeedback});
  @override
  List<Object?> get props => [newFeedback];
}

class SubmitFeedback extends FeedbackEvent {
  final String feedback;

  const SubmitFeedback(this.feedback);

  @override
  List<Object?> get props => [feedback];
}