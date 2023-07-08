import 'package:flutter/material.dart';
import 'package:open_mongos/db_helper/mongodb.dart';
import 'package:open_mongos/model/user_model.dart';
import 'package:open_mongos/widget/user_view_card.dart';

class DisplayDataView extends StatefulWidget {
  const DisplayDataView({super.key});

  @override
  State<DisplayDataView> createState() => _DisplayDataViewState();
}

class _DisplayDataViewState extends State<DisplayDataView> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var addressController = TextEditingController();

  Future<void> _updateData(
      {required var id,
      required String firstName,
      required String lastName,
      required String address}) async {
    var data = UserModel(
        id: id, firstName: firstName, lastName: lastName, address: address);
    var result = await MongoDatabase.update(data: data).whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Update id: ${id.$oid}")));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Display Data"),
      ),
      body: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                return ListView.builder(
                    itemCount: totalData,
                    itemBuilder: (context, index) {
                      return UserViewCard(
                        data: UserModel.fromJson(snapshot.data[index]),
                        onEditPress: () {
                          setState(() {
                            firstNameController.text =
                                UserModel.fromJson(snapshot.data[index])
                                    .firstName;
                            lastNameController.text =
                                UserModel.fromJson(snapshot.data[index])
                                    .lastName;
                            addressController.text =
                                UserModel.fromJson(snapshot.data[index])
                                    .address;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minHeight: 300,
                                      maxHeight: 450,
                                    ),
                                    child: Padding(
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
                                                      id: UserModel.fromJson(
                                                              snapshot
                                                                  .data[index])
                                                          .id,
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
                                  ),
                                );
                              });
                        },
                      );
                    });
              }
              return const Center(
                child: Text("No Data Available"),
              );
            }
          }),
    ));
  }
}
