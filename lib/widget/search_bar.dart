import 'package:flutter/material.dart';

class SearchBarClass extends StatefulWidget {
  //final Function? onchangedfunction;
  final Function onChanged;
  final String? value;

  SearchBarClass({super.key, required this.onChanged, this.value});
  @override
  State<SearchBarClass> createState() => _SearchBarClassState();
}

class _SearchBarClassState extends State<SearchBarClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF666666),
      margin: EdgeInsets.only(right: 20, left: 0, bottom: 10),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.symmetric(),
          child: TextField(
          
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
            
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: Icon(
                Icons.send,
                color: Colors.white,
              ),

              disabledBorder: InputBorder.none,
              hintText: 'Search',hintStyle: Theme.of(context).textTheme.titleMedium,
              //focusedBorder: InputBorder.none, // Remove border when focused
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: Color(0xFF666666),

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
            style: Theme.of(context).textTheme.titleMedium,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              // Handle search action here
            },
          ),
        ),
      ),
    );
  }
}
