class SearchProduct {
  final int? id;
  final String? slug;
  final String? vehicleName;
  final String? manufacture;
  final String? condition;
  final String? mileage;
  final String? price;
  final String? imageName;
  final String? dropdownFontLight;
    final String? dropdownFontLightAnswer;
    final String? registration;


  // productCode,
  // image,
  // unitPrice,
  // totalPrice,
  // createAt,
  // quantity;

  SearchProduct(
     {
    this.imageName,
    this.id,
    this.slug,
    this.vehicleName,
    this.manufacture,
    this.condition,
    this.mileage,
    this.price,
    this.dropdownFontLight,
    this.dropdownFontLightAnswer,
    this.registration
    // required this.productCode,
    // required this.image,
    // required this.unitPrice,
    // required this.totalPrice,
    // required this.createAt,
    // required this.quantity
  });
}
