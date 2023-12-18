import 'dart:convert';

import 'package:http/http.dart';

class GetLink{
  final int id;
  GetLink({required this.id});
  
    Future getLink() async {
       String? detailsLink;
    Response response1 = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);
    detailsLink = decodedResponse1['message'];
    print(detailsLink);

  }
}