import 'package:flutter/material.dart';
import 'package:note_app/create/add_notes.dart';
import 'package:note_app/details/note_details.dart';
import 'package:note_app/homepage/homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/utils/database_helper.dart';
import 'generated/app_localizations.dart';
import 'models/note.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCROzn0YRyJ2bt4xQ9RKr3-H9MaapoAV5o",
      projectId: "note-b3cd5",
      messagingSenderId: "741796231968",
      appId: "1:741796231968:android:2ba5d3ee8750d3d8bb7545",

    ),
  );

  Note myNote = Note(
    id: '123',
    // A string is expected here
    title: 'My Note',
    description: 'This is my note',
    date: DateTime.now(),  // Date is expected to be a string in this format
  );





  runApp(MyApp(

  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var supportedLocales = [
      Locale('en', 'US'),
      Locale('ar', 'SA'),
    ];

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      title: 'Note App',
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: "images/logo.png",
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),

      routes: {

        "homepage": (context) => HomePage(),
        "addnotes": (context) => AddNotes(),
        "notedetails": (context) => NoteDetails(note: ModalRoute.of(context)!.settings.arguments as Note),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}





