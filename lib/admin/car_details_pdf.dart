// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:pdf/widgets.dart' as pw;

// void main() {
//   runApp(MaterialApp(home: Car_details_pdf()));
// }

// class Car_details_pdf extends StatefulWidget {
//   const Car_details_pdf({super.key});

//   @override
//   State<Car_details_pdf> createState() => _Car_details_pdfState();
// }

// class _Car_details_pdfState extends State<Car_details_pdf> {
//   @override
//   SharedPreferences? prefss;
//   String? detailsLink;
//   static List unicTitle = [];
//   static List details = [];
//   late String ImageLink;
//   late List ImageLinkList = [];

//   Future getDetails(int id) async {
//     final pdf = pw.Document();

//     if (mounted) {
//       setState(() {});
//     }
//     Response response = await get(Uri.parse(
//         "https://pilotbazar.com/api/clients/vehicles/products/$id/detail"));
//     //https://pilotbazar.com/api/vehicle?page=0
//     //https://crud.teamrabbil.com/api/v1/ReadProduct
//     print(response.statusCode);
//     final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
//     detailsLink = decodedResponse['message'];
//     setState(() {});
//     print(response.body);

//     List<dynamic> vehicleFeatures =
//         decodedResponse['payload']['vehicle_feature'];

//     List<FeatureDetailPair> featureDetailPairs =
//         extractFeatureDetails(vehicleFeatures);

//     for (var pair in featureDetailPairs) {
//       unicTitle.add(pair.featureTitle);
//       details.add(pair.detailTitles.join(', '));
//     }

//     if (mounted) {
//       setState(() {});
//     }
//     String message = "hello";
//     String message3 = "hello 3";
//     String message2 = '';
//     for (int i = 0; i < details.length; i++) {
//       message2 += " ${details[i]}";
//       if (i < details.length - 1) {
//         message2 += ", "; // Add a comma and space if it's not the last index
//       }
//     }
//     print(message2);

//     if (mounted) {
//       setState(() {});
//     }

//     pdf.addPage(
//       pw.Page(
//           build: (pw.Context context) => pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   children: [
//                     pw.Text(message + message2 + message3),
//                   ])),
//     );

//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/example.pdf');

//     await file.writeAsBytes(await pdf.save());

//     Share.shareXFiles([XFile(file.path)], text: 'Car Details pdf');

//     //return unicTitle+details;
//     print("Length of ImageLInkList is");
//     print(ImageLinkList.length);
//   }

//   Future<void> shareAllImages() async {
//     final pdf = pw.Document();
//     prefss = await SharedPreferences.getInstance();
//     Response response1 = await get(
//       Uri.parse(
//           "https://pilotbazar.com/api/clients/vehicles/products/34/detail"),
//     );

//     print(response1.statusCode);
//     final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);

//     for (int b = 0; b < decodedResponse1['payload']['gallery'].length; b++) {
//       ImageLink = decodedResponse1['payload']["gallery"][b]?['name'] ?? '';
//       ImageLinkList.add(ImageLink);
//     }

//     print("From List Image Links are");
//     for (int c = 0; c < ImageLinkList.length; c++) {
//       print(ImageLinkList[c]);
//     }

//     List<XFile> showImageList = [];
//     for (int y = 0; y < ImageLinkList.length; y++) {
//       final uri = Uri.parse(
//           "https://pilotbazar.com/storage/galleries/${ImageLinkList[y]}");
//       final response = await http.get(uri);
//       final imageBytes = response.bodyBytes;
//       final tempDirectory = await getTemporaryDirectory();
//       print("hello");
//       final tempFile = await File('${tempDirectory.path}/sharedImage$y.jpg')
//           .writeAsBytes(imageBytes);

//       final image = XFile(tempFile.path);
//       showImageList.add(image);
//     }

//     final imageProviders =
//         await Future.wait(showImageList.map((imageFile) async {
//       final imageBytes = await imageFile.readAsBytes();
//       return pw.MemoryImage(imageBytes);
//     }).toList());

//     // Create PDF pages with appropriate error handling:
// final imageSize = 195.0;
//   final pageWidth = PdfPageFormat.standard.width;
//   final imagesPerRow = 6; // Adjust as necessary

//   // Calculate the number of images per page based on the number of images
//   // and the number of images per row
//   final totalImages = imageProviders.length;
//   final imagesPerPage = (totalImages / imagesPerRow).ceil();
//   final totalPages = (totalImages / imagesPerPage).ceil();

//   for (var page = 0; page < totalPages; page++) {
//     final startIndex = page * imagesPerPage;
//     final endIndex = (startIndex + imagesPerPage) < totalImages
//         ? (startIndex + imagesPerPage)
//         : totalImages;

//     final imageSubset = imageProviders.sublist(startIndex, endIndex);

//     final pageImages = imageSubset.map((imageProvider) {
//       return pw.Container(
//         width: imageSize,
//         height: imageSize,
//         child: pw.Image(imageProvider),
//       );
//     });

//     final rows = <pw.Widget>[];
//     for (var i = 0; i < imagesPerPage; i += imagesPerRow) {
//       final rowImages = pageImages.skip(i).take(imagesPerRow).toList();
//       rows.add(
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//           children: rowImages,
//         ),
//       );
//     }

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           children: [
//             pw.Row(children: 
//               rows,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/example.pdf');

//     await file.writeAsBytes(await pdf.save());

//     Share.shareXFiles([XFile(file.path)], text: 'Great picture');
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: TextButton(
//                 onPressed: () async {
//                   //  await getDetails(12);
//                   await shareAllImages();
//                 },
//                 child: Text('Create pdf')),
//           ),
//         ],
//       ),
//     );
//   }
// }
