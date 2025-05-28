import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // supabase setup
  await Supabase.initialize(
    url: "https://ojuqureolhregebrnjxz.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qdXF1cmVvbGhyZWdlYnJuanh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0MTQwNTEsImV4cCI6MjA2Mjk5MDA1MX0.nlHlQ1q7t_DGN4yfS75IW3y11SfhJ2vAnXkZq8XADGk",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NotePage());
  }
}
