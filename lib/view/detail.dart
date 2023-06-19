import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_project/model/detail.dart';
import 'profile.dart';

class DetailedHotelScreen extends StatefulWidget {
  DetailedHotelScreen({
    super.key,
    required this.id,
  });

  String id;
  @override
  State<DetailedHotelScreen> createState() => _DetailedHotelScreenState();
}

class _DetailedHotelScreenState extends State<DetailedHotelScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.id.trim().replaceAll(' ', ''))
        .collection("hotels")
        .doc(widget.id.trim().replaceAll(' ', ''))
        .collection('details')
        .snapshots();
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
                stream: fireStore,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DetailScreen hotel = DetailScreen.fromMap(
                            snapshot.data!.docs[index].data());

                        return Expanded(
                          child: Column(children: [
                            SizedBox(
                                width: screenWidth * 0.8,
                                height: clientHeight * 0.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    hotel.image_url,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            SizedBox(
                                width: screenWidth * 0.6,
                                height: clientHeight * 0.12,
                                child: Text(
                                  hotel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                                width: screenWidth * 0.6,
                                height: clientHeight * 0.12,
                                child: Text(
                                  hotel.description,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ]),
                        );
                      },
                    );
                  } else {
                    return Text(
                        'Something went wrong! Lenght:${snapshot.data!.docs.length}');
                  }
                })));
  }
}


















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../model/hotel.dart';
// import 'profile.dart';

// class ShanghaiHotelScreen extends StatefulWidget {
//   ShanghaiHotelScreen({super.key, required this.id});
//   String id;
//   @override
//   State<ShanghaiHotelScreen> createState() => _ShanghaiHotelScreenState();
// }

// class _ShanghaiHotelScreenState extends State<ShanghaiHotelScreen> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   //if we can use final instead of CollectionRefrence then use snapshot after .collection
//   //otherwise use in Strembuilder stream property userRef.snapshot
//   late String id;
//   @override
//   void initState() {
//     super.initState();
//     id = widget.id;
//   }

//   @override
//   void didChangeDependencies() async {
//     // print(widget.data.id);
//     super.didChangeDependencies();
//     var document = id;
//     print(document);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('build');
//     final fireStore = FirebaseFirestore.instance
//         .collection("users")
//         .doc(widget.id.trim())
//         .collection("hotels");
//     screenSize = MediaQuery.of(context).size;
//     screenWidth = screenSize.width;
//     screenHeight = screenSize.height;
//     clientHeight =
//         screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white38,
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white38.withOpacity(0.5),
//           title: const Text('ShanghaiHotels'),
//         ),
//         body: StreamBuilder(
//           stream: fireStore.snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.data!.docs.isNotEmpty) {
//               print(snapshot.hasData);
//               print(snapshot.data!.docs.length);
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var data = snapshot.data!.docs[index].data();
//                   print(
//                       '????????????????????${snapshot.data!.docs[index].data()}');

//                   //we can use the refrence data in formmap or direct copy this code of refrence data use
//                   //snapshot.data!.docs[index].data

//                   Hotel hotel =
//                       Hotel.fromMap(snapshot.data!.docs[index].data());
//                   print('@@@@@@@@@@@@@@@@@@@@@@@@2$hotel');
//                   // Map<String, dynamic> data =
//                   //     snapshot.data!.docs[index].data() as Map<String, dynamic>;
//                   // Hotel hotel = Hotel.fromMap(data);y
//                   return Column(children: [
//                     SizedBox(
//                         width: screenWidth * 0.8,
//                         height: clientHeight * 0.3,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.network(
//                             hotel.image_url,
//                             fit: BoxFit.cover,
//                           ),
//                         )),
//                     SizedBox(
//                         width: screenWidth * 0.6,
//                         height: clientHeight * 0.12,
//                         child: Text(
//                           data['name'],
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         )),
//                   ]);
//                 },
//               );
//             } else {
//               return Text(
//                   'Something went wrong! Lenght:${snapshot.data!.docs.length}');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }