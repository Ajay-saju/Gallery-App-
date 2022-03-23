import 'package:flutter/material.dart';

import 'package:my_gallery/adaptors/gallery_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'myHomeScreen.dart/myHomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive
      .initFlutter(); //initializing Hive needs to know where it can store data
  Hive.registerAdapter(GalleryModelAdapter()); // register custome adapter
  await Hive.openBox<Gallery_Model>('gallery_models'); //open hive box.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        fontFamily: 'Georgia',
      ),
      home: const MyHomeScreen(),
    );
  }
}
