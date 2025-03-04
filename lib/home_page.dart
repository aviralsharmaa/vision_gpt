import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart'
    show SpeechRecognitionResult;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vision_gpt/openai_service.dart';
import 'package:vision_gpt/options_box.dart';
import 'package:vision_gpt/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService= OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
   await speechToText.initialize(
      onStatus: (status) => print("Speech-to-Text Status: $status"),
      onError: (error) => print("Speech-to-Text Error: $error"),
    );

  }
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vision'),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                    // child: Container(
                    //   height: 120,
                    //   width: 120,
                    //   margin: EdgeInsets.only(top:4),
                    //   decoration: BoxDecoration(
                    //     color: Pallete.assistantCircleColor,
                    //     shape: BoxShape.circle,
                    //   ),
                    // ),
                    ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/virtualAssistant.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Chat Bubble
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Good Morning, What task can I do for you?',
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                    fontFamily: 'Cera Pro',
                  ),
                ),
              ),
            ),
            // suggestion Text
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                'Kindly Choose your Option.',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Options List
            Column(
              children: [
                OptionsBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headertext: "Vision GPT",
                  descriptiontext:
                      "A Smarter way to stay organized and informed with VisionGPT",
                ),
                OptionsBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headertext: "DALL-E",
                  descriptiontext:
                      "Get inspired and stay creative with your personal assistant powered by DALL-E",
                ),
                OptionsBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headertext: "Smart Voice Assistant",
                  descriptiontext:
                      "Get the best of both worlds with a voice assistant powered by DALL-E and ChatGPT",
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
            // print("Speech-to-Text is available!");
          } else if (speechToText.isListening) {
            await stopListening();
            // print("Stopping Listening...");
          } else {
            initSpeechToText();
          }
          print("Speech-to-Text Result: $lastWords");

        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
