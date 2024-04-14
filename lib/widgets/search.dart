import 'package:flutter/material.dart';
import 'package:project_3/const/style.dart';
import 'package:project_3/screens/Home/searchrender.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final searchController = TextEditingController();
  var texts = '';
  var isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  void initSpeechToText() async {
    bool available = await speechToText.initialize(
      onError: onError,
    );
    if (available) {
      setState(() {
        isListening = false;
      });
    }
  }

  void onError(SpeechRecognitionError error) {
    setState(() {
      isListening = false;
    });
    print("Error: ${error.errorMsg}");
  }

  @override
  Widget build(BuildContext context) {
    void handleSubmitted(String query) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchDisplay(query: query)),
      );
    }

    void setInputText(String text) {
      setState(() {
        searchController.text = text;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 5, // Shadow blur radius
              offset: const Offset(0, 3), // Shadow offset
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: searchController,
                textAlign: TextAlign.start,
                cursorColor: accent,
                style: p1,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      handleSubmitted(searchController.text);
                    },
                    child: Icon(
                      Icons.search,
                      size: 22,
                      color: text,
                    ),
                  ),
                  hintText: 'search places',
                  fillColor: white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: small),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTapDown: (details) async {
                bool isAvailable = await speechToText.initialize(
                  onStatus: (status) {
                    if (status == "notListening") {
                      setState(() {
                        isListening = false;
                        texts = '';
                      });
                    }
                  },
                  onError: onError,
                );
                if (isAvailable) {
                  setState(() {
                    isListening = true;
                  });
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        texts = result.recognizedWords;
                        setInputText(
                            texts); // Set the recognized words as input text
                        print(texts);
                      });
                    },
                  );
                }
              },
              onTapUp: (details) {
                setState(() {
                  isListening = false;
                });
                speechToText.stop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                width: 50,
                height: 50,
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
