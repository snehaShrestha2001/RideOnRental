import 'package:flutter/material.dart';
import 'package:ride_with_rental/models/all_products/all_products_model.dart';
import 'package:ride_with_rental/screens/explore/widgets/item_view_widget.dart';

class SearchProductController extends SearchDelegate {
  SearchProductController({
    required this.productsSearchList,
  });
  List<Products> productsSearchList;

  @override
  TextStyle? get searchFieldStyle =>
      const TextStyle(fontSize: 14, color: Colors.grey);

  @override
  String? get searchFieldLabel => "Search your ride";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = '';
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Products> matchedProducts = [];
    for (Products product in productsSearchList) {
      if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchedProducts.add(product);
      }
    }
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: matchedProducts.isEmpty
          ? const Center(
              child: Text('No Results found',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: matchedProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: MediaQuery.of(context).size.height * .26),
              itemBuilder: (context, index) {
                return ItemViewWidget(
                  model: matchedProducts[index],
                );
              }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Products> matchedProducts = [];
    for (Products product in productsSearchList) {
      if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchedProducts.add(product);
      }
    }
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: matchedProducts.isEmpty
          ? const Center(
              child: Text('No Results found',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: matchedProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: MediaQuery.of(context).size.height * .26),
              itemBuilder: (context, index) {
                return ItemViewWidget(
                  model: matchedProducts[index],
                );
              }),
    );
  }
}
