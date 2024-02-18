import 'package:flutter/material.dart';
import 'package:pilot_refresh/const_color/constant_color.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';

class CustomerCareDetails extends StatefulWidget {
  const CustomerCareDetails({super.key});

  @override
  State<CustomerCareDetails> createState() => _CustomerCareDetailsState();
}

class _CustomerCareDetailsState extends State<CustomerCareDetails> {
  TextStyle tableHeader =
      TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
  TextStyle cellStyle = TextStyle(color: Colors.white);
  List<Map<String, String>> userData = [
    {"name": "Maisha", "phone": "01745215478", "password": "pilot87654321"},
    {"name": "Alishan", "phone": "01723547895", "password": "coPilot415487"},
    {"name": "Robert", "phone": "01745454412", "password": "chatGpi915424"},
    // Add more user data as needed
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
       
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: size.height / 5),
              Center(
                  child: Text(
                "Customer Care Details",
                style: tableHeader,
              )),
              SizedBox(height: size.height / 50),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                    color: Colors.white), // Add borders to the table
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name',
                            style: tableHeader,
                          ),
                        ),
                      )),
                      TableCell(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Phone',
                            style: tableHeader,
                          ),
                        ),
                      )),
                      TableCell(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Password',
                            style: tableHeader,
                          ),
                        ),
                      )),
                    ],
                  ),

                  for (var data in userData)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['name'] ?? '', style: cellStyle),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(data['phone'] ?? '', style: cellStyle),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['password'] ?? '',
                                  style: cellStyle),
                            ),
                          ),
                        ),
                      ],
                    ),
                  // TableRow(
                  //   children: [
                  //     TableCell(
                  //         child: Center(
                  //             child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('Maisha', style: cellStyle),
                  //     ))),
                  //     TableCell(
                  //         child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           '01745215478',
                  //           style: cellStyle,
                  //         ),
                  //       ),
                  //     )),
                  //     TableCell(
                  //         child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           'pilot87654321',
                  //           style: cellStyle,
                  //         ),
                  //       ),
                  //     )),
                  //   ],
                  // ),
                ],
              ),
              Spacer(),
              SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavBaseScreen()), (route) => false);
                },
                child: Text("Go to home Page"),
              ),
              
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
