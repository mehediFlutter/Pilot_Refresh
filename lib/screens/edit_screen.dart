import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String? name;
  final String? price;
  final String? registration;
  final String? manufacture;
  final String? condition;
  final String? mileage;

  const EditScreen(
      {super.key,
      this.name,
      this.price,
      this.registration,
      this.manufacture,
      this.condition,
      this.mileage});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
   TextEditingController _registrationEditingController = TextEditingController();
  TextEditingController _manufactureEditingController = TextEditingController();
  TextEditingController _conditionEditingController = TextEditingController();
  TextEditingController _millegeEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //String n=widget.name.toString();
    _nameEditingController.text = widget.name.toString();
    _priceEditingController.text = widget.price.toString();
    _registrationEditingController.text=widget.registration.toString();
    _manufactureEditingController.text=widget.manufacture.toString();
    _conditionEditingController.text=widget.condition.toString();
    _millegeEditingController.text=widget.mileage.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Your Task",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black26,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Edit ",
                style: TextStyle(color: Colors.white),
              ),
              Text("Name"),
              TextField(
                
                controller: _nameEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  
                    fillColor: Colors.black, border: OutlineInputBorder()),
              ),
              TextField(
                controller: _priceEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder()),
              ),
              TextField(
                controller: _registrationEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefix: Text("R :  ",style: TextStyle(color: Colors.white),), 
                                   border: OutlineInputBorder()),
              ),
              
              TextField(
                controller: _conditionEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              TextField(
                controller: _millegeEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Update")))
            ],
          ),
        ));
  }
}
