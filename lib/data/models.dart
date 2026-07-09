class Product {
  const Product({
    required this.name,
    required this.price,
    required this.discount,
    required this.thumbAsset,
  });

  final String name;
  final String price;
  final String discount;
  final String thumbAsset;
}

class SmartPost {
  const SmartPost({
    required this.imageAsset,
    required this.trackTitle,
    required this.trackArtist,
    required this.caption,
    this.product,
  });

  final String imageAsset;
  final String trackTitle;
  final String trackArtist;
  final String caption;
  final Product? product;
}

class SharePlatform {
  const SharePlatform(this.name, this.iconAsset);

  final String name;
  final String iconAsset;
}
