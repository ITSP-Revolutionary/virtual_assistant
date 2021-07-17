//@dart=2.9
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:device_apps/device_apps.dart';
extension StringExtensions on String {
  bool containsIgnoreCase(String secondString) => this.toLowerCase().contains(secondString.toLowerCase());

//bool isNotBlank() => this != null && this.isNotEmpty;
}





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final FlutterTts tts = FlutterTts();
  SpeechScreen(){
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }


  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome to your virtual assistant'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 3000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _speak(){
    tts.speak('sure');
  }
  void _speaknotinstalled(){
    tts.speak('This app is not installed');
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      present();
      _speech.stop();
    }
  }

  Future<void> present() async {
    if (_text.containsIgnoreCase('youtube')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.youtube');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.google.android.youtube');
      }
      else{
        _speaknotinstalled();
        _text = 'This is not installed';}
    }
    else if (_text.containsIgnoreCase('whatsapp')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.whatsapp');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.whatsapp');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }

    else if (_text.containsIgnoreCase('spotify')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.spotify.music');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.spotify.music');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }


    else if ((_text.containsIgnoreCase('Teams')||_text.containsIgnoreCase('ms teams')) && (_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.microsoft.teams');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.microsoft.teams');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('instagram')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.instagram.android');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.instagram.android');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('telegram')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('org.telegram.messenger');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('org.telegram.messenger');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('facebook')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.facebook.katana');
      if (isInstalled == true){
        _speak();
      DeviceApps.openApp('com.facebook.katana');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('safe')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.iitb.cse.arkenstone.safe_v2');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.iitb.cse.arkenstone.safe_v2');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('zoom')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('us.zoom.videomeetings');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('us.zoom.videomeetings');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('twitter')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.twitter.android');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.twitter.android');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('arogya setu')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('nic.goi.aarogyasetu');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('nic.goi.aarogyasetu');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('paytm')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('net.one97.paytm');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('net.one97.paytm');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('google pay')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.apps.nbu.paisa.user');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.google.android.apps.nbu.paisa.user');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('discord')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.discord');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.discord');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('quora')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.quora.android');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.quora.android');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('google chrome')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.android.chrome');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.android.chrome');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('google maps')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.apps.maps');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.google.android.apps.maps');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('google drive')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.apps.docs');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.google.android.apps.docs');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('google photos')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.apps.photos');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.google.android.apps.photos');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('amazon')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('in.amazon.mShop.android.shopping');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('in.amazon.mShop.android.shopping');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if (_text.containsIgnoreCase('flipkart')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.flipkart.android');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('com.flipkart.android');
      }
      else{
        _speaknotinstalled();
        _text= 'This app in not installed';}
    }
    else if (_text.containsIgnoreCase('instiapp')&&(_text.containsIgnoreCase('open')||_text.containsIgnoreCase('launch'))) {
      bool isInstalled = await DeviceApps.isAppInstalled('app.insti');
      if (isInstalled == true){
        _speak();
        DeviceApps.openApp('app.insti');
      }
      else{
        _speaknotinstalled();
        _text = 'This app is not installed';}
    }
    else if ((_text.containsIgnoreCase('install')||_text.containsIgnoreCase('download'))) {
      tts.speak("sorry i can't do that");
    }

    else{
      tts.speak("sorry i don't have access to this app");
      _text = "sorry i don't have access to this app";
    }



  }


}
