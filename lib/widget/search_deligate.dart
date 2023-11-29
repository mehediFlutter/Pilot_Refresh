import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List? searchProducts;

  CustomSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.searchProducts});
  // List<String> products = [
  //   'Mehedi 2018',
  //   'alam 2019',
  //   'pilot 2017',
  //   'prado 2012',
  //   'RangeRover xm9',
  //   'Nissan 2012',
  //   'Xtreem',
  //   'Sagor',
  //   'Horidas',
  //   'Sajjat',
  // ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var actor in searchProducts!) {
      if (actor.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(actor);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var actor in searchProducts!) {
      if (actor.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(actor);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            // Update the search bar with the selected suggestion
            query = result;
            // Close the search and pass the selected suggestion to the calling screen
            close(context, result);
          },
        );
      },
    );
  }
}
