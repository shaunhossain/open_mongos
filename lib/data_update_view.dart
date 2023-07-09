import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:open_mongos/db_helper/mongodb.dart';
import 'package:open_mongos/display_data_view.dart';
import 'package:open_mongos/model/user_model.dart';

class DataUpdateView extends StatefulWidget {
  const DataUpdateView({super.key, required this.data});
  final UserModel data;

  @override
  State<DataUpdateView> createState() => _DataUpdateViewState();
}

class _DataUpdateViewState extends State<DataUpdateView> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void initState() {
    setState(() {
      firstNameController.text = widget.data.firstName;
      lastNameController.text = widget.data.lastName;
      addressController.text = widget.data.address;
    });
    super.initState();
  }

  void _clearAll(){
    firstNameController.text = "";
    lastNameController.text = "";
    addressController.text = "";
  }

  Future<void> _updateData(
      {required var id,
        required String firstName,
        required String lastName,
        required String address}) async {
    var data = UserModel(
        id: id, firstName: firstName, lastName: lastName, address: address);
    await MongoDatabase.update(data: data).whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Update id: ${id.$oid}")));
    _clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Update data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Update Date",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                  label: Text("First Name")),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                  label: Text("Last Name")),
            ),
            TextField(
              controller: addressController,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(
                  label: Text("Address")),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateData(
                        id: widget.data.id,
                        firstName:
                        firstNameController
                            .text,
                        lastName:
                        lastNameController
                            .text,
                        address: addressController
                            .text);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty
                          .all(Colors
                          .blueAccent)),
                  child: const Text(
                    "Update data",
                    style: TextStyle(
                        color: Colors.white),
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
