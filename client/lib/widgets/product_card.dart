import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String picture;
  final String name;
  final String price;

  const ProductCard(
      {super.key,
      required this.name,
      required this.picture,
      required this.price});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x3600000F),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          widget.picture,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )))
              ]),
              Row(mainAxisSize: MainAxisSize.max, children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price}',
                        style: const TextStyle(
                            color: Colors.black, overflow: TextOverflow.fade),
                      ),
                      TextButton(
                          onPressed: () {
                            print('hi');
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.purple),
                          child: const Text('Buy',
                              style: TextStyle(color: Colors.white)))
                    ]),
              )
            ])));
  }
}
