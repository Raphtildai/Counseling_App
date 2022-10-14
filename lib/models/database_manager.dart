import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseManager {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  // Creating User data in the firestore database
  Future<void> createUserData(String name, String gender, String email, uid) async{
    return await users.doc(uid).set({
      'name': name,
      'gender': gender,
      'email': email,
      'role': 'counselee',
    });
  }

  // Adding new counselor
  Future<void> createNewCounselor(String fname, String lname, String email, int pnumber, String password, String about, String counselorID, String profession, int rating, uid) async {
    return await users.doc(uid).set({
      // We pass the above parameters inform of a map
      'firstname': fname,
      'lastname': lname,
      'email': email,
      'pnumber': pnumber,
      'password': password,
      'about': about,
      'counselorID': counselorID,
      'profession': profession,
      'rating': rating,
      'regnumber': counselorID,
      'role': "counselor",
      'school': "Graduated",
      'Course': "Bsc. Psychology",
      'date_CounselorRegistered': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),      
    });
  }

  // Function to create new counselee
  Future<void> createNewCounselee(String fname, String lname, String email, int pnumber, String password, String about, String regnumber, int age, String school, String course, int year_of_study, uid) async {
    return await users.doc(uid).set({
    // We pass the above parameters inform of a map
    'firstname': fname,
    'lastname': lname,
    'email': email,
    'pnumber': pnumber,
    'password': password,
    'about': about,
    'regnumber': regnumber,
    'age': age,
    'school': school,
    'Course': course,
    'year_of_study': year_of_study,
    'role': "counselee",
    'date_CounseleeRegistered': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),      
    });
  }

  // Function to update user data
  Future updateUserData(String fname, String lname, int pnumber, String about, uid) async {
    return await users.doc(uid).update({
      'firstname': fname,
      'lastname': lname,
      'pnumber': pnumber,
      'about': about,
    });
  }

  // Fetching all users data
  Future getUserData() async {
    List itemsList = [];
    try {
      await users.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) { 
          // We get the list of items inside our collection
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Fetching Specified user record
  Future getSpecificUserData(String user_id) async {
    try {
      if(user_id != null){
        final userData = await users.doc(user_id);
        return userData;
      }
    } catch (e) {
      print(e.toString());
      return null; 
    }
  }

    // Fetching the bookings data
  Future getBookingsData() async {
    List bookingList = [];
    try {
      await bookings.orderBy('approval').get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) { 
          // We get the list of items inside our collection
          bookingList.add(element.data());
        });
      });
      return bookingList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}