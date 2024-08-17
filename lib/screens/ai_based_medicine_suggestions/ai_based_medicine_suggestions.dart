import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ai_based_medicine_suggestions_bloc/ai_based_medicine_suggestions_bloc.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/widgets/glowingbuttonwidget.dart';

class AiBasedMedicineSuggestions extends StatefulWidget {
  const AiBasedMedicineSuggestions({super.key});

  @override
  State<AiBasedMedicineSuggestions> createState() =>
      _AiBasedMedicineSuggestionsState();
}

class _AiBasedMedicineSuggestionsState
    extends State<AiBasedMedicineSuggestions> {
  late AiBasedMedicineSuggestionsBloc ai_bloc;

  @override
  void initState() {
    super.initState();
    ai_bloc = AiBasedMedicineSuggestionsBloc();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = AppDimensions(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('AI Based Suggestion',
            style: TextStyle(fontSize: 20, fontFamily: 'f')),
        backgroundColor: Colors.white,
        // shadowColor: Colors.white,
        //elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context) => AiBasedMedicineSuggestionsBloc(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: dimensions.height * 0.01,
                ),
                Row(
                  children: [
                    BlocBuilder<AiBasedMedicineSuggestionsBloc,
                        AiBasedMedicineSuggestionsState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: dimensions.height * 0.06,
                          width: dimensions.width * 0.7,
                          child: TextFormField(
                            onChanged: (disease) {
                              context
                                  .read<AiBasedMedicineSuggestionsBloc>()
                                  .add(GetDiseaseInput(disease: disease));
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  '[a-zA-Z ]')), // Allows only alphabets and spaces
                            ],
                            decoration: InputDecoration(
                              //   suffixIcon: Icon(Icons.search),
                              labelStyle: const TextStyle(fontFamily: 'f'),
                              hintText: 'Enter a prompt here',
                              hintStyle: const TextStyle(
                                  fontFamily: 'f', fontSize: 15),
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
                        );
                      },
                    ),
                    BlocBuilder<AiBasedMedicineSuggestionsBloc,
                        AiBasedMedicineSuggestionsState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GlowingButton(
                            onPressed: () {
                              context
                                  .read<AiBasedMedicineSuggestionsBloc>()
                                  .add(GenerateResponse());
                            },
                            title: 'Generate',
                            height: dimensions.height * 0.05,
                            width: dimensions.width * 0.2,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: dimensions.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/microchip.png',
                      scale: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextWidget(text: 'Ai Generative Response', fontSize: 20),
                  ],
                ),
                SizedBox(
                  height: dimensions.height * 0.03,
                ),
                BlocBuilder<AiBasedMedicineSuggestionsBloc,
                    AiBasedMedicineSuggestionsState>(
                  builder: (context, state) {
                    return state.status == Response.Loading
                        ? Column(
                            children: [
                              SizedBox(
                                height: dimensions.height * 0.1,
                              ),
                              CircularProgressIndicator(),
                            ],
                          )
                        : state.response == Response.Error ? TextWidget(text: 'Something Went wrong', fontSize: 14) :
                    Container(
                            width: dimensions.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.response == ''
                                  ? 'Awaiting response...'
                                  : _cleanResponse(state.response),
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'f',
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _cleanResponse(String response) {
    // Remove any instances of "***" and "##"
    response = response.replaceAll(RegExp(r'\*\*\*'), '');
    response = response.replaceAll(RegExp(r'##'), '');
    response = response.replaceAll('***', '');
    response = response.replaceAll('**', '');
    response = response.replaceAll('*', '');


    // Remove any leading or trailing whitespace
    response = response.trim();

    return response;
  }



}
