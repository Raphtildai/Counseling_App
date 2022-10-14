import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounseleeCard extends StatefulWidget {
  // Parameters to be passed to Counselee card
  final String counseleeImage;
  final String counseleeReg;
  final String counseleeName;
  final String counseleeCourse;
  final String counseleePhone;
  final String counseleeEmail;
  final String counseleeID;
  String imageUrl = "";

  CounseleeCard({
    super.key,
    required this.counseleeImage,
    required this.counseleeReg,
    required this.counseleeName,
    required this.counseleeCourse,
    required this.counseleeEmail,
    required this.counseleePhone,
    required this.counseleeID,
  });
  @override
  State<CounseleeCard> createState() => _CounseleeCardState();
}

class _CounseleeCardState extends State<CounseleeCard> {

  // Function to get the user image
  Future getImage(String userId) async {
    try {
      Reference ref = await FirebaseStorage.instance
          .ref()
          .child("${widget.counseleeID}.jpg");
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
    getImage(widget.counseleeID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = widget.counseleeID;
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
            // Image.network(widget.imageUrl, height: 50, width: 50,),
            //Picture of the counselee
            ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: widget.imageUrl != ""
                    ? Image.network(widget.imageUrl, height: 100, width: 100,)
                    : const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.black,
                      )
                ),
            const SizedBox(
              height: 5,
            ),

            // counselee's Regnumber
            Row(
              children: [
                const Icon(Icons.numbers),
                Text(widget.counseleeReg),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            // counselees Name
            Text(
              widget.counseleeName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            SizedBox(
                width: 150,
                child: Expanded(child: Text(widget.counseleeCourse))),

            const SizedBox(
              height: 5,
            ),

            //Read more button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CounseleeProfile(
                      counseleeID: this.widget.counseleeID,
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
