import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.cartItemsList, required this.index})
      : super(key: key);

  final List cartItemsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(cartItemsList[index]['imagem'],
                    height: 80, width: 80, fit: BoxFit.contain),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(cartItemsList[index]['nome'],
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.clip)),
                  Text('\$${cartItemsList[index]['preco']}',
                      style: const TextStyle(overflow: TextOverflow.ellipsis)),
                ])
              ]))
    ]);
  }
}
