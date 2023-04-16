import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryPage extends StatelessWidget {
  Stream<QuerySnapshot> stream;
  HistoryPage({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 60, 80, 1),
      appBar: AppBar(
        title: const Text("All History"),
        actions: [
          SizedBox(
            width: size.width * 0.2,
          ),
          Image.asset(
            'assets/icon1.png',
            color: Colors.white,
          ),
          Image.asset('assets/sms.png'),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              width: size.width * 0.95,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(255, 255, 255, 0.17)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/timer.png'),
                      const Text(
                        "18,3 h",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "Time",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                        "|",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromRGBO(255, 255, 255, 0.17),
                            fontWeight: FontWeight.w700),
                      ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/routing.png'),
                      const Text(
                        "48,7 KM",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "Distance",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                   const Text(
                        "|",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromRGBO(255, 255, 255, 0.17),
                            fontWeight: FontWeight.w700),
                      ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/heart-circle.png'),
                      const Text(
                        "123 BPM",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "Heart Beat",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder:
                  (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("SERVER ERROR"),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Map<String, dynamic>> data = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    data.add(document.data() as Map<String, dynamic>);
                  }).toList();
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("HALI MAHSULOTLAR QO'SHILMAGAN"),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Container(
                              width: size.width * 0.935,
                              height: size.height * 0.09,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  // color: const Color.fromRGBO(255, 255, 255, 0.17),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromRGBO(255, 255, 255, 0),
                                        Color.fromRGBO(255, 255, 255, 0.09),
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]['date'].toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  123, 97, 255, 1),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.005,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index]['pt'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      241, 73, 133, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Image.asset('assets/nuqta.png'),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                              data[index]['km'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Image.asset('assets/nuqta.png'),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                              data[index]['kcal'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.17,
                                    ),
                                    Text(
                                      data[index]['steps'].toString(),
                                      style: const TextStyle(
                                          fontSize: 21,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Text(
                                      ' Steps',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: data.length,
                      ),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
