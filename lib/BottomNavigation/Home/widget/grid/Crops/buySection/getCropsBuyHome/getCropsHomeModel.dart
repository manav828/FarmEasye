class BuyCropHomeDataModel {
  final String? id;
  final String? ownerId;
  final String? ownerName;
  final String? ownerPhone;
  final String? cropName;
  final String? state;
  final String? city;
  final String? address;
  final String? description;
  final double? pricePerQue;
  final double? totalQuintal;

  final List<String>? imageUrls;

  BuyCropHomeDataModel({
    this.id,
    this.description,
    this.address,
    this.ownerPhone,
    this.ownerId,
    this.ownerName,
    this.cropName,
    this.state,
    this.city,
    this.pricePerQue,
    this.totalQuintal,
    this.imageUrls,
  });
}
