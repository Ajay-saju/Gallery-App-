import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/adaptors/gallery_model.dart';

import 'file_creation.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int i = 0;
  File? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gallery App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
            valueListenable:
                Hive.box<Gallery_Model>('gallery_models').listenable(),
            builder: (context, Box<Gallery_Model> box, widget) {
              final List<Gallery_Model> data = box.values.toList();

              if (data.isEmpty) {
                return const Center(
                  child: Text('No Photos'),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(data[index].photo)),
                            fit: BoxFit.fill,
                          ))),
                  itemCount: data.length,
                );
              }
            }),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          pickImage();
        },
        icon: const Icon(
          Icons.camera,
          size: 50,
          color: Colors.black45,
        ),
      ),
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      img = File(image!.path);

      Hive.box<Gallery_Model>('gallery_models')
          .add(Gallery_Model(photo: img!.path));
    });

    Random random = Random();
    int i = random.nextInt(103233230);
    File(img!.path).copy('${directory!.path}/image$i.jpeg');
  }

  @override
  void initState() {
    createPath();
    super.initState();
  }
}
