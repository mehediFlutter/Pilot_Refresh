import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: MaterialStateProperty.resolveWith((states) {
          return 6;
        },),
        padding: MaterialStateProperty.resolveWith((states) {
          return EdgeInsets.symmetric(horizontal: 20);
        }),
        //padding: EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF313131);
          }
          return Color(0xFF313131);
        }),
        leading: Image.asset('assets/images/search.png'),
        trailing: <Widget>[
          InkWell(onTap: () {}, child: Image.asset('assets/images/send.png'))
        ]);
  }
}