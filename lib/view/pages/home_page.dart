import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg_image/flutter_svg_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sport_app_with_api/provider/auth/sing_up_provider.dart';
import 'package:sport_app_with_api/provider/home/home_provider.dart';
import 'package:sport_app_with_api/view/pages/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String userName = '';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getUserInfo();
  // }

  // void _getUserInfo() async {
  //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(SingUpProvider().userIDs)
  //       .get();
  //   setState(() {
  //     userName = documentSnapshot['name'] ?? '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(40, 51, 63, 1),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(123, 97, 255, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: context.read<HomeProvider>().usersStream,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('SERVER ERROR'),
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
                              child: Text("Malumot topilmadi!"),
                            );
                          } else {
                            return Row(
                              children: [
                                const Icon(
                                  Icons.menu,
                                  color: Color.fromRGBO(205, 205, 205, 1),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://source.unsplash.com/random/5'),
                                    radius: 24),
                                const SizedBox(
                                  width: 13,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "HELLO",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Text(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * 0.360,
                                ),
                                Image.asset(
                                  'assets/icon1.png',
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Image.asset('assets/sms.png'),
                              ],
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.026,
                    ),
                    StreamBuilder(
                      stream: context.read<HomeProvider>().statusStream,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
                              child: Text("Ma'lumot Topilmadi"),
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${data[0]['result'].toString()} / ",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(205, 205, 205, 1)),
                                    ),
                                    Text(
                                      data[0]['steps'].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.15,
                                    ),
                                    const Text(
                                      'Level 5',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Image.network(data[0]['img'].toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    LinearPercentIndicator(
                                      width: size.width * 0.76,
                                      lineHeight: size.height * 0.0085,
                                      percent: 0.8,
                                      progressColor:
                                          const Color.fromRGBO(85, 203, 116, 1),
                                      barRadius: const Radius.circular(20),
                                      animation: true,
                                      animationDuration: 2500,
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.95,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.17)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color.fromRGBO(
                                                    123, 97, 255, 1),
                                                image: DecorationImage(
                                                    image: NetworkImage(data[0]
                                                            ['img2']
                                                        .toString()),
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data[0]['created_at']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Today',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          67, 196, 101, 1),
                                                    ),
                                                  ),
                                                  const Text(
                                                    '01 : 09 : 44 ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.35,
                                            ),
                                            CircularPercentIndicator(
                                              radius: 34.0,
                                              lineWidth: 5.0,
                                              percent: 0.4,
                                              reverse: true,
                                              center: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/ic_steps.png'),
                                                  SizedBox(
                                                    width: size.width * 0.01,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        data[0]["circular_steps1"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        data[0]["circular_steps2"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              67, 196, 101, 1),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              progressColor:
                                                  const Color.fromRGBO(
                                                      241, 73, 133, 1),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width * 0.435,
                                      height: size.height * 0.15,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.17)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            data[0]["step_count"].toString(),
                                            style: const TextStyle(
                                                fontSize: 48,
                                                color: Colors.white),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/step.png'),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              const Text(
                                                'Steps',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.435,
                                      height: size.height * 0.15,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.17)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            data[0]["earned_point"].toString(),
                                            style: const TextStyle(
                                                fontSize: 48,
                                                color: Colors.white),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/coin.png'),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              const Text(
                                                'Earned Points',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.002,
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color.fromRGBO(255, 255, 255, 0.17),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(130, 175, 255, 1),
                                Color.fromRGBO(241, 73, 133, 1),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.035,
                              ),
                              const Text(
                                'Share & Get',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              const Text(
                                """Get 2x point for every steps, 
only valid for today""",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.002,
                              ),
                              Image.asset(
                                'assets/Twitter.png',
                                cacheHeight: 111,
                                cacheWidth: 194,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 194,
                            height: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: SvgImage.asset('assets/share.svg'),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(16)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.001,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      final Stream<QuerySnapshot> historyStream =
                          FirebaseFirestore.instance
                              .collection("history")
                              .orderBy("created_at")
                              .snapshots();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryPage(
                              stream: historyStream,
                            ),
                          ));
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: context.read<HomeProvider>().historyStream,
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
                        child: Text("Mahsulot mavjud emas"),
                      );
                    } else {
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data[index]['pt'].toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(
                                                          241, 73, 133, 1),
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                Image.asset('assets/nuqta.png'),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                Text(
                                                  data[index]['kcal']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
