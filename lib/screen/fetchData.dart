import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  FetchData({Key? key}) : super(key: key);

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final CollectionReference _habits=FirebaseFirestore.instance.collection('habits');
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user=FirebaseAuth.instance.currentUser!;
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _habitTypeController = TextEditingController();
  final TextEditingController _habitFrequencyController = TextEditingController();


Future<void> _updateData(String habitsId, habitName,habitType,habitFrequency) async{
_habitNameController.text=habitName;
_habitTypeController.text=habitType;
_habitFrequencyController.text=habitFrequency;

  await showModalBottomSheet(
      isScrollControlled:true,
      context: context,
      builder: (BuildContext cont){
        return Padding(
          padding: EdgeInsets.only(
              top:20,
              left: 20,right: 20,
              bottom: MediaQuery.of(cont).viewInsets.bottom +20
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _habitNameController,
                decoration: InputDecoration(labelText: 'Habit Name'),
              ),
              TextField(
                controller: _habitTypeController,
                decoration: InputDecoration(labelText: 'Habit Type'),
              ),
              TextField(
                controller: _habitFrequencyController,
                decoration: InputDecoration(labelText: 'Habit Frequency'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () async{
                  await FirebaseFirestore.instance.collection('users')
                      .doc(user.uid)
                      .collection('habits')
                      .doc(habitsId)
                      .update({
                    'habitName': _habitNameController.text,
                    'habitType':_habitTypeController.text,
                    'habitFrequency':_habitFrequencyController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Successfully')));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FetchData())
                  );
                },
              )
            ],
          ),
        );
      });
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => FetchData())
  );

}


  Future<void> _delete(String habitsId) async{
    FirebaseFirestore.instance.collection('users')
        .doc(user.uid).collection('habits').doc(habitsId).delete();
    print('Data deleted');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(user.uid).collection('habits').snapshots(),
        builder: (context, streamSnapshot){
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }if(streamSnapshot.hasError){
            print(streamSnapshot.error);
            return Center(child: Text("There is an error: ${streamSnapshot.error}"));
          }
          else if(streamSnapshot.hasData){
            var habits=streamSnapshot.data!.docs;

            return habits.isEmpty?const Center(child: Text("No habits yet")): ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['habitName']),
                  trailing:SizedBox(width: 100,
                    child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          _updateData(
                              documentSnapshot.id,
                              documentSnapshot["habitName"],
                              documentSnapshot["habitType"],
                              documentSnapshot["habitFrequency"],
                          ),
                    ),
                    IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _delete(documentSnapshot.id),)
                  ],
                  ),
                  ),

                ),
                );
    });
          }
          else{
          return const CircularProgressIndicator();
          }

        },
      ),
    );
  }
}



