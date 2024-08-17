part of 'ai_based_medicine_suggestions_bloc.dart';

enum Response{initial,Loading,Success,Error}
class AiBasedMedicineSuggestionsState extends Equatable {

  final String disease;
  final String response;
  Response status;

  AiBasedMedicineSuggestionsState({ this.disease='', this.response='',this.status= Response.initial});

  AiBasedMedicineSuggestionsState copyWith({
    String? disease,
    String? response,
    Response? status
  }) {
    return AiBasedMedicineSuggestionsState(
      disease: disease ?? this.disease,
      response: response ?? this.response,
        status: status ?? Response.initial,
    );
  }

  @override
  List<Object?> get props => [disease,response,status];
}
