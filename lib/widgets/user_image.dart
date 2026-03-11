import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImageState extends StatefulWidget {
  const UserImageState({super.key, required this.onPickImage});

final void Function(File pickedImage) onPickImage;

  @override
  State<UserImageState> createState() => _UserImageStateState();
}

class _UserImageStateState extends State<UserImageState> {
    
    File? pickedImageFile;
  void pickImage() async {
  final XFile? pickedImage =     await ImagePicker().pickImage(
        source: ImageSource.camera ,
        maxWidth: 150,
        imageQuality: 50,
        );
 if (pickedImage == null) {
   return;
 }
 setState(() {
   pickedImageFile = File(pickedImage.path);
 });

   widget.onPickImage(pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
       CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        foregroundImage: pickedImageFile == null 
        ? null
        : FileImage(pickedImageFile!)

       ),
       TextButton.icon(
        onPressed: pickImage,
        icon: Icon(Icons.image),
         label: Text('Add Image'),
         style: ButtonStyle(
       backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
         
         ),
         )
        ],
    );
}
}