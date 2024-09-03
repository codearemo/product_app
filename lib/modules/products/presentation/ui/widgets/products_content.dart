import 'package:assessment/core/ui/app_dropdown.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/ui/screens/add_edit_product_screen.dart';

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

List<ProductModel> demoProducts = [
  ProductModel(
    id: 1,
    images: ["https://i.postimg.cc/c19zpJ6f/Image-Popular-Product-1.png"],
    colors: [
      "F6625E",
      "836DB8",
      "DECB9C",
      "FFFFFF",
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  ProductModel(
    id: 2,
    images: [
      "https://i.postimg.cc/CxD6nH74/Image-Popular-Product-2.png",
    ],
    colors: [
      "F6625E",
      "836DB8",
      "DECB9C",
      "FFFFFF",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  ProductModel(
    id: 3,
    images: [
      "https://i.postimg.cc/1XjYwvbv/glap.png",
    ],
    colors: [
      "F6625E",
      "836DB8",
      "DECB9C",
      "FFFFFF",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  ProductModel(
    id: 4,
    images: [
      "https://i.postimg.cc/d1QWXMYW/Image-Popular-Product-3.png",
    ],
    colors: [
      "F6625E",
      "836DB8",
      "DECB9C",
      "FFFFFF",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isPopular: true,
  ),
];

  final List<CustomDropdownItem> productImages = [
    CustomDropdownItem(
      value: AppImageData(
        imageUrl: 'https://i.postimg.cc/c19zpJ6f/Image-Popular-Product-1.png',
      ),
      label: 'Game Pad',
    ),
    CustomDropdownItem(
      value: AppImageData(
        imageUrl: 'https://i.postimg.cc/CxD6nH74/Image-Popular-Product-2.png',
      ),
      label: 'Shorts',
    ),
    CustomDropdownItem(
      value: AppImageData(
        imageUrl: 'https://i.postimg.cc/1XjYwvbv/glap.png',
      ),
      label: 'Gloves',
    ),
    CustomDropdownItem(
      value: AppImageData(
        imageUrl: 'https://i.postimg.cc/d1QWXMYW/Image-Popular-Product-3.png',
      ),
      label: 'Helmet',
    ),
  ];