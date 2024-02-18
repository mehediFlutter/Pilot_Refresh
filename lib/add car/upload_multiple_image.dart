import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadMultiPleImage extends StatefulWidget {
  final int? newLyAddedCarId;
  const UploadMultiPleImage({super.key, this.newLyAddedCarId});

  @override
  _UploadMultiPleImageState createState() => _UploadMultiPleImageState();
}

class _UploadMultiPleImageState extends State<UploadMultiPleImage> {
  // Use List of XFile to store selected images
  SharedPreferences? prefss;
  List<XFile?> selectedImages = [];
  var resJson;
  Future<void> getImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      selectedImages = pickedImages;
    });
    print("Orijinal image siaze");
    for (var orijinal in selectedImages) {
      print(await orijinal!.length());
    }
  }

  XFile? conpressedFile;
  String CustomTargetPath = '';
  String directoryName = 'PilotBazar';
  bool imageUploadInProgress = false;
  Future<void> onUploadImages() async {
    imageUploadInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss?.getString('token')}'
    };
    if (selectedImages.isNotEmpty) {
      Directory? externalDir = await getExternalStorageDirectory();
      try {
        CustomTargetPath = '${externalDir?.path}/$directoryName';
        setState(() {});
        Directory directory = Directory(CustomTargetPath);
        setState(() {});
        if (!await directory.exists()) {
          await directory.create(recursive: true);
          print('Directory created successfully: ${directory.path}');
        }
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/${widget.newLyAddedCarId}/galleries",
          ),
        );
        request.headers.addAll(headers);

        for (XFile? imageFile in selectedImages) {
          if (imageFile != null) {
            conpressedFile = await FlutterImageCompress.compressAndGetFile(
                imageFile.path, "${directory.path}/${imageFile.name}",
                quality: 50);
            print("compressed image");
            if (mounted) setState(() {});

            final fileLength = await conpressedFile!.length();

            request.files.add(
              http.MultipartFile(
                'image[]',
                await conpressedFile!.readAsBytes().asStream(),
                fileLength,
                filename: conpressedFile!.name, // Use XFile's name property
              ),
            );
          }
        }
        var response = await request.send();

        final responseData = await response.stream.bytesToString();

        print(responseData);
        if (response.statusCode == 200) {
          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
              (route) => false);
        }
      } catch (error) {
        print(error);
      }
    }
       imageUploadInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Multiple Image Upload'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display picked images (grid view might be suitable)
            if (selectedImages.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedImages
                      .map((imageFile) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.file(
                                  File(imageFile!.path),
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _removeImage(imageFile);
                                  _removeImage(imageFile);
                                },
                                icon: Icon(Icons.close),
                                color: Colors.white,
                              ),
                            ],
                          ))
                      .toList(),
                ),
              )
            else
              Text(
                'Please Pick Images to Upload',
              ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: onUploadImages,
                child:imageUploadInProgress?Center(child: CircularProgressIndicator(),): Text(
                  "Upload",
                ),
              ),
            ),
            Text(resJson != null ? resJson['message'] : ''),
            OutlinedButton(onPressed: (){
              getImages();
            }, child: Text('Pick Images'))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
        
      //   onPressed: getImages,
      //   tooltip: 'Pick Images',
      //   child: Icon(Icons.add_a_photo),
      // ),
    );
  }

  void _removeImage(XFile? imageFile) {
    setState(() {
      selectedImages.remove(imageFile);
    });
  }
}


// request.fields['title'] = jsonEncode({
//   'bn': 'fdfd',
//   'en': 'ds',
// })
