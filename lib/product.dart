class Product {
  final int? id;
    final String? engineNumber;
  final String? chassisNumber;
  final String?edition;
  final String? code;
  final String? model;
  final String? slug;
  final String? vehicleName;
  final String? manufacture;
  final String? condition;
  final String? mileage;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? asking_price;
  final String? available;
  final String? imageName;
  final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? registration;
  final String? brandName;
  final String? engine;
  final String? transmission;
  final String? fuel;
  final String? skeleton;
  final String? detailsLink;
  final String? grade;
  final String? pdfDetailsLink;

  // productCode,
  // image,
  // unitPrice,
  // totalPrice,
  // createAt,
  // quantity;

  Product(
      {this.imageName,
      this.id,
           this.engineNumber,
      this.chassisNumber,
      this.edition,
      this.code,
      this.model,
      this.slug,
      this.vehicleName,
      this.manufacture,
      this.condition,
      this.mileage,
      this.price,
      this.purchase_price,
      this.fixed_price,
      this.asking_price,
      this.available,
      this.dropdownFontLight,
      this.dropdownFontLightAnswer,
      this.registration,
      this.brandName, 
      this.engine,
      this.transmission,
      this.fuel,
      this.skeleton,
      this.detailsLink,
      this.grade,
      this.pdfDetailsLink,
      // required this.productCode,
      // required this.image,
      // required this.unitPrice,
      // required this.totalPrice,
      // required this.createAt,
      // required this.quantity
      });
}
