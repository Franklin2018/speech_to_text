import 'package:flutter/material.dart';

import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(       
        primarySwatch: Colors.blue,
      );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speech to Text',
      theme: themeData,
      home: VoiceHome(),
    );
  }
}

  class VoiceHome extends StatefulWidget {
    @override
    _VoiceHomeState createState() => _VoiceHomeState();
  }
  
  class _VoiceHomeState extends State<VoiceHome> {

    SpeechRecognition _speechRecognition; //objeto de reconocimiento de voz
    bool _isAvailable = false;
    bool _isListening = false;

    String transcription = ''; //aqui tendremos el resultado de la transcripcion
    
    @override
    void initState() { 
      super.initState();
      activateSpeechRecognizer();
    }
     void activateSpeechRecognizer() {
       _speechRecognition = SpeechRecognition();

       _speechRecognition.setAvailabilityHandler(onSpeechAvailability);
       _speechRecognition.setRecognitionStartedHandler(onRecognitionStarted);
       _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
       _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);

       _speechRecognition.activate().then((res) => setState(() => _isAvailable = res));

     }

// diseño de interfaz
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
          title: Text('Speech to Text'),
          ),
          body: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Aquí vera su resultado.',
                    style: TextStyle(fontSize: 22),),
                  )
                ],
              ),
              Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(                          
                                  mini: true,
                                  backgroundColor: Colors.deepOrange,
                                  child: Icon(Icons.delete_forever),
                                  onPressed: (){},                            
                                ),
                                FloatingActionButton(
                                  child: Icon(Icons.mic),
                                  onPressed: (){},
                                ),
                                FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  child: Icon(Icons.stop),
                                  onPressed: (){},
                                )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      );
    }

 
  // metodos
  void onSpeechAvailability(bool result) => setState(() => _isAvailable = result);

  void onRecognitionStarted() => setState(() => _isListening = true);//aui el microfono esta escuchando

  void onRecognitionResult(String text) => setState(() => transcription = text);// aqui la funcion devolvera el texto

  void onRecognitionComplete() => setState(() => _isListening = false); //para avisar que se completo el dictado, deja de escuchar
}