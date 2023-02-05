import 'dart:ffi';

class Product {
  final int id;
  final String name;
  final String image;
  final String description;
  final String material;
  final String department;
  final Float price;
  Product(this.id, this.name, this.image, this.description, this.material,
      this.department, this.price);
}
