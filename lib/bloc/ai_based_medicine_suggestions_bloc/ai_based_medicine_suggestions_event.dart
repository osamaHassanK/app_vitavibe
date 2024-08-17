part of 'ai_based_medicine_suggestions_bloc.dart';

abstract class AiBasedMedicineSuggestionsEvent extends Equatable {}


class GetDiseaseInput extends AiBasedMedicineSuggestionsEvent {

  final String disease;

  GetDiseaseInput({required this.disease});

  @override
  List<Object?> get props => [];
}

class GenerateResponse extends AiBasedMedicineSuggestionsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
