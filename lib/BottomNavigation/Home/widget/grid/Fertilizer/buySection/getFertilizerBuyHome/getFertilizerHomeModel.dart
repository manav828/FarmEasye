

class BuyFertilizerModel {
  final String? id;
  final String? ownerId;
  final String? ownerName;
  final String? ownerPhone;
  final String? shopName;
  final String? FertilizerName;
  final String? FertilizerCompany;
  final String? state;
  final String? city;
  final double? price;
  final double? weightInKG;
  final String? address;
  final String? description;
  final List<String>? imageUrls;

  BuyFertilizerModel({
    this.id,
    this.weightInKG,
    this.ownerPhone,
    this.ownerId,
    this.ownerName,
    this.shopName,
    this.FertilizerCompany,
    this.FertilizerName,
    this.state,
    this.city,
    this.price,
    this.imageUrls,
    this.address,
    this.description,
  });
}
