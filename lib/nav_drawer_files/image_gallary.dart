import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late FirebaseStorage firebaseStorage;

  List<String> lstImgUrl = [];
  String pickedImgUrl = '';
  File? pickedImageFile;
  String profilepicsUrl = '';

  @override
  void initState() {
    super.initState();

    firebaseStorage = FirebaseStorage.instance;
    /*FirebaseFirestore.instance
        .collection('recipes')
        .get()
        .then((value) {
      profilepicsUrl = value.('profilepics');
      setState(() {});
    });*/

    var storageRef = firebaseStorage.ref();
    getImgUrl(storageRef);
    // var imgRef = storageRef.child('images/menus.png');
    // getImgUrl(imgRef);
    // var imgRef2 = storageRef.child('images/Dabeli.png');
    // getImgUrl(imgRef2);
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
        appBar: AppBar(
          title: Text('Storage Example'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  // imagePicker
                  var imgFromGallery = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (imgFromGallery != null) {
                    ///pickedImageFile = File(imgFromGallery.path); // this line is used for picked image from gallery
                    var croppedFile = await ImageCropper().cropImage(
                      sourcePath: imgFromGallery.path,
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
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
                              width: 480, height: 480, type: 'circle'),
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
                          : null),
                ),
              ),
              Text(
                'My Profile',
                style: TextStyle(fontSize: 21),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (pickedImageFile != null) {
                      var currTime = DateTime.now().microsecondsSinceEpoch;
                      var uploadRef = firebaseStorage
                          .ref()
                          .child('images/profilepic/img_$currTime.jpg');
                      try {
                        uploadRef.putFile(pickedImageFile!).then((p0) async {
                          print('Uploaded');

                          /// firestore update url

                          var downloadUrl = await p0.ref.getDownloadURL();
                          FirebaseFirestore.instance
                              .collection('recipes')
                              .add({
                            'itemImage': downloadUrl,
                            'currentProfile': true
                          }).then((value) => print('Profile picture updated'));


                        });
                      } catch (e) {
                        print('Error : ${e.toString()}');
                      }
                    }
                  },
                  child: Text('Update Profile')),
              Expanded(child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
                builder: (_,snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context,index) => Image.network(snapshot.data!.docs[index].data()['itemImage'])
                    );
                  }
                  return Container();
                },
              ))
            ],
          ),
        ));
  }
}

//lstImgUrl.isNotEmpty
//             ? ListView.builder(
//
//                 itemCount: lstImgUrl.length,
//                 itemBuilder: (_, index) {
//                   return Image.network(lstImgUrl[index],height: 100,width: 100,);
//                 })
//             : Container(
//                 color: Colors.cyan,
//               )
