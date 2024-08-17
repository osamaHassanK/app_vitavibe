import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

part 'ai_based_medicine_suggestions_event.dart';
part 'ai_based_medicine_suggestions_state.dart';

class AiBasedMedicineSuggestionsBloc extends Bloc<
    AiBasedMedicineSuggestionsEvent, AiBasedMedicineSuggestionsState> {
  AiBasedMedicineSuggestionsBloc() : super(AiBasedMedicineSuggestionsState()) {
    on<GetDiseaseInput>(_updateDiseaseInput);
    on<GenerateResponse>(_generateResponse);
  }

  void _updateDiseaseInput(
      GetDiseaseInput event, Emitter<AiBasedMedicineSuggestionsState> emit) {
    emit(state.copyWith(disease: event.disease));
  }

  Future<void> _generateResponse(GenerateResponse event,
      Emitter<AiBasedMedicineSuggestionsState> emitter) async {
    emit(state.copyWith(status: Response.Loading));
   try{
     final model = GenerativeModel(
       apiKey: 'AIzaSyAWouBZv3c_oaebLpfrGgpXA1Psu7B7mA8',
       model: 'gemini-1.5-flash-latest',
     );
     final content = [Content.text('${state.disease}')];
     if(state.disease == ''){
       emit(state.copyWith(response: 'Enter a prompt first',status:  Response.Error));
     }else{
       final response = await model.generateContent(content);
       emit(state.copyWith(response: response.text,status: Response.initial));
     }
   }catch(e){
     String errorMessage = e.toString();
     emit(state.copyWith(response: 'Something went wrong',status:  Response.Error));
   }

   }
}
