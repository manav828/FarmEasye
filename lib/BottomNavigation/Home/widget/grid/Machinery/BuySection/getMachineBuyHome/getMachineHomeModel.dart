class BuyMachineHomeDataModel {
  final String? id;
  final String? ownerId;
  final String? ownerName;
  final String? ownerPhone;
  final String? machineName;
  final String? vahicalCompany;
  final String? vahicalModel;
  final double? purchaseYear;
  final String? state;
  final String? city;
  final String? address;
  final String? description;
  final double? price;
  final double? kmUsed;

  final List<String>? imageUrls;

  BuyMachineHomeDataModel({
    this.id,
    this.description,
    this.address,
    this.ownerPhone,
    this.ownerId,
    this.ownerName,
    this.machineName,
    this.vahicalCompany,
    this.vahicalModel,
    this.purchaseYear,
    this.state,
    this.city,
    this.price,
    this.kmUsed,
    this.imageUrls,
  });
}
