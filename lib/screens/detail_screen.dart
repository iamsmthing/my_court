// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final String mydata;
  // ignore: use_key_in_widget_constructors
  const DetailScreen(this.mydata);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Person person = Person();
  @override
  Widget build(BuildContext context) {
    String apiUrl = "http://13.233.93.36/api/?uidai=${widget.mydata}";
    Future<dynamic> getData() async {
      try {
        var res = await http.get(Uri.parse(apiUrl));
        if (res.statusCode == 200) {
          return jsonDecode(res.body);
        } else {
          return Future.error("API get Error");
        }
      } catch (e) {
        return Future.error(e);
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.amberAccent,
      //   centerTitle: true,
      //   title: Text(
      //     // ignore: unnecessary_string_interpolations
      //     'UID:${widget.mydata}',
      //   ),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/images/Picsart_22-03-25_19-03-02-344.jpg'),
                opacity: 0.1),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 45,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "User Details",
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                FutureBuilder<dynamic>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _userDetails(context, snapshot);
                    } else {
                      return Center(
                          child: Text(
                        'No User Data Found',
                        style: TextStyle(fontFamily: 'RobotoMono'),
                      ));
                    }
                  },
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<dynamic>(
                    future: getData(),
                    builder: (context, snapshot) {
                      //print(snapshot.data['data'][0]['id'] == 0);
                      // print(snapshot.data['data'][0]['id'].runtimeType);
                      // print('object');
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              color: Colors.amber,
                              strokeWidth: 5,
                            ),
                          ),
                        );
                      } else {
                        return snapshot.data['affidavits'] == null
                            ? Center(
                                child: Text('No Documents Found'),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data['affidavits'].length,
                                itemBuilder: (context, i) {
                                  final int status =
                                      snapshot.data['affidavits'][i]['status'];
                                  // ignore: unused_element
                                  Text _calRes(var status) {
                                    Text res;
                                    if (status == 0) {
                                      res = Text('Pending');
                                      return res;
                                    } else if (status == 1) {
                                      res = Text('Approved');
                                      return res;
                                    } else {
                                      res = Text('Rejected');
                                    }
                                    return res;
                                  }

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Colors.transparent.withOpacity(0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 8, bottom: 10),
                                          child: Text(
                                            'SN0: ${i + 1}',
                                            style: TextStyle(
                                                fontFamily: 'RobotoMono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "AF.ID:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      '${snapshot.data['affidavits'][i]['id']}'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "NAME:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      '${snapshot.data['affidavits'][i]['name']}'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "CREATION DATE:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      '${snapshot.data['affidavits'][i]['created_at']}'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "STATUS:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: _calRes(status),
                                                  // child: Text(
                                                  //     '${snapshot.data['affidavits'][i]['status']}'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "DOWNLOAD:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.download,
                                                        color: Colors.blue,
                                                      )),
                                                  // child: Text(
                                                  //     '${snapshot.data['affidavits'][i]['url']}'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),

                                        // ListTile(
                                        //   dense: true,
                                        //   title: Text('AF.ID'),
                                        //   subtitle: Text(
                                        //       '${snapshot.data['affidavits'][i]['id']}'),
                                        // ),
                                        // ListTile(
                                        //   title: Text('Name'),
                                        //   subtitle: Text(
                                        //       '${snapshot.data['affidavits'][i]['name']}'),
                                        // ),
                                        // ListTile(
                                        //   title: Text('Creation Date'),
                                        //   subtitle: Text(
                                        //       '${snapshot.data['affidavits'][i]['created_at']}'),
                                        // ),
                                        // ListTile(
                                        //   title: Text('Status'),
                                        //   subtitle: Text(
                                        //       '${snapshot.data['affidavits'][i]['status']}'),
                                        // ),
                                        // ListTile(
                                        //   title: Text('Download'),
                                        //   subtitle: Text(
                                        //       '${snapshot.data['affidavits'][i]['url']}'),
                                        // ),
                                      ],
                                    ),
                                  );
                                });
                        // return ListView(
                        //   scrollDirection: Axis.horizontal,
                        //   children: [
                        //     DataTable(
                        //       columns: [
                        //         DataColumn(
                        //             label: Text('SNO',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold))),
                        //         DataColumn(
                        //             label: Text('AF.ID',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold))),
                        //         DataColumn(
                        //             label: Text('NAME',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold))),
                        //         DataColumn(
                        //             label: Text('CREATION DATE',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold))),
                        //         DataColumn(
                        //             label: Text('STATUS',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold))),
                        //         DataColumn(
                        //             label: Text('DOWNLOAD',
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.bold)))
                        //       ],
                        //       rows: [
                        //         DataRow(cells: [
                        //           DataCell(Text('1')),
                        //           DataCell(Text(
                        //               '${snapshot.data['affidavits'][0]['id']}')),
                        //           DataCell(Text(
                        //               '${snapshot.data['affidavits'][0]['name']}')),
                        //           DataCell(Text(
                        //             '${snapshot.data['affidavits'][0]['created_at']}',
                        //             style: TextStyle(),
                        //           )),
                        //           DataCell(
                        //             Text("Processing"),
                        //           ),
                        //           DataCell(
                        //             Row(
                        //               children: [
                        //                 // Text(
                        //                 //     '${snapshot.data['affidavits'][0]['url']}'),
                        //                 TextButton.icon(
                        //                     onPressed: () {},
                        //                     icon: Icon(Icons.download),
                        //                     label: Text(""))
                        //               ],
                        //             ),
                        //           ),
                        //         ]),
                        //         // DataRow(cells: [
                        //         //   DataCell(Text('2')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][1]['id']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][1]['name']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][1]['created_at']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][1]['status']}')),
                        //         //   DataCell(
                        //         //     Row(
                        //         //       children: [
                        //         //         // Text(
                        //         //         //     '${snapshot.data['affidavits'][1]['url']}'),
                        //         //         TextButton.icon(
                        //         //             onPressed: () {},
                        //         //             icon: Icon(Icons.download),
                        //         //             label: Text(""))
                        //         //       ],
                        //         //     ),
                        //         //   ),
                        //         // ]),
                        //         // DataRow(cells: [
                        //         //   DataCell(Text('3')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][2]['id']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][2]['name']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][2]['created_at']}')),
                        //         //   DataCell(Text(
                        //         //       '${snapshot.data['affidavits'][2]['status']}')),
                        //         //   DataCell(
                        //         //     Row(
                        //         //       children: [
                        //         //         // Text(
                        //         //         //     '${snapshot.data['affidavits'][2]['url']}'),
                        //         //         TextButton.icon(
                        //         //             onPressed: () {},
                        //         //             icon: Icon(Icons.download),
                        //         //             label: Text(""))
                        //         //       ],
                        //         //     ),
                        //         //   ),
                        //         // ])
                        //         // DataRow(cells: [
                        //         //   DataCell(Text('1')),
                        //         //   DataCell(Text('Stephen')),
                        //         //   DataCell(Text('Actor')),
                        //         //   DataCell(Text('1')),
                        //         //   DataCell(Text('Stephen')),
                        //         //   DataCell(Text('Actor')),
                        //         // ]),
                        //         // DataRow(cells: [
                        //         //   DataCell(Text('1')),
                        //         //   DataCell(Text('Stephen')),
                        //         //   DataCell(Text('Actor')),
                        //         //   DataCell(Text('1')),
                        //         //   DataCell(Text('Stephen')),
                        //         //   DataCell(Text('Actor')),
                        //         // ]),
                        //       ],
                        //     )
                        //   ],
                        // );
                        // return DataTable(
                        //   border: TableBorder.all(
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(0.0))),
                        //   columns: [
                        //     DataColumn(
                        //         label: Text(
                        //       '${snapshot.data!['data'][i]['dob']}',
                        //       style: TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w800,
                        //           color: Colors.blue),
                        //     )),
                        //     DataColumn(
                        //         label: Text(
                        //       '${snapshot.data!['data'][i]['first_name']}',
                        //       style: TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w800,
                        //           color: Colors.blue),
                        //     )),
                        //     DataColumn(
                        //         label: Text(
                        //       '${snapshot.data!['data'][i]['last_name']}',
                        //       style: TextStyle(
                        //           overflow: TextOverflow.clip,
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w800,
                        //           color: Colors.blue),
                        //     )),
                        //   ],
                        //   rows: [],
                        // );

                      }
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Container _userDetails(BuildContext context, dynamic snapshot) {
    final int gender = snapshot.data!['data'][0]['gender'];
    // ignore: sized_box_for_whitespace
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("UIDAI: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoMono',
                              fontSize: 17)),
                      Text(
                        "${snapshot.data!['data'][0]['aadhaar_number']}",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoMono',
                              fontSize: 17)),
                      Text(
                        "${snapshot.data!['data'][0]['first_name']}" +
                            " ${snapshot.data!['data'][0]['last_name']}",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("DOB: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: 'RobotoMono',
                          )),
                      Text(
                        "${snapshot.data!['data'][0]['dob']}",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text("Mobile No.: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            fontFamily: 'RobotoMono',
                          )),
                      Text(
                        "${snapshot.data!['data'][0]['mobile']}",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: gender == 1
                      ? Row(
                          children: [
                            Text("Gender: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: 'RobotoMono',
                                )),
                            Text(
                              "Male",
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text("Gender: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoMono',
                                )),
                            Text(
                              "Female",
                            )
                          ],
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(65),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'http://13.233.93.36/media/${snapshot.data!['data'][0]['image']}',
                    scale: 1.0,
                  ),
                  radius: 65.0,
                ),
              ),
            )
          ]),
          SizedBox(
            height: 15,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Row(
          //     children: [
          //       Text("Mobile No.: ",
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             fontSize: 17,
          //             fontFamily: 'RobotoMono',
          //           )),
          //       Text(
          //         "${snapshot.data!['data'][0]['mobile']}",
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: gender == 1
          //       ? Row(
          //           children: [
          //             Text("Gender: ",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 17,
          //                   fontFamily: 'RobotoMono',
          //                 )),
          //             Text(
          //               "Male",
          //             ),
          //           ],
          //         )
          //       : Row(
          //           children: [
          //             Text("Gender: ",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontFamily: 'RobotoMono',
          //                 )),
          //             Text(
          //               "Female",
          //             )
          //           ],
          //         ),
          // ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text("E-mail: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'RobotoMono',
                    )),
                Text(
                  "${snapshot.data!['data'][0]['email']}",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.black,
            endIndent: 5.0,
            thickness: 2.0,
            indent: 5.0,
            height: 5.0,
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Existing Affidavits",
                textScaleFactor: 1.5,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'RobotoMono')),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}

// class Person {
//   String apiUrl = "http://13.233.93.36/api/?uidai=${widget.mydata}";
//   Future<List> getData() async {
//     try {
//       var res = await http.get(Uri.parse(apiUrl));
//       if (res.statusCode == 200) {
//         return jsonDecode(res.body);
//       } else {
//         return Future.error("API get Error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }

