import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'auth.dart';

class Install extends StatefulWidget {
  @override
  InstallState createState() => InstallState();
}

class InstallState extends State<Install> {
  final List<File> _images = [];
  @override
  Widget build(BuildContext context) {
    //File _image; // Used only if you need a single picture
    Future getImage(bool gallery) async {
      ImagePicker picker = ImagePicker();
      PickedFile pickedFile;
      // Let user select photo from gallery
      if (gallery) {
        pickedFile = await picker.getImage(
          source: ImageSource.gallery,
        );
      }
      // Otherwise open camera to get new photo
      else {
        pickedFile = await picker.getImage(
          source: ImageSource.camera,
        );
      }

      setState(() {
        if (pickedFile != null) {
          _images.add(File(pickedFile.path));
          //_image = File(pickedFile.path); // Use if you only need a single picture
        } else {
          print('No image selected.');
        }
      });
    }

    void upload() async {
      Reference ref = FirebaseStorage.instance.ref('imgs/' + getId());
      print(_images);
      _images.forEach((image) async {
        print("adding " + image.toString());
        try {
          await ref.child(basename(image.path)).putFile(image);
        } on FirebaseException catch (e) {
          print("ERROR");
          print(e);
        }
        String imageURL =
            await ref.child(basename(image.path)).getDownloadURL();
        FirebaseFirestore.instance.collection('images').doc(getId()).set({
          "images": FieldValue.arrayUnion([imageURL])
        }, SetOptions(merge: true));
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Uploaded!'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Theme.of(context).primaryColor,
                  child: const Text('Ok!'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Installation Manager')),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: RawMaterialButton(
              fillColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.add_photo_alternate_rounded,
                color: Colors.white,
              ),
              elevation: 8,
              onPressed: () {
                getImage(true);
              },
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),
            ),
          ),
          Align(
            child: ElevatedButton(
              child: Text('Upload'),
              onPressed: upload,
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            itemCount: _images.length,
            itemBuilder: (context, idx) {
              return Image.file(_images[idx]);
            },
          ),
        ],
      ),
    );
  }
}
