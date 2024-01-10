import 'package:flutter/material.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details_page.dart';

import 'global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Nike',
    'Adidas',
    'Puma',
    'Skechers',
    'RedTape'
  ];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                Text(
                  'Shopping App',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.heart_broken_outlined),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.shopping_cart),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search',
              contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filters[index];
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filters[index]
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).highlightColor,
                        side: BorderSide(color: Colors.grey),
                        label: Text(filters[index]),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetailsPage(product: products[index]);
                      }));
                    },
                    child: ProductCard(
                      title: products[index]['title'] as String,
                      price: products[index]['price'] as double,
                      image: products[index]['imageUrl'] as String,
                      backgroundColor: index.isEven
                          ? Color.fromRGBO(216, 240, 253, 1)
                          : Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
