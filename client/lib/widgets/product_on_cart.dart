import 'package:flutter/material.dart';

class ProductOnCart extends StatelessWidget {
  const ProductOnCart({
    Key? key,
  }) : super(key: key);

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
              Image.asset('assets/foto.jpg',
                  height: 80, width: 80, fit: BoxFit.contain),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('name',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.clip)),
                    Text('\$0.00'),
                    Text('product id')
                  ]),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red))
            ]),
      )
    ]);
  }
}
