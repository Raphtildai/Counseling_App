import 'package:careapp/models/database_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Registering user with email and password
  Future createUser (String name, String email, String password) async{
    try{
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      User? user = result.user;
      await DatabaseManager().createUserData(name, 'male', email, user!.uid);
      return user;
    }catch(e){
      print(e.toString());
    }
  }

  // Registering new Counselor
  Future createNewCounselor(String fname, String lname, String email, int pnumber, String password, String about, String counselorID, String profession, int rating) async{
    try{
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      User? user = result.user;
      await DatabaseManager().createNewCounselor(fname, lname, email, pnumber, password, about, counselorID, profession, rating, user!.uid);
      return user;
    }catch(e){
      print(e.toString());
    }    
  }

  // Registering new counselee
  Future createNewCounselee(String fname, String lname, String email, int pnumber, String password, String about, String regnumber, int age, String school, String course, int year_of_study) async {
    try{
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      User? user = result.user;
      await DatabaseManager().createNewCounselee(fname, lname, email, pnumber, password, about, regnumber, age, school, course, year_of_study, user!.uid);
      return user;
    }catch(e){
      print(e.toString());
    }    
  }

  // Logging in
  Future loginUser(String email, String password) async {
    try{
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password,  
      );
      return result.user;
    }catch(e){
      print(e.toString());
    }
  }

  // Logging Out
  Future signOut() async {
    try{
      return _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}