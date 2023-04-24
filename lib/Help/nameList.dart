import 'package:flutter/material.dart';

class NameList extends StatefulWidget {
  const NameList({Key? key, required List<String> names}) : super(key: key);

  @override
  State<NameList> createState() => _NameListState();
}

class _NameListState extends State<NameList> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final List<String> _names = [];

  void _saveName() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _names.add(_nameController.text);
        _nameController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
    }
  }

  void _deleteName(int index) {
    setState(() {
      final deletedName = _names.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted $deletedName')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Name List')),
      body: Column(
        children: [
          Expanded(
            child: _names.isEmpty
                ? Center(child: Text('No data'))
                : ListView.builder(
              itemCount: _names.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_names[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteName(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Save Here'),
            onPressed: _saveName,
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   testWidgets('MyWidget displays correct text', (WidgetTester tester) async {
//     await tester.pumpWidget(MyWidget(text: 'Hello, world!'));
//     expect(find.text('Hello, world!'), findsOneWidget);
//   });
// }
// class MyWidget extends StatelessWidget {
//   final String text;
//
//   MyWidget({required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text(text),
//         ),
//       ),
//     );
//   }
// }
