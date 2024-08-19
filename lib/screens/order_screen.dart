import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class OrderScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Tiramisu Cake',
      price: 62000,
      imageUrl:
          'https://www.frisianflag.com/storage/app/media/uploaded-files/itra.jpg',
      description:
          'Tiramisu Cake dengan rasa manis yang pas, sangat cocok untuk sarapan atau camilan sore hari.',
    ),
    Product(
      id: '2',
      name: 'Vanilla Cake',
      price: 32000,
      imageUrl:
          'https://bakerbynature.com/wp-content/uploads/2022/04/Golden-Vanilla-Cake-with-Vanilla-Frosting0-19.jpg',
      description:
          'Vanilla Cake dengan rasa manis yang pas, sangat cocok untuk sarapan atau camilan sore hari.',
    ),
    Product(
      id: '3',
      name: 'Strawberry Cake',
      price: 55000,
      imageUrl:
          'https://www.twopeasandtheirpod.com/wp-content/uploads/2018/04/Strawberry-Shortcake-5.jpg',
      description:
          'Strawberry Cake dengan rasa manis yang pas, sangat cocok untuk sarapan atau camilan sore hari.',
    ),
    Product(
      id: '4',
      name: 'Lapis Legit',
      price: 125000,
      imageUrl:
          'https://cdn1-production-images-kly.akamaized.net/J0A3_vwOx49jeu0WA--3kovHWHM=/1200x1200/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/4050847/original/029236400_1655091983-WhatsApp_Image_2022-06-04_at_2.56.32_PM.jpeg',
      description: 'Kue Lapis, khas Indonesia dengan warna yang menarik..',
    ),
    Product(
      id: '5',
      name: 'Choco Lava',
      price: 55000,
      imageUrl:
          'https://c.ndtvimg.com/2020-01/ko06bsh8_lava-cake_625x300_22_January_20.jpg',
      description:
          'Choco Lava, khas Indonesia dengan warna yang menarik dan rasa yang pastinya tidak mengecewakan.',
    ),
    Product(
      id: '6',
      name: 'Cloud Bread',
      price: 55000,
      imageUrl:
          'https://kirbiecravings.com/wp-content/uploads/2022/10/2-ingredient-cloud-bread-5.jpg',
      description:
          'Cloud Bread, khas Indonesia dengan warna yang menarik dan rasa yang pastinya tidak mengecewakan.',
    ),
    Product(
      id: '7',
      name: 'Milk Bun',
      price: 55000,
      imageUrl:
          'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/66/2024/03/07/WhatsApp-Image-2024-03-05-at-193746-154177202.jpeg',
      description:
          'Milk Bun, khas Indonesia dengan warna yang menarik dan rasa yang pastinya tidak mengecewakan.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Daftar Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink.shade200,
        iconTheme: IconThemeData(color: Colors.pink.shade100),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 4 / 5,
        ),
        itemBuilder: (ctx, i) => ProductItem(products[i]),
      ),
    );
  }
}
