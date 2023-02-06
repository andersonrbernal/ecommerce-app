import 'package:flutter/material.dart';

class ProductOnCart extends StatefulWidget {
  const ProductOnCart({
    Key? key,
    required this.name,
    required this.price,
    required this.picture,
  }) : super(key: key);

  final String name;
  final String price;
  final String picture;

  @override
  State<ProductOnCart> createState() => _ProductOnCartState();
}

class _ProductOnCartState extends State<ProductOnCart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(5.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(widget.picture,
                  height: 80, width: 80, fit: BoxFit.contain),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.name,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip)),
                Text('\$${widget.price}'),
              ]),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red))
            ]),
      )
    ]);
  }
}
