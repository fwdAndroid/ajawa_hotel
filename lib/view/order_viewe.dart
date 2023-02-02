import 'package:ajawa_hotel/widgets/input_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderView extends StatefulWidget {
  OrderView({Key? key, required this.data}) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  OrderViewState createState() => OrderViewState();
}

class OrderViewState extends State<OrderView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.data.id);
    final FirebaseAuth _auth = FirebaseAuth.instance;

// ${widget.data.get('uid')}
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Go Back",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 500,
              width: 509.55,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      height: 100,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text('Order ID:  ${widget.data.get("uuid")}'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                          'Order Detail:  ${widget.data.get("customerMenuDetail")}'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text('Status:  ${widget.data.get("Status")}'),
                    ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 2),
                    //   child: Center(
                    //     child: ElevatedButton(
                    //       onPressed: () async {
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           backgroundColor: Colors.red,
                    //           duration: Duration(seconds: 5),
                    //           content: Text(
                    //             "${widget.data.get("name")} profile is deleted successfully",
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ));
                    //         await _auth.currentUser!.delete();

                    //         await FirebaseFirestore.instance
                    //             .collection("business")
                    //             .doc("B65wAe8fJbPQ38o9tEKVUBaM62N2")
                    //             .delete();
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (builder) => SideDrawer()));
                    //       },
                    //       child: Text("Delete"),
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.red,
                    //           fixedSize:
                    //               Size(MediaQuery.of(context).size.width, 50)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
