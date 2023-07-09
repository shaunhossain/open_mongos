import 'package:flutter/material.dart';
import 'package:open_mongos/data_update_view.dart';
import 'package:open_mongos/db_helper/mongodb.dart';
import 'package:open_mongos/model/user_model.dart';
import 'package:open_mongos/widget/user_view_card.dart';

class DisplayDataView extends StatefulWidget {
  const DisplayDataView({super.key});

  @override
  State<DisplayDataView> createState() => _DisplayDataViewState();
}

class _DisplayDataViewState extends State<DisplayDataView> {

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataUpdateView(data: UserModel.fromJson(snapshot.data[index])),),
                          );
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
