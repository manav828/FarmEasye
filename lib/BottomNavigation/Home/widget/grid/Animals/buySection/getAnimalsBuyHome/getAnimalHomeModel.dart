class BuyAnimalHomeDataModel {
  final String? id;
  final String? ownerId;
  final String? ownerName;
  final String? ownerPhone;
  final String? AnimalType;
  final String? AnimalBreed;
  final String? state;
  final String? city;
  final double? price;
  final String? address;
  final double? animalAge;
  final String? description;

  final List<String>? imageUrls;

  BuyAnimalHomeDataModel(
      {this.id,
      this.ownerPhone,
      this.ownerId,
      this.ownerName,
      this.AnimalType,
      this.state,
      this.city,
      this.price,
      this.imageUrls,
      this.address,
      this.description,
      this.animalAge,
      this.AnimalBreed});
}
