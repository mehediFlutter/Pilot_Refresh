import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeItem extends StatefulWidget {
  final int id;
  final String imageName;
  final String price;
  final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? dropdownSeat;
  final String? dropdownSeatAnswer;
  final String? dropdownRoof;
  final String? dropdownRoofAnswer;
  final String? dropdownStarOption;
  final String? dropdownStarOptionAnswer;
  final String? featureSeat;
  final String? featureSeatDetails;
  final int? jj;
  final String? vehiclaName;
  final String? registration;
  final String? manufacture;
  final String? condition;
  final String? nMillage;
  HomeItem({
    super.key,
    required this.id,
    required this.imageName,
    required this.price,
    this.dropdownFontLight,
    this.dropdownFontLightAnswer,
    this.dropdownSeat,
    this.dropdownSeatAnswer,
    this.dropdownRoof,
    this.dropdownRoofAnswer,
    this.dropdownStarOption,
    this.dropdownStarOptionAnswer,
    this.featureSeat,
    this.featureSeatDetails,
    this.jj,
    this.vehiclaName,
    this.registration,
    this.manufacture,
    this.condition,
    this.nMillage,
  });

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("I am on press");
        _showAlertDialog(context);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Card(
            margin: EdgeInsets.only(bottom: 1,top: 0),
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                    
                  ),
                ),
                subtitle: ListTile(
                  contentPadding:
                      EdgeInsets.zero,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // product name
                      Text(widget.vehiclaName.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                      Row(
                        children: [
                          Text(
                            "R:",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            widget.registration.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "Used",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            " | ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
              
                          //Text(products[x].id.toString()),
                          Text(
                            "m: ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            " | ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "321457km",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
              
                      Row(
                        children: [
                          Text("Tk",
                              style: Theme.of(context).textTheme.bodySmall),
                          Text("00215452",
                              style: Theme.of(context).textTheme.bodySmall),
                         SizedBox(width: 50,),
                          InkWell(
                              onTap: () async {
                                final uri = Uri.parse(
                                    "https://pilotbazar.com/storage/vehicles/${widget.imageName}");
                                final response = await http.get(uri);
                                final imageBytes = response.bodyBytes;
                                final tempDirectory =
                                    await getTemporaryDirectory();
                                final tempFile = await File(
                                        '${tempDirectory.path}/sharedImage.jpg')
                                    .create();
                                await tempFile.writeAsBytes(imageBytes);
              
                                final image = XFile(tempFile.path);
                                await Share.shareXFiles([image],
                                    text:
                                        "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nOur HotLine Number: 017xxxxxxxx");
                              },
                              child: Icon(
                                Icons.share,
                                size: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )

          // Card(
          //   elevation: 7,
          //   child:      ListTile(
          //       contentPadding: EdgeInsets.only(left: 1, right: 1),

          //       title: ClipRRect(
          //         borderRadius: BorderRadius.circular(15),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 5),
          //           child: Image.network(
          //             "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
          //             width: 50,
          //             height: 100,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //       ),
          //       //"https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
          //       subtitle: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           // product name
          //           Text(widget.vehiclaName.toString(),
          //               style: Theme.of(context).textTheme.bodySmall),
          //           Row(
          //             children: [
          //               Text(
          //                 "R:",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Text(
          //                 widget.registration.toString(),
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Text(
          //                 "",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Text(
          //                 " | ",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),

          //               //Text(products[x].id.toString()),
          //               Text(
          //                 "fdf",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Text(
          //                 " | ",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Text(
          //                 "my write",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Available At (PBL)",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),
          //               Spacer(),
          //               InkWell(
          //                 onTap: (){},
          //                 child: Icon(Icons.share,size: 20,))
          //               // IconButton(
          //               //   padding: EdgeInsets.zero,
          //               //   onPressed: () {},
          //               //   icon: Icon(
          //               //     Icons.share,
          //               //     size: 12,
          //               //   ),
          //               // )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Tk.",
          //                 style: TextStyle(height: 0,fontSize: 10),
          //               ),
          //               Text(
          //                 "gfg",
          //                 style: Theme.of(context).textTheme.bodySmall,
          //               ),

          //               // ElevatedButton(

          //               //   onPressed: () async {
          //               //     final uri = Uri.parse(
          //               //         "https://pilotbazar.com/storage/vehicles/${widget.imageName}");
          //               //     final response = await http.get(uri);
          //               //     final imageBytes = response.bodyBytes;
          //               //     final tempDirectory = await getTemporaryDirectory();
          //               //     final tempFile =
          //               //         await File('${tempDirectory.path}/sharedImage.jpg')
          //               //             .create();
          //               //     await tempFile.writeAsBytes(imageBytes);

          //               //     final image = XFile(tempFile.path);
          //               //     await Share.shareXFiles([image],
          //               //         text:
          //               //             "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nOur HotLine Number: 017xxxxxxxx");
          //               //   },
          //               //   child: Icon(Icons.share,size: 15,),
          //               // ),
          //             ],
          //           ),
          //           Text('d'),
          //         ],
          //       ),
          //     ),
          // ),

          ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text("Fuatures and "),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(widget.price),
                      Text(widget.featureSeat?.toString() ?? ''),
                      Text(widget.featureSeatDetails.toString()),
                      Text("data1"),
                      Text("data1"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Handle the confirm action
              },
            ),
          ],
        );
      },
    );
  }
}
