import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:open_mongos/db_helper/mongodb.dart';
import 'package:open_mongos/display_data_view.dart';
import 'package:open_mongos/model/user_model.dart';

class DataInsertView extends StatefulWidget {
  const DataInsertView({super.key});

  @override
  State<DataInsertView> createState() => _DataInsertViewState();
}

class _DataInsertViewState extends State<DataInsertView> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var addressController = TextEditingController();

  void _faker() {
    setState(() {
      firstNameController.text = faker.person.firstName();
      lastNameController.text = faker.person.lastName();
      addressController.text =
          "${faker.address.streetName()}\n${faker.address.streetAddress()}";
    });
  }

  void _clearAll(){
    firstNameController.text = "";
    lastNameController.text = "";
    addressController.text = "";
  }

  Future<void> _insertDat(
      {required String firstName,
      required String lastName,
      required String address}) async {
    var id = M.ObjectId();
    var data = UserModel(
        id: id, firstName: firstName, lastName: lastName, address: address);
    var result = await MongoDatabase.insert(data: data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted id: ${id.$oid}")));
    _clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Insert data"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DisplayDataView()),
            );
          }, child: const Text("Display Data"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Insert Date",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(label: Text("First Name")),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(label: Text("Last Name")),
            ),
            TextField(
              controller: addressController,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(label: Text("Address")),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _faker();
                    },
                    child: const Text("Generate data")),
                ElevatedButton(
                  onPressed: () {
                    _insertDat(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        address: addressController.text);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent)),
                  child: const Text(
                    "Insert data",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
