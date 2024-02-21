import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pichunt/Provider/Auth/auth.dart';
import 'package:provider/provider.dart';
import 'Provider/favorite.dart';
import 'Screens/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesProvider>(
            create: (context) => FavoritesProvider()),
        ChangeNotifierProvider<Authentication>(
            create: (context) => Authentication()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
