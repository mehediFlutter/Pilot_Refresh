import 'package:flutter/material.dart';

class SearchBarClassGithub extends StatefulWidget {
  //final Function? onchangedfunction;
final Function onSubmitted;
  final String? value;
  final TextEditingController? searchController;

  SearchBarClassGithub({super.key, required this.onSubmitted, this.value, this.searchController});
  @override
  State<SearchBarClassGithub> createState() => _SearchBarClassGithubState();
}

class _SearchBarClassGithubState extends State<SearchBarClassGithub> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF666666),
      margin: EdgeInsets.only(right: 20, left: 0, bottom: 10,top: 10),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          
          child: TextField(
            controller: widget.searchController,
            style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 15),
                  //style: TextStyle(color: Colors.white,fontSize: 20),
                  cursorColor: Colors.white,
          
            onChanged: (value) {
              widget.onSubmitted(value);
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
              hintText: 'Search',hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15),
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
           // style: Theme.of(context).textTheme.titleMedium,
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