import 'package:careapp/services/get_counselee_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetPendingSessionApprovalData extends StatefulWidget {
const GetPendingSessionApprovalData({ Key? key,}) : super(key: key);

  @override
  State<GetPendingSessionApprovalData> createState() => _GetPendingSessionApprovalDataState();
}

class _GetPendingSessionApprovalDataState extends State<GetPendingSessionApprovalData> {
static const titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

static const textStyle = TextStyle(
  fontSize: 14,
);

  // creating a list of document IDs
  List <String> docIDs = [];

  List<String> counseleeID = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: "Pending").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
    }));
  }

  @override
  Widget build(BuildContext context){
    // Get counselee document ID
    Future getCounseleeID(regnumber) async {
      await FirebaseFirestore.instance.collection('users').where('regnumber', isEqualTo: regnumber).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          // Adding that document to the list     
          
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          counseleeID.add(document.reference.id); 
          return GetCounseleeData(documentIds: document.reference.id);
        }));  
        })
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending approval requests'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdocIDs(),
              builder: ((context, snapshot){
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    // Retrieving the approval requests
                    CollectionReference counselee = FirebaseFirestore.instance.collection('bookings');
                    CollectionReference counseleeId = FirebaseFirestore.instance.collection('users');
                    return FutureBuilder<DocumentSnapshot>(
                    future: counselee.doc(docIDs[index]).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          
                        // Error handling conditions
                        if(snapshot.hasError){
                          return const Center(child: Text('Something went Wrong'));
                        }
                        if(snapshot.hasData && !snapshot.data!.exists){
                          return const Center(child: Text('Sorry this request does not exist'),);
                        }
          
                        // Outputting the data to the user
                        if(snapshot.connectionState == ConnectionState.done){
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          Text('${data['time_booked']}');

                        }
                        return Center(child: const CircularProgressIndicator());
                      }
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}