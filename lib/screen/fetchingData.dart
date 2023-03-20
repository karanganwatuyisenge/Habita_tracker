import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchData extends StatefulWidget{
  FetchData({Key? key}):  super(key: key);
  
  @override
  State<FetchData> createState() => _FetchData();
}

class _FetchData extends State<FetchData>{
  final CollectionReference _habits=FirebaseFirestore.instance.collection('habits');
  final TextEditingController _goalNameController =TextEditingController();
  final TextEditingController _habitNameController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot !=null){
    _goalNameController.text=documentSnapshot['goalName'];
    _habitNameController.text=documentSnapshot['habitName'].toString();
  }
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
                controller: _goalNameController,
                decoration: InputDecoration(labelText: 'Goal Name'),
              ),
              TextField(
                controller: _habitNameController,
                decoration: InputDecoration(labelText: 'Habit Name'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Update'),
                  onPressed: () async{
                  final String goalName=_goalNameController.text;
                  final String habitName=_habitNameController.text;
                  await _habits.doc(documentSnapshot!.id)
                      .update({"goalName":goalName , "habitName":habitName});
                  _goalNameController.text='';
                  _habitNameController.text='';
                  },
                  )
            ],
          ),
        );
      });
  }

  Future<void> _delete(String habitsId) async{
    await _habits.doc(habitsId).delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:Text('Yo have successfully deleted a habit') ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _habits.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot=
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['goalName']),
                    subtitle: Text(documentSnapshot['habitName'].toString()),
                    trailing: SizedBox(width:100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                            onPressed: () =>
                          _update(documentSnapshot),
                           ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _delete(documentSnapshot.id),
                        ),
                      ],
                    ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  }