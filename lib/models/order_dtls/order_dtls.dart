import '../../db/cart_item_data_detail/cart_item_data_detail.dart';

class OrderDtls{
  String? transactionId;
  String? distributorName;
  int? distributorId;
  String? remarks;
  String? distributorType;
  int? distributorTypeId;
  List<int>? availableDistTypes;
  List<int>? availableDistributors;
  bool? groupByType;
  bool? groupByDistributors;
  List<CartItemDataDetail> items = [];

  OrderDtls(
      this.transactionId,
      this.distributorName,
      this.distributorId,
      this.remarks,
      this.distributorType,
      this.distributorTypeId,
      this.availableDistTypes,
      this.availableDistributors,
      this.groupByType,
      this.groupByDistributors,
      this.items);
}