import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vision_gpt/secerets.dart';

class OpenAIService {

  Future<String> isArtPromptAPI(String prompt) async {

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-4o",
          "messages": [
            {
              'role': 'user',
              'content' : 'Does this message want to generate an AI picture, image, art, or anything similar? $prompt . Simply answer with a yes or no.'
            }
          ],
        }),
      );
      print(res.body);
      if(res.statusCode == 200 ){
        print('yeah!!!!!!!!!!!!');
      }
      return 'AI';
      
    } catch (e) {
      return e.toString();
    }


  } 
  Future<String> chatGPTAPI(String prompt) async {
    return 'chatGPTAPI';
  } 
  Future<String> dallEAPI(String prompt) async {
    return 'dallEAPI';
  } 

}