import 'package:client/models/user.dart';
import 'package:client/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late CartService cartService;
  late User user;
  late String uid;
  late bool isProductInCart;

  Color buttonStyle = Colors.deepPurple;
  String buttonText = "Add to Cart";

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    uid = user.id;
    cartService = CartService(uid);

    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.product['nome'],
              style: const TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.product['id'],
                    child: Image.network(widget.product['imagem']),
                  )),
              Text(widget.product['nome'],
                  style: const TextStyle(fontSize: 24.0)),
              Text(widget.product['preco'],
                  style: const TextStyle(fontSize: 18.0)),
              Text(widget.product['descricao'],
                  style: const TextStyle(fontSize: 16.0))
            ]),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> data =
                  await cartService.updateCart(int.parse(widget.product['id']));
              bool isProductInCart = await cartService
                  .isProductInCart(int.parse(widget.product['id']));

              if (data['success']) {
                if (isProductInCart) {
                  setState(() {
                    buttonStyle = Colors.grey[600]!;
                    buttonText = "Remove from Cart";
                  });
                  return;
                }

                setState(() {
                  buttonStyle = Colors.deepPurple;
                  buttonText = "Add to Cart";
                });
              }
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(70.0),
                backgroundColor: buttonStyle,
                elevation: 0),
            child: Text(buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 18.0))));
  }
}
