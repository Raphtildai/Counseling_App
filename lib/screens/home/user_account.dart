// ignore_for_file: camel_case_types, prefer_final_fields, annotate_overrides, unused_local_variable

import 'package:careapp/models/database_manager.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String imageUrl = "";
  File? image;

  final _fnamecontroller = TextEditingController();
  final _lnamecontroller = TextEditingController();
  final _pnumbercontroller = TextEditingController();
  final _aboutcontroller = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser!.uid;

  // This function updates the user data once we update it
  updateUserData(
      String fname, String lname, int pnumber, String about, userId) async {
    await DatabaseManager()
        .updateUserData(fname, lname, pnumber, about, userId);
  }

  // Function to get the user image
  Future getImage(String userId) async {
    try {
      Reference ref = await FirebaseStorage.instance.ref().child("$userId.jpg");
      if (ref != true) {
        // Getting the image url
        ref.getDownloadURL().then((value) {
          print(value);
          setState(() {
            imageUrl = value;
          });
        });
      } else {
        setState(() {
          image == null;
        });
        return null;
      }
    } catch (e) {
      ErrorPage('Failed to pick image: $e');
    }
  }

  // Function to upload the image to firebase
  void pickUploadImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75,
      );

      if (image == null) return;
      final imageTemporary =
          File(image.path); //temporarily stores our image in local cache
      // final imagePermanent = await saveImagePermanently(image.path);//saves the image permanently
      setState(() {
        this.image = imageTemporary;
        // this.image = imagePermanent;
      });

      // Initializing the reference
      Reference ref = FirebaseStorage.instance.ref().child("$userId.jpg");

      // Uploading the image
      await ref.putFile(File(image.path));

      // Getting the image url
      ref.getDownloadURL().then((value) {
        setState(() {
          this.image = imageTemporary;
          imageUrl = value;
        });
      });
    } on PlatformException catch (e) {
      ErrorPage('Failed to pick image: $e');
    }
  }

  // Method to save the image permanently
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final Image = File('${directory.path}/$name');
    return File(imagePath).copy(imagePath);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getImage(userId);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users');
    const headingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    const textStyle = TextStyle(
      fontSize: 14,
    );
    return FutureBuilder<DocumentSnapshot>(
      future: userData.doc(userId).get(), //userData.doc(userId).get()
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Error handling conditions
        if (snapshot.hasError) {
          return const Center(child: Text('Something went Wrong'));
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(
            child: Text('Your Account information could not be found'),
          );
        }
        //Outputting the data to the user if the connection is done
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  '${data['firstname']} ' ' ${data['lastname']}\'s Profile '),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Account profile picture
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Container(
                        // height: MediaQuery.of(context).size.height - 200,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: imageUrl != ""
                                    ? Image.network(imageUrl)
                                    // Image.file(
                                    //   image!,
                                    //   width: 160,
                                    //   height: 160,
                                    //   fit: BoxFit.cover,
                                    // )
                                    // // const Icon(Icons.person, size: 80, color: Colors.white,)
                                    // Image.asset(
                                    //   'assets/raph.PNG',
                                    //   // height: 100,
                                    //   width: MediaQuery.of(context).size.width,
                                    // )
                                    : const Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.black,
                                      )),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                onShowMethod(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.edit,
                                  ),
                                  // const SizedBox(width: 10,),
                                  const Text('Change Account Picture'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Personal Information',
                            style: headingStyle,
                          ),
                          const Text(
                            'This is what others will see on your Counseling profile.',
                            style: textStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Name and basic details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Name
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Name',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['firstname'] + ' ' + data['lastname']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Email address
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['email']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Phone number
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phone Number',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['pnumber']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            //Reg number
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Registration Number',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['regnumber']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // About
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'About',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['about']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Education Details
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Your Education Details',
                            style: headingStyle,
                          ),
                          const Text(
                            'This shows the school and the course you are enrolled at.',
                            style: textStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // School
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'School',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['school']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Course
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Course',
                                  style: headingStyle,
                                ),
                                // const SizedBox(width: 5,),
                                Text(
                                  '${data['Course']}',
                                  style: textStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: GestureDetector(
                        onTap: () {
                          onShowDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Edit Your Profile',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // Return loading to the user
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }

  onShowDialog(context) {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              title: const Text('Edit your profile'),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fnamecontroller,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'First Name field is empty';
                        } else if (text.length < 4 || text.length > 20) {
                          return 'Name is not Valid';
                        } else if (text.contains(RegExp(r'[0-9]'))) {
                          return 'Name Should not Contain numbers';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lnamecontroller,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Last Name field is empty';
                        } else if (text.length < 4 || text.length > 20) {
                          return 'Name is not Valid';
                        } else if (text.contains(RegExp(r'[0-9]'))) {
                          return 'Name Should not Contain numbers';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _aboutcontroller,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: null,
                      decoration: const InputDecoration(hintText: 'About'),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Write Something!!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _pnumbercontroller,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(hintText: 'Phone Number'),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Phone Number field is empty';
                        } else if (!text.contains(RegExp(r'[0-9]'))) {
                          return 'Should Contain numbers';
                        } else if (text.contains(RegExp(r'[A-Z]')) ||
                            text.contains(RegExp(r'[a-z]'))) {
                          return 'Phone no. cannot contain characters';
                        } else if (text
                            .contains(RegExp(r'[!@#$%^&*()_"|:;,.?=~\`-]'))) {
                          return 'Invalid characters';
                        } else if (text.length != 10) {
                          return 'Phone no. Digits should be 10 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitAction(context);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Update'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        });
  }

  // To ;et user choose or take a photo using camera
  onShowMethod(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Take or Choose a picture'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      pickUploadImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: const Text('Camera'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      pickUploadImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: const Text('Gallery'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          );
        });
  }

  // Method to update your profile
  submitAction(context) {
    updateUserData(_fnamecontroller.text, _lnamecontroller.text,
        int.parse(_pnumbercontroller.text), _aboutcontroller.text, userId);
    _fnamecontroller.clear();
    _lnamecontroller.clear();
    _aboutcontroller.clear();
    _pnumbercontroller.clear();
  }
}
