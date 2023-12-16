import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes_app/nav_drawer_files/login_screens/my_login.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_recipes_app/models/note_model.dart';

class HomePage extends StatefulWidget {
  String? id;

  HomePage({this.id});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore db;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  late FirebaseStorage firebaseStorage;

  List<String> lstImgUrl = [];
  String pickedImgUrl = '';
  File? pickedImageFile;
  String profilepicsUrl = '';

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    FirebaseFirestore.instance
        .collection('users')
        .doc('lmzDE2BEpAYACJawClabzbdDi3I2')
        .get()
        .then((value) {
      //profilepicsUrl = value.get('profilepics');
      setState(() {});
    });

    var storageRef = firebaseStorage.ref();
    getImgUrl(storageRef);
  }

  void getImgUrl(Reference ref) async {
    ListResult result = await ref.child('images').listAll();

    for (Reference item in result.items) {
      var imgUrl = await item.getDownloadURL();
      lstImgUrl.add(imgUrl);
    }
    setState(() {});

    // var imgUrl = await ref.getDownloadURL();
    // lstImgUrl.add(imgUrl);
    // setState(() {
    //   print('Image loaded ${imgUrl}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          'This page is underworking, i just want to Navigate by perticulre users with using firebase',
          style: TextStyle(
            fontStyle: FontStyle.italic,

          ),
        )),
      ),
      /*StreamBuilder(
        stream: db
            .collection('users')
            .doc(widget.id)
            .collection('notes')
            .orderBy('title')
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Data not found'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  var model =
                  NoteModel.fromJson(snapshot.data!.docs[index].data());
                  model.id = snapshot.data!.docs[index].id;
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            titleController.text = model.title.toString();
                            bodyController.text = model.body.toString();
                            return Container(
                              height:
                              MediaQuery.of(context).viewInsets.bottom ==
                                  0.0
                                  ? 400
                                  : 800,
                              color: Colors.blue.shade100,
                              child: Column(
                                children: [
                                  Text('Update Note'),
                                  TextField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                        label: Text('Title'),
                                        hintText: 'Enter title here..!',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(21),
                                        )),
                                  ),
                                  TextField(
                                    controller: bodyController,
                                    decoration: InputDecoration(
                                        label: Text('Body'),
                                        hintText: 'Enter body here..!',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(21),
                                        )),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (titleController.text != ' ' &&
                                            bodyController.text != ' ') {
                                          db
                                              .collection('users')
                                              .doc(widget.id)
                                              .collection('notes')
                                              .doc(model.id)
                                              .set(NoteModel(
                                            title: titleController.text
                                                .toString(),
                                            body: bodyController.text
                                                .toString(),
                                          ).toJson())
                                              .then((value) {
                                            titleController.clear();
                                            bodyController.clear();
                                          });
                                        }
                                        titleController.clear();
                                        bodyController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Update')),
                                ],
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      title: Text('${model.title}'),
                      subtitle: Text('${model.body}'),
                      trailing: InkWell(
                          onTap: () {
                            //delete
                            db
                                .collection('notes')
                                .doc(model.id)
                                .delete()
                                .then((value) {
                              print('Record ${model.id} is deleted..');
                            });
                          },
                          child: Icon(Icons.delete)),
                    ),
                  );
                });
          }
          return Container();
        },
      ),*/
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyLogin()));
              },
              child: Text('Sign out')),
          FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: MediaQuery.of(context).viewInsets.bottom == 0.0
                          ? 400
                          : 800,
                      color: Colors.blue.shade100,
                      child: Column(
                        children: [
                          Text('Add Note'),
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                                label: Text('Title'),
                                hintText: 'Enter title here..!',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                )),
                          ),
                          TextField(
                            controller: bodyController,
                            decoration: InputDecoration(
                                label: Text('Body'),
                                hintText: 'Enter body here..!',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              // imagePicker
                              var imgFromGallery = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (imgFromGallery != null) {
                                ///pickedImageFile = File(imgFromGallery.path); // this line is used for picked image from gallery
                                var croppedFile =
                                    await ImageCropper().cropImage(
                                  sourcePath: imgFromGallery.path,
                                  uiSettings: [
                                    AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor: Colors.deepOrange,
                                        toolbarWidgetColor: Colors.white,
                                        initAspectRatio:
                                            CropAspectRatioPreset.original,
                                        lockAspectRatio: false),
                                    IOSUiSettings(
                                      title: 'Cropper',
                                    ),
                                    WebUiSettings(
                                      context: context,
                                      presentStyle: CropperPresentStyle.dialog,
                                      boundary: const CroppieBoundary(
                                        width: 520,
                                        height: 520,
                                      ),
                                      viewPort: const CroppieViewPort(
                                          width: 480,
                                          height: 480,
                                          type: 'circle'),
                                      enableExif: true,
                                      enableZoom: true,
                                      showZoomer: true,
                                    ),
                                  ],
                                );

                                if (croppedFile != null) {
                                  pickedImageFile = File(croppedFile.path);
                                }
                                setState(() {});
                              }
                            },
                            child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    shape: BoxShape.circle,
                                    image: pickedImageFile != null
                                        ? DecorationImage(
                                            image: FileImage(pickedImageFile!),
                                            fit: BoxFit.cover)
                                        : null)
                                //Image.network(pickedImageFile != null ? pickedImageFile.toString() : '') ,
                                ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var pickImageNew =
                                    await FileImage(pickedImageFile!);
                                if (titleController.text != ' ' &&
                                    bodyController.text != ' ') {
                                  db
                                      .collection('users')
                                      .doc(widget.id)
                                      .collection('notes')
                                      .add(NoteModel(
                                        title: titleController.text.toString(),
                                        body: bodyController.text.toString(),
                                        // profilepic: pickImageNew.toString()
                                      ).toJson())
                                      .then((value) {
                                    titleController.clear();
                                    bodyController.clear();
                                  });
                                }
                                titleController.clear();
                                bodyController.clear();
                                Navigator.pop(context);
                              },
                              child: Text('Submit')),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// FutureBuilder(
//         future: db.collection('notes').get(),
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Data not found'),);
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (_, index) {
//                   var model = NoteModel.fromJson(
//                       snapshot.data!.docs[index].data());
//                   return ListTile(
//                     title: Text('${model.title}'),
//                     subtitle: Text('${model.body}'),
//                   );
//                 });
//           }
//           return Container();
//         },
//       ),
