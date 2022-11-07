// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['product_name'] as String?,
      json['product_id'] as int?,
      json['barcode_number'] as String?,
      json['hsn_number'] as String?,
      json['description'] as String?,
      json['manufacturer'] as String?,
      json['product_category'] as String?,
      json['scope'] as String?,
      json['mrp'] as String?,
      json['nrv'] as String?,
      json['ptr'] as String?,
      json['tax_type'] as String?,
      json['isQps'] as bool?,
      json['discount_value'] as int?,
      json['product_status'] as bool?,
      json['quantity_limit'] as int?,
      json['tax_value'] as Object?,
      json['pts'] as String?,
      json['net_price'] as String?,
      json['is_feature_product'] as bool?,
      (json['packs'] as List<dynamic>?)
          ?.map((e) => Pack.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['pricing_id'] as int?,
      json['pricing_node_id'] as int?,
      json['query_node_id'] as int?,
      json['channel'] as int?,
      json['image'] as String?,
      json['brand'] == null
          ? null
          : ProductBrand.fromJson(json['brand'] as Map<String, dynamic>),
      (json['distributor_types'] as List<dynamic>?)
          ?.map((e) => DistributorTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_name': instance.productName,
      'product_id': instance.productId,
      'barcode_number': instance.barcodeNumber,
      'hsn_number': instance.hsnNumber,
      'description': instance.description,
      'manufacturer': instance.manufacturer,
      'product_category': instance.productCategory,
      'scope': instance.scope,
      'mrp': instance.mrp,
      'nrv': instance.nrv,
      'ptr': instance.ptr,
      'tax_type': instance.taxType,
      'isQps': instance.isQps,
      'discount_value': instance.discountValue,
      'product_status': instance.productStatus,
      'quantity_limit': instance.quantityLimit,
      'tax_value': instance.taxValue,
      'pts': instance.pts,
      'net_price': instance.netPrice,
      'is_feature_product': instance.isFeatureProduct,
      'packs': instance.packs,
      'pricing_id': instance.pricingId,
      'pricing_node_id': instance.pricingNodeId,
      'query_node_id': instance.queryNodeId,
      'channel': instance.channel,
      'image': instance.image,
      'brand': instance.brand,
      'distributor_types': instance.distributorTypes,
    };
