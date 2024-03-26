import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_refresh/add%20car/upload_multiple_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DescriptionPage extends StatefulWidget {
  final int? newLyAddedCarId;
  const DescriptionPage({super.key, this.newLyAddedCarId});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  TextEditingController descriptionControllerBangla = TextEditingController();
  TextEditingController descriptionControllerEnglish = TextEditingController();
  SharedPreferences? prefss;
  @override
  void initState() {
    // TODO: implement initState
    print("Newly added id is");
    print(widget.newLyAddedCarId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Congratulation you have added your car',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  'Now add Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 30),
              Text("Description in English"),
              SizedBox(height: 5),
              decriptionFilds(
                  textEditingController: descriptionControllerEnglish),
              SizedBox(height: 20),
              Text("Description in Bangla"),
              SizedBox(height: 5),
              decriptionFilds(
                  textEditingController: descriptionControllerBangla),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () async {
                        prefss = await SharedPreferences.getInstance();
                        var body = {
                          "description": {
                            "en": descriptionControllerEnglish.text,
                            "bn": descriptionControllerBangla.text
                          }
                        };
                        var encodedBody = json.encode(body);
                        final url =
                            "https://pilotbazar.com/api/merchants/vehicles/${widget.newLyAddedCarId}/descriptions";
                        final uri = Uri.parse(url);
                        final response =
                            await http.post(uri, body: encodedBody, headers: {
                          'Accept': 'application/vnd.api+json',
                          'Content-Type': 'application/vnd.api+json',
                          'Authorization':
                              'Bearer ${prefss?.getString('token')}'
                        });
                        print("status code");
                        print(response.statusCode);
                        print('Id ${widget.newLyAddedCarId}');
                        print("token ${prefss?.getString('token')}");

                        print(descriptionControllerEnglish.text);
                        print(descriptionControllerBangla.text);
                        await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UploadMultiPleImage(
                                      newLyAddedCarId: widget.newLyAddedCarId,
                                    
                                    ),), (route) => false);
                      },
                      child: Text("Submit")))
            ],
          ),
        ),
      ),
    ));
  }

  Widget decriptionFilds({
    final TextEditingController? textEditingController,
  }) {
    return TextFormField(
      maxLines: 5,
      controller: textEditingController,
      // keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 54, 45, 45),
          ),
        ),

        // hintText: 'Add Description',hintStyle: TextStyle(color: const Color.fromARGB(255, 82, 80, 80),fontSize: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set default border color to white
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set focused border color to white
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        // contentPadding:
        //     EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: const Color.fromARGB(255, 196, 194, 194), fontSize: 20),
      //style: TextStyle(color: Colors.white,fontSize: 20),
      cursorColor:
          Color.fromARGB(255, 196, 194, 194), // Set cursor color to white
      cursorHeight: 20,
    );
  }
}
