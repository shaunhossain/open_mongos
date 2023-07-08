import 'package:flutter/material.dart';
import 'package:open_mongos/model/user_model.dart';

class UserViewCard extends StatelessWidget {
  const UserViewCard({super.key, required this.data, required this.onEditPress});
  final UserModel data;
  final Function() onEditPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${data.firstName} ${data.lastName}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("address: ${data.address}"),
                ],
              ),
              IconButton(onPressed: onEditPress, icon: const Icon(Icons.create))
            ],
          ),
        ),
      ),
    );
  }
}
