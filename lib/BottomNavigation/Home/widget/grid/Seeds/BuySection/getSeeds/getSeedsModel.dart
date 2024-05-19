class SeedSellModel {
  String? id;
  String? ownerId;
  String? ownerName;
  String? ownerPhone;
  String? state;
  String? city;
  String? seedName;
  String? seedType;
  double? weight;
  // String? description;
  String? variety;
  String? address;
  double? expectedYield;
  String? plantingSeason;
  // String? requiredSoilCondition;
  String? CompanyName;
  double? requiredPHofWater;
  double? price;
  final List<String>? imageUrls;

  // Constructor
  SeedSellModel(
      {this.ownerName,
      this.weight,
      this.CompanyName,
      this.id,
      this.price,
      this.ownerId,
      this.ownerPhone,
      this.address,
      this.state,
      this.city,
      this.seedName,
      this.seedType,
      // this.description,
      this.variety,
      this.expectedYield,
      this.plantingSeason,
      // this.requiredSoilCondition,
      this.requiredPHofWater,
      this.imageUrls});
}
