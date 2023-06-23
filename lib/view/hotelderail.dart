import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_project/view/detail.dart';
import '../model/hotel.dart';
import 'profile.dart';

class ShanghaiHotelScreen extends StatefulWidget {
  ShanghaiHotelScreen({super.key, required this.id});
  String id;
  @override
  State<ShanghaiHotelScreen> createState() => _ShanghaiHotelScreenState();
}

class _ShanghaiHotelScreenState extends State<ShanghaiHotelScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //if we can use final instead of CollectionRefrence then use snapshot after .collection
  //otherwise use in Strembuilder stream property userRef.snapshot

  @override
  Widget build(BuildContext context) {
    String id = widget.id.trim();
    final fireStore = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("hotels");
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    clientHeight =
        screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white38,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white38.withOpacity(0.5),
          title: const Text('ShanghaiHotels'),
        ),
        body: StreamBuilder(
          stream: fireStore.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data();

                  //we can use the refrence data in formmap or direct copy this code of refrence data use
                  //snapshot.data!.docs[index].data

                  Hotel hotel =
                      Hotel.fromMap(snapshot.data!.docs[index].data());

                  // Map<String, dynamic> data =
                  //     snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  // Hotel hotel = Hotel.fromMap(data);y
                  return Column(children: [
                    SizedBox(
                        width: screenWidth * 0.8,
                        height: clientHeight * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailedHotelScreen(
                                  firstId: id, secondId: hotel.id),
                            )),
                            child: Image.network(
                              hotel.image_url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    SizedBox(
                        width: screenWidth * 0.6,
                        height: clientHeight * 0.12,
                        child: Text(
                          hotel.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ]);
                },
              );
            } else {
              return Text(
                  'Something went wrong! Lenght:${snapshot.data!.docs.length}');
            }
          },
        ),
      ),
    );
  }
}
