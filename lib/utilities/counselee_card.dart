import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:flutter/material.dart';

class CounseleeCard extends StatelessWidget {

  // Parameters to be passed to Counselee card
  final String counseleeImage;
  final String counseleeReg;
  final String counseleeName;
  final String counseleeCourse;
  final String counseleePhone;
  final String counseleeEmail;
  final String counseleeID;

  const CounseleeCard({
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
  Widget build(BuildContext context){
    final String uid = counseleeID;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,0,0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            //Picture of the counselee 
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                counseleeImage,
                height: 50,
              ),
            ),
            const SizedBox(height: 5,),
      
            // counselee's Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow,),
                Text(counseleeReg),
              ],
            ),
            const SizedBox(height: 5,),
      
            // counselees Name
            Text(
              counseleeName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      
            const SizedBox(height: 5,),
      
            Text(counseleeCourse),
      
            const SizedBox(height: 5,),
      
            //Read more button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounseleeProfile(counseleeID: this.counseleeID,);
                  
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.deepPurple,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Read More', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}