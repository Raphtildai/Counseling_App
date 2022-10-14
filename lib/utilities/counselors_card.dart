// ignore_for_file: use_key_in_widget_constructors

import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CounselorCard extends StatefulWidget {
  // parameters to be passed to the Counselor's card
  final String counselorImage;
  final String counselorRating;
  final String counselorName;
  final String counselorProfession;
  final String counselorPhone;
  final String counselorEmail;
  final String counselorID;
  String imageUrl = "";

  // constructor

  CounselorCard({
    required this.counselorImage,
    required this.counselorRating,
    required this.counselorName,
    required this.counselorProfession,
    required this.counselorPhone,
    required this.counselorEmail,
    required this.counselorID,
  });

  @override
  State<CounselorCard> createState() => _CounselorCardState();
}

class _CounselorCardState extends State<CounselorCard> {
  // Function to get the user image
  Future getImage(String userId) async {
    try {
      Reference ref = await FirebaseStorage.instance
          .ref()
          .child("${widget.counselorID}.jpg");
      if (ref != true) {
        // Getting the image url
        ref.getDownloadURL().then((value) {
          setState(() {
            widget.imageUrl = value;
          });
        });
      } else {
        return null;
      }
    } catch (e) {
      return ErrorPage('$e');
    }
  }

  @override
  void initState() {
    getImage(widget.counselorID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = widget.counselorID;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            //Picture of the Counselor
            ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: widget.imageUrl != ""
                    ? Image.network(
                        widget.imageUrl,
                        height: 100,
                        width: 100,
                      )
                    : const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.black,
                      )),
            const SizedBox(
              height: 5,
            ),

            // Counselor's Rating
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(widget.counselorRating),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            // Counselors Name
            Text(
              widget.counselorName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(widget.counselorProfession),

            const SizedBox(
              height: 5,
            ),

            //Read more button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CounselorProfile(
                      counselorID: this.widget.counselorID,
                    );
                  },
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.deepPurple,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Read More',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}