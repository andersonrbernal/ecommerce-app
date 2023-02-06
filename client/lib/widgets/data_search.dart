import 'package:client/services/product_provider.dart';
import 'package:client/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  static ProductProvider productProvider = ProductProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, ''),
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductGridView(productProvider: productProvider, value: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return const Center(
          child: Text('Search term must be longer than two letters.',
              style: TextStyle(fontSize: 20.0)));
    }

    return FutureBuilder(
        future: productProvider.searchProducts(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No Results Found.',
                    style: TextStyle(fontSize: 20.0)));
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data?[index]['nome']),
                    onTap: () => showResults(context)));
          }
          return const Center(child: Text('Ooops, something went wrong.'));
        });
  }
}
