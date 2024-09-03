// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    final int? id;
    final String? title;
    final List<String>? colors;
    final double? price;
    final List<String>? images;
    final List<String>? categories;
    final String? description;
    final double? rating;
    final bool? isFavourite;
    final bool? isPopular;

    ProductModel({
        this.id,
        this.title,
        this.colors,
        this.price,
        this.images,
        this.categories,
        this.description,
        this.rating,
        this.isFavourite,
        this.isPopular,
    });

    ProductModel copyWith({
        int? id,
        String? title,
        List<String>? colors,
        double? price,
        List<String>? images,
        List<String>? categories,
        String? description,
        double? rating,
        bool? isFavourite,
        bool? isPopular,
    }) => 
        ProductModel(
            id: id ?? this.id,
            title: title ?? this.title,
            colors: colors ?? this.colors,
            price: price ?? this.price,
            images: images ?? this.images,
            categories: categories ?? this.categories,
            description: description ?? this.description,
            rating: rating ?? this.rating,
            isFavourite: isFavourite ?? this.isFavourite,
            isPopular: isPopular ?? this.isPopular,
        );

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
        price: json["price"]?.toDouble(),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        description: json["description"],
        rating: json["rating"]?.toDouble(),
        isFavourite: json["isFavourite"],
        isPopular: json["isPopular"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "price": price,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "description": description,
        "rating": rating,
        "isFavourite": isFavourite,
        "isPopular": isPopular,
    };
}
