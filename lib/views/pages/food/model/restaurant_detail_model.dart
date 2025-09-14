// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:superapp/services/search.service.dart';
//
// class RestaurantsDetailModel {
//   final bool? success;
//   final RestaurantsDetailRecord? data;
//   final String? message;
//
//   RestaurantsDetailModel({
//     this.success,
//     this.data,
//     this.message,
//   });
//
//   factory RestaurantsDetailModel.fromRawJson(String str) => RestaurantsDetailModel.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory RestaurantsDetailModel.fromJson(Map<String, dynamic> json) => RestaurantsDetailModel(
//     success: json["success"],
//     data: json["data"] == null ? null : RestaurantsDetailRecord.fromJson(json["data"]),
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data?.toJson(),
//     "message": message,
//   };
// }
//
// class RestaurantsDetailRecord {
//   final int? id;
//   final String? name;
//   final String? description;
//   final String? logoUrl;
//   final String? bannerUrl;
//   final String? cuisineType;
//   final String? address;
//   final String? city;
//   final String? state;
//   final String? country;
//   final String? postalCode;
//   final String? latitude;
//   final String? longitude;
//   final String? phone;
//   final String? email;
//   final String? website;
//   final String? openingHours;
//   final String? deliveryFee;
//   final String? minimumOrder;
//   final int? minDeliveryTime;
//   final int? maxDeliveryTime;
//   final bool? deliveryAvailable;
//   final bool? pickupAvailable;
//   final String? deliveryRadius;
//   final String? status;
//   final bool? isFeatured;
//   final bool? isVerified;
//   final String? rating;
//   final int? totalReviews;
//   final String? assignedAdminId;
//   final int? assignedManagerId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? deletedAt;
//   final String? logoUrlFormatted;
//   final String? bannerUrlFormatted;
//   final String? fullAddress;
//   final bool? isOpen;
//   final String? deliveryTimeRange;
//   final bool? canUserManage;
//   final List<Category>? categories;
//   final List<ModifierGroup>? servingSizes;
//   final List<ModifierGroup>? modifierGroups;
//   final List<Banner>? banners;
//
//   RestaurantsDetailRecord({
//     this.id,
//     this.name,
//     this.description,
//     this.logoUrl,
//     this.bannerUrl,
//     this.cuisineType,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.postalCode,
//     this.latitude,
//     this.longitude,
//     this.phone,
//     this.email,
//     this.website,
//     this.openingHours,
//     this.deliveryFee,
//     this.minimumOrder,
//     this.minDeliveryTime,
//     this.maxDeliveryTime,
//     this.deliveryAvailable,
//     this.pickupAvailable,
//     this.deliveryRadius,
//     this.status,
//     this.isFeatured,
//     this.isVerified,
//     this.rating,
//     this.totalReviews,
//     this.assignedAdminId,
//     this.assignedManagerId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.logoUrlFormatted,
//     this.bannerUrlFormatted,
//     this.fullAddress,
//     this.isOpen,
//     this.deliveryTimeRange,
//     this.canUserManage,
//     this.categories,
//     this.servingSizes,
//     this.modifierGroups,
//     this.banners,
//   });
//
//   factory RestaurantsDetailRecord.fromRawJson(String str) => RestaurantsDetailRecord.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory RestaurantsDetailRecord.fromJson(Map<String, dynamic> json) {
//     log("Messgae ${json}");
//     return RestaurantsDetailRecord(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     logoUrl: json["logo_url"],
//     bannerUrl: json["banner_url"],
//     cuisineType: json["cuisine_type"],
//     address: json["address"],
//     city: json["city"],
//     state: json["state"],
//     country: json["country"],
//     postalCode: json["postal_code"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     phone: json["phone"],
//     email: json["email"],
//     website: json["website"],
//     openingHours: json["opening_hours"],
//     deliveryFee: json["delivery_fee"],
//     minimumOrder: json["minimum_order"],
//     minDeliveryTime: json["min_delivery_time"],
//     maxDeliveryTime: json["max_delivery_time"],
//     deliveryAvailable: json["delivery_available"],
//     pickupAvailable: json["pickup_available"],
//     deliveryRadius: json["delivery_radius"],
//     status: json["status"],
//     isFeatured: json["is_featured"],
//     isVerified: json["is_verified"],
//     rating: json["rating"],
//     totalReviews: json["total_reviews"],
//     assignedAdminId: json["assigned_admin_id"],
//     assignedManagerId: json["assigned_manager_id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     logoUrlFormatted: json["logo_url_formatted"],
//     bannerUrlFormatted: json["banner_url_formatted"],
//     fullAddress: json["full_address"],
//     isOpen: json["is_open"],
//     deliveryTimeRange: json["delivery_time_range"],
//     canUserManage: json["can_user_manage"],
//       categories: json["categories"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
//
//     servingSizes: json["serving_sizes"] == null ? [] : List<ModifierGroup>.from(json["serving_sizes"]!.map((x) => ModifierGroup.fromJson(x))),
//     modifierGroups: json["modifier_groups"] == null ? [] : List<ModifierGroup>.from(json["modifier_groups"]!.map((x) => ModifierGroup.fromJson(x))),
//     banners: json["banners"] == null ? [] : List<Banner>.from(json["banners"]!.map((x) => Banner.fromJson(x))),
//   );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "logo_url": logoUrl,
//     "banner_url": bannerUrl,
//     "cuisine_type": cuisineType,
//     "address": address,
//     "city": city,
//     "state": state,
//     "country": country,
//     "postal_code": postalCode,
//     "latitude": latitude,
//     "longitude": longitude,
//     "phone": phone,
//     "email": email,
//     "website": website,
//     "opening_hours": openingHours,
//     "delivery_fee": deliveryFee,
//     "minimum_order": minimumOrder,
//     "min_delivery_time": minDeliveryTime,
//     "max_delivery_time": maxDeliveryTime,
//     "delivery_available": deliveryAvailable,
//     "pickup_available": pickupAvailable,
//     "delivery_radius": deliveryRadius,
//     "status": status,
//     "is_featured": isFeatured,
//     "is_verified": isVerified,
//     "rating": rating,
//     "total_reviews": totalReviews,
//     "assigned_admin_id": assignedAdminId,
//     "assigned_manager_id": assignedManagerId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "logo_url_formatted": logoUrlFormatted,
//     "banner_url_formatted": bannerUrlFormatted,
//     "full_address": fullAddress,
//     "is_open": isOpen,
//     "delivery_time_range": deliveryTimeRange,
//     "can_user_manage": canUserManage,
//     "categories": categories == null ? [] : List<Category>.from(categories!.map((x) => x.toJson())),
//     "serving_sizes": servingSizes == null ? [] : List<ModifierGroup>.from(servingSizes!.map((x) => x.toJson())),
//     "modifier_groups": modifierGroups == null ? [] : List<ModifierGroup>.from(modifierGroups!.map((x) => x.toJson())),
//     "banners": banners == null ? [] : List<Banner>.from(banners!.map((x) => x.toJson())),
//   };
// }
//
// class Banner {
//   final int? id;
//   final int? restaurantId;
//   final String? title;
//   final String? description;
//   final String? imageUrl;
//   final String? bannerType;
//   final int? position;
//   final bool? isActive;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? linkUrl;
//   final bool? targetBlank;
//   final int? sortOrder;
//   final int? clickCount;
//   final int? impressionCount;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? deletedAt;
//
//   Banner({
//     this.id,
//     this.restaurantId,
//     this.title,
//     this.description,
//     this.imageUrl,
//     this.bannerType,
//     this.position,
//     this.isActive,
//     this.startDate,
//     this.endDate,
//     this.linkUrl,
//     this.targetBlank,
//     this.sortOrder,
//     this.clickCount,
//     this.impressionCount,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Banner.fromJson(Map<String, dynamic> json) => Banner(
//     id: json["id"],
//     restaurantId: json["restaurant_id"],
//     title: json["title"],
//     description: json["description"],
//     imageUrl: json["image_url"],
//     bannerType: json["banner_type"],
//     position: json["position"],
//     isActive: json["is_active"],
//     startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//     endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//     linkUrl: json["link_url"],
//     targetBlank: json["target_blank"],
//     sortOrder: json["sort_order"],
//     clickCount: json["click_count"],
//     impressionCount: json["impression_count"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "restaurant_id": restaurantId,
//     "title": title,
//     "description": description,
//     "image_url": imageUrl,
//     "banner_type": bannerType,
//     "position": position,
//     "is_active": isActive,
//     "start_date": startDate?.toIso8601String(),
//     "end_date": endDate?.toIso8601String(),
//     "link_url": linkUrl,
//     "target_blank": targetBlank,
//     "sort_order": sortOrder,
//     "click_count": clickCount,
//     "impression_count": impressionCount,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//   };
// }
//
// class Category {
//   final int? id;
//   final int? restaurantId;
//   final String? name;
//   final String? description;
//   final String? imageUrl;
//   final String? iconUrl;
//   final int? sortOrder;
//   final bool? isActive;
//   final bool? isFeatured;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? deletedAt;
//   final String? imageUrlFormatted;
//   final String? iconUrlFormatted;
//   final int? productCount;
//   final List<Category>? subcategories;
//   final List<Product>? products;
//   final int? categoryId;
//
//   Category({
//     this.id,
//     this.restaurantId,
//     this.name,
//     this.description,
//     this.imageUrl,
//     this.iconUrl,
//     this.sortOrder,
//     this.isActive,
//     this.isFeatured,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.imageUrlFormatted,
//     this.iconUrlFormatted,
//     this.productCount,
//     this.subcategories,
//     this.products,
//     this.categoryId,
//   });
//
//   factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     restaurantId: json["restaurant_id"],
//     name: json["name"],
//     description: json["description"],
//     imageUrl: json["image_url"],
//     iconUrl: json["icon_url"],
//     sortOrder: json["sort_order"],
//     isActive: json["is_active"],
//     isFeatured: json["is_featured"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     imageUrlFormatted: json["image_url_formatted"],
//     iconUrlFormatted: json["icon_url_formatted"],
//     productCount: json["product_count"],
//     subcategories: json["subcategories"] == null ? [] : List<Category>.from(json["subcategories"]!.map((x) => Category.fromJson(x))),
//     products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
//     categoryId: json["category_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "restaurant_id": restaurantId,
//     "name": name,
//     "description": description,
//     "image_url": imageUrl,
//     "icon_url": iconUrl,
//     "sort_order": sortOrder,
//     "is_active": isActive,
//     "is_featured": isFeatured,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "image_url_formatted": imageUrlFormatted,
//     "icon_url_formatted": iconUrlFormatted,
//     "product_count": productCount,
//     "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
//     "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
//     "category_id": categoryId,
//   };
// }
//
// class Product {
//   final int? id;
//   final int? restaurantId;
//   final int? categoryId;
//   final int? subcategoryId;
//   final String? name;
//   final String? description;
//   final String? imageUrl;
//   final String? price;
//   final String? originalPrice;
//   final String? discountPercentage;
//   final String? discountAmount;
//   final String? ingredients;
//   final String? allergens;
//   final int? preparationTime;
//   final int? calories;
//   final String? dietaryInfo;
//   final bool? isAvailable;
//   final bool? isFeatured;
//   final bool? isPopular;
//   final bool? isRecommended;
//   final String? stockQuantity;
//   final bool? trackStock;
//   final bool? allowOutOfStockOrders;
//   final bool? allowCustomization;
//   final String? customizationOptions;
//   final int? sortOrder;
//   final int? viewCount;
//   final int? orderCount;
//   final String? rating;
//   final int? totalReviews;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? deletedAt;
//   final String? imageUrlFormatted;
//   final String? finalPrice;
//   final String? discountPercentageCalculated;
//   final bool? isInStock;
//   final String? averageRatingFormatted;
//   final ModifierGroup? modifierGroups;
//
//   Product({
//     this.id,
//     this.restaurantId,
//     this.categoryId,
//     this.subcategoryId,
//     this.name,
//     this.description,
//     this.imageUrl,
//     this.price,
//     this.originalPrice,
//     this.discountPercentage,
//     this.discountAmount,
//     this.ingredients,
//     this.allergens,
//     this.preparationTime,
//     this.calories,
//     this.dietaryInfo,
//     this.isAvailable,
//     this.isFeatured,
//     this.isPopular,
//     this.isRecommended,
//     this.stockQuantity,
//     this.trackStock,
//     this.allowOutOfStockOrders,
//     this.allowCustomization,
//     this.customizationOptions,
//     this.sortOrder,
//     this.viewCount,
//     this.orderCount,
//     this.rating,
//     this.totalReviews,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.imageUrlFormatted,
//     this.finalPrice,
//     this.discountPercentageCalculated,
//     this.isInStock,
//     this.averageRatingFormatted,
//     this.modifierGroups,
//   });
//
//   factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     restaurantId: json["restaurant_id"],
//     categoryId: json["category_id"],
//     subcategoryId: json["subcategory_id"],
//     name: json["name"],
//     description: json["description"],
//     imageUrl: json["image_url"],
//     price: json["price"],
//     originalPrice: json["original_price"],
//     discountPercentage: json["discount_percentage"],
//     discountAmount: json["discount_amount"],
//     ingredients: json["ingredients"],
//     allergens: json["allergens"],
//     preparationTime: json["preparation_time"],
//     calories: json["calories"],
//     dietaryInfo: json["dietary_info"],
//     isAvailable: json["is_available"],
//     isFeatured: json["is_featured"],
//     isPopular: json["is_popular"],
//     isRecommended: json["is_recommended"],
//     stockQuantity: json["stock_quantity"],
//     trackStock: json["track_stock"],
//     allowOutOfStockOrders: json["allow_out_of_stock_orders"],
//     allowCustomization: json["allow_customization"],
//     customizationOptions: json["customization_options"],
//     sortOrder: json["sort_order"],
//     viewCount: json["view_count"],
//     orderCount: json["order_count"],
//     rating: json["rating"],
//     totalReviews: json["total_reviews"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     imageUrlFormatted: json["image_url_formatted"],
//     finalPrice: json["final_price"],
//     discountPercentageCalculated: json["discount_percentage_calculated"],
//     isInStock: json["is_in_stock"],
//     averageRatingFormatted: json["average_rating_formatted"],
//     modifierGroups: json["modifier_groups"] != null ? ModifierGroup.fromJson(json["modifier_groups"]) : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "restaurant_id": restaurantId,
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "name": name,
//     "description": description,
//     "image_url": imageUrl,
//     "price": price,
//     "original_price": originalPrice,
//     "discount_percentage": discountPercentage,
//     "discount_amount": discountAmount,
//     "ingredients": ingredients,
//     "allergens": allergens,
//     "preparation_time": preparationTime,
//     "calories": calories,
//     "dietary_info": dietaryInfo,
//     "is_available": isAvailable,
//     "is_featured": isFeatured,
//     "is_popular": isPopular,
//     "is_recommended": isRecommended,
//     "stock_quantity": stockQuantity,
//     "track_stock": trackStock,
//     "allow_out_of_stock_orders": allowOutOfStockOrders,
//     "allow_customization": allowCustomization,
//     "customization_options": customizationOptions,
//     "sort_order": sortOrder,
//     "view_count": viewCount,
//     "order_count": orderCount,
//     "rating": rating,
//     "total_reviews": totalReviews,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "image_url_formatted": imageUrlFormatted,
//     "final_price": finalPrice,
//     "discount_percentage_calculated": discountPercentageCalculated,
//     "is_in_stock": isInStock,
//     "average_rating_formatted": averageRatingFormatted,
//     "modifier_groups":modifierGroups?.toJson()
//
//   };
// }
//
//
// class ModifierGroup {
//   final int? id;
//   final String? name;
//   final String? selectionType;
//   final String? requiredCount;
//   final int? restaurantId;
//   final bool? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? deletedAt;
//   final List<Modifier>? modifiers;
//
//   ModifierGroup({
//     this.id,
//     this.name,
//     this.selectionType,
//     this.requiredCount,
//     this.restaurantId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.modifiers,
//   });
//
//   factory ModifierGroup.fromRawJson(String str) => ModifierGroup.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ModifierGroup.fromJson(Map<String, dynamic> json) => ModifierGroup(
//     id: json["id"],
//     name: json["name"],
//     selectionType: json["selection_type"],
//     requiredCount: json["required_count"],
//     restaurantId: json["restaurant_id"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     modifiers: json["modifiers"] == null ? [] : List<Modifier>.from(json["modifiers"]!.map((x) => Modifier.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "selection_type": selectionType,
//     "required_count": requiredCount,
//     "restaurant_id": restaurantId,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "modifiers": modifiers == null ? [] : List<dynamic>.from(modifiers!.map((x) => x.toJson())),
//   };
// }
//
// class Modifier {
//   final int? id;
//   final String? name;
//   final String? description;
//   final int? restaurantId;
//   final bool? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//   final Pivot? pivot;
//
//   Modifier({
//     this.id,
//     this.name,
//     this.description,
//     this.restaurantId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.pivot,
//   });
//
//   factory Modifier.fromRawJson(String str) => Modifier.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     restaurantId: json["restaurant_id"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "restaurant_id": restaurantId,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "pivot": pivot?.toJson(),
//   };
// }
//
// class Pivot {
//   final int? modifierGroupId;
//   final int? modifierId;
//   final int? sortOrder;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   Pivot({
//     this.modifierGroupId,
//     this.modifierId,
//     this.sortOrder,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//     modifierGroupId: json["modifier_group_id"],
//     modifierId: json["modifier_id"],
//     sortOrder: json["sort_order"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "modifier_group_id": modifierGroupId,
//     "modifier_id": modifierId,
//     "sort_order": sortOrder,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
//
//

// To parse this JSON data, do
//
//     final restaurantsDetailModel = restaurantsDetailModelFromJson(jsonString);

import 'dart:convert';

RestaurantsDetailModel restaurantsDetailModelFromJson(String str) => RestaurantsDetailModel.fromJson(json.decode(str));

String restaurantsDetailModelToJson(RestaurantsDetailModel data) => json.encode(data.toJson());

class RestaurantsDetailModel {
  final bool? success;
  final RestaurantsDetailRecord? data;
  final String? message;

  RestaurantsDetailModel({
    this.success,
    this.data,
    this.message,
  });

  RestaurantsDetailModel copyWith({
    bool? success,
    RestaurantsDetailRecord? data,
    String? message,
  }) =>
      RestaurantsDetailModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory RestaurantsDetailModel.fromJson(Map<String, dynamic> json) => RestaurantsDetailModel(
    success: json["success"],
    data: json["data"] == null ? null : RestaurantsDetailRecord.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class RestaurantsDetailRecord {
  final int? id;
  final String? name;
  final String? description;
  final dynamic logoUrl;
  final dynamic bannerUrl;
  final String? cuisineType;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? latitude;
  final String? longitude;
  final String? phone;
  final String? email;
  final String? website;
  final dynamic openingHours;
  final String? deliveryFee;
  final String? minimumOrder;
  final int? minDeliveryTime;
  final int? maxDeliveryTime;
  final bool? deliveryAvailable;
  final bool? pickupAvailable;
  final String? deliveryRadius;
  final String? status;
  final bool? isFeatured;
  final bool? isVerified;
  final String? rating;
  final int? totalReviews;
  final dynamic assignedAdminId;
  final int? assignedManagerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic logoUrlFormatted;
  final dynamic bannerUrlFormatted;
  final String? fullAddress;
  final bool? isOpen;
  final String? deliveryTimeRange;
  final bool? canUserManage;
  final List<Category>? categories;
  final List<ServingSize>? servingSizes;
  final List<ModifierGroup>? modifierGroups;
  final List<Banner>? banners;
  final dynamic offers;

  RestaurantsDetailRecord({
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.bannerUrl,
    this.cuisineType,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.phone,
    this.email,
    this.website,
    this.openingHours,
    this.deliveryFee,
    this.minimumOrder,
    this.minDeliveryTime,
    this.maxDeliveryTime,
    this.deliveryAvailable,
    this.pickupAvailable,
    this.deliveryRadius,
    this.status,
    this.isFeatured,
    this.isVerified,
    this.rating,
    this.totalReviews,
    this.assignedAdminId,
    this.assignedManagerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.logoUrlFormatted,
    this.bannerUrlFormatted,
    this.fullAddress,
    this.isOpen,
    this.deliveryTimeRange,
    this.canUserManage,
    this.categories,
    this.servingSizes,
    this.modifierGroups,
    this.banners,
    this.offers,
  });

  RestaurantsDetailRecord copyWith({
    int? id,
    String? name,
    String? description,
    dynamic logoUrl,
    dynamic bannerUrl,
    String? cuisineType,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? latitude,
    String? longitude,
    String? phone,
    String? email,
    String? website,
    dynamic openingHours,
    String? deliveryFee,
    String? minimumOrder,
    int? minDeliveryTime,
    int? maxDeliveryTime,
    bool? deliveryAvailable,
    bool? pickupAvailable,
    String? deliveryRadius,
    String? status,
    bool? isFeatured,
    bool? isVerified,
    String? rating,
    int? totalReviews,
    dynamic assignedAdminId,
    int? assignedManagerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic logoUrlFormatted,
    dynamic bannerUrlFormatted,
    String? fullAddress,
    bool? isOpen,
    String? deliveryTimeRange,
    bool? canUserManage,
    List<Category>? categories,
    List<ServingSize>? servingSizes,
    List<ModifierGroup>? modifierGroups,
    List<Banner>? banners,
    dynamic offers,
  }) =>
      RestaurantsDetailRecord(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        logoUrl: logoUrl ?? this.logoUrl,
        bannerUrl: bannerUrl ?? this.bannerUrl,
        cuisineType: cuisineType ?? this.cuisineType,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        postalCode: postalCode ?? this.postalCode,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        website: website ?? this.website,
        openingHours: openingHours ?? this.openingHours,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        minimumOrder: minimumOrder ?? this.minimumOrder,
        minDeliveryTime: minDeliveryTime ?? this.minDeliveryTime,
        maxDeliveryTime: maxDeliveryTime ?? this.maxDeliveryTime,
        deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
        pickupAvailable: pickupAvailable ?? this.pickupAvailable,
        deliveryRadius: deliveryRadius ?? this.deliveryRadius,
        status: status ?? this.status,
        isFeatured: isFeatured ?? this.isFeatured,
        isVerified: isVerified ?? this.isVerified,
        rating: rating ?? this.rating,
        totalReviews: totalReviews ?? this.totalReviews,
        assignedAdminId: assignedAdminId ?? this.assignedAdminId,
        assignedManagerId: assignedManagerId ?? this.assignedManagerId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        logoUrlFormatted: logoUrlFormatted ?? this.logoUrlFormatted,
        bannerUrlFormatted: bannerUrlFormatted ?? this.bannerUrlFormatted,
        fullAddress: fullAddress ?? this.fullAddress,
        isOpen: isOpen ?? this.isOpen,
        deliveryTimeRange: deliveryTimeRange ?? this.deliveryTimeRange,
        canUserManage: canUserManage ?? this.canUserManage,
        categories: categories ?? this.categories,
        servingSizes: servingSizes ?? this.servingSizes,
        modifierGroups: modifierGroups ?? this.modifierGroups,
        banners: banners ?? this.banners,
        offers: offers ?? this.offers,
      );

  factory RestaurantsDetailRecord.fromJson(Map<String, dynamic> json) => RestaurantsDetailRecord(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    logoUrl: json["logo_url"],
    bannerUrl: json["banner_url"],
    cuisineType: json["cuisine_type"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postalCode: json["postal_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    phone: json["phone"],
    email: json["email"],
    website: json["website"],
    openingHours: json["opening_hours"],
    deliveryFee: json["delivery_fee"],
    minimumOrder: json["minimum_order"],
    minDeliveryTime: json["min_delivery_time"],
    maxDeliveryTime: json["max_delivery_time"],
    deliveryAvailable: json["delivery_available"],
    pickupAvailable: json["pickup_available"],
    deliveryRadius: json["delivery_radius"],
    status: json["status"],
    isFeatured: json["is_featured"],
    isVerified: json["is_verified"],
    rating: json["rating"],
    totalReviews: json["total_reviews"],
    assignedAdminId: json["assigned_admin_id"],
    assignedManagerId: json["assigned_manager_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    logoUrlFormatted: json["logo_url_formatted"],
    bannerUrlFormatted: json["banner_url_formatted"],
    fullAddress: json["full_address"],
    isOpen: json["is_open"],
    deliveryTimeRange: json["delivery_time_range"],
    canUserManage: json["can_user_manage"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    servingSizes: json["serving_sizes"] == null ? [] : List<ServingSize>.from(json["serving_sizes"]!.map((x) => ServingSize.fromJson(x))),
    modifierGroups: json["modifier_groups"] == null ? [] : List<ModifierGroup>.from(json["modifier_groups"]!.map((x) => ModifierGroup.fromJson(x))),
    banners: json["banners"] == null ? [] : List<Banner>.from(json["banners"]!.map((x) => Banner.fromJson(x))),
    offers: json["offers"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "logo_url": logoUrl,
    "banner_url": bannerUrl,
    "cuisine_type": cuisineType,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "phone": phone,
    "email": email,
    "website": website,
    "opening_hours": openingHours,
    "delivery_fee": deliveryFee,
    "minimum_order": minimumOrder,
    "min_delivery_time": minDeliveryTime,
    "max_delivery_time": maxDeliveryTime,
    "delivery_available": deliveryAvailable,
    "pickup_available": pickupAvailable,
    "delivery_radius": deliveryRadius,
    "status": status,
    "is_featured": isFeatured,
    "is_verified": isVerified,
    "rating": rating,
    "total_reviews": totalReviews,
    "assigned_admin_id": assignedAdminId,
    "assigned_manager_id": assignedManagerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "logo_url_formatted": logoUrlFormatted,
    "banner_url_formatted": bannerUrlFormatted,
    "full_address": fullAddress,
    "is_open": isOpen,
    "delivery_time_range": deliveryTimeRange,
    "can_user_manage": canUserManage,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "serving_sizes": servingSizes == null ? [] : List<dynamic>.from(servingSizes!.map((x) => x.toJson())),
    "modifier_groups": modifierGroups == null ? [] : List<dynamic>.from(modifierGroups!.map((x) => x.toJson())),
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
    "offers": offers,
  };
}

class Banner {
  final int? id;
  final int? restaurantId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? bannerType;
  final int? position;
  final bool? isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic linkUrl;
  final bool? targetBlank;
  final int? sortOrder;
  final int? clickCount;
  final int? impressionCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Banner({
    this.id,
    this.restaurantId,
    this.title,
    this.description,
    this.imageUrl,
    this.bannerType,
    this.position,
    this.isActive,
    this.startDate,
    this.endDate,
    this.linkUrl,
    this.targetBlank,
    this.sortOrder,
    this.clickCount,
    this.impressionCount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Banner copyWith({
    int? id,
    int? restaurantId,
    String? title,
    String? description,
    String? imageUrl,
    String? bannerType,
    int? position,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    dynamic linkUrl,
    bool? targetBlank,
    int? sortOrder,
    int? clickCount,
    int? impressionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Banner(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        bannerType: bannerType ?? this.bannerType,
        position: position ?? this.position,
        isActive: isActive ?? this.isActive,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        linkUrl: linkUrl ?? this.linkUrl,
        targetBlank: targetBlank ?? this.targetBlank,
        sortOrder: sortOrder ?? this.sortOrder,
        clickCount: clickCount ?? this.clickCount,
        impressionCount: impressionCount ?? this.impressionCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["image_url"],
    bannerType: json["banner_type"],
    position: json["position"],
    isActive: json["is_active"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    linkUrl: json["link_url"],
    targetBlank: json["target_blank"],
    sortOrder: json["sort_order"],
    clickCount: json["click_count"],
    impressionCount: json["impression_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "title": title,
    "description": description,
    "image_url": imageUrl,
    "banner_type": bannerType,
    "position": position,
    "is_active": isActive,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "link_url": linkUrl,
    "target_blank": targetBlank,
    "sort_order": sortOrder,
    "click_count": clickCount,
    "impression_count": impressionCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Category {
  final int? id;
  final int? restaurantId;
  final String? name;
  final String? description;
  final dynamic imageUrl;
  final dynamic iconUrl;
  final int? sortOrder;
  final bool? isActive;
  final bool? isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic imageUrlFormatted;
  final dynamic iconUrlFormatted;
  final int? productCount;
  final List<Subcategory>? subcategories;
  final List<Product>? products;

  Category({
    this.id,
    this.restaurantId,
    this.name,
    this.description,
    this.imageUrl,
    this.iconUrl,
    this.sortOrder,
    this.isActive,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageUrlFormatted,
    this.iconUrlFormatted,
    this.productCount,
    this.subcategories,
    this.products,
  });

  Category copyWith({
    int? id,
    int? restaurantId,
    String? name,
    String? description,
    dynamic imageUrl,
    dynamic iconUrl,
    int? sortOrder,
    bool? isActive,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic imageUrlFormatted,
    dynamic iconUrlFormatted,
    int? productCount,
    List<Subcategory>? subcategories,
    List<Product>? products,
  }) =>
      Category(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        iconUrl: iconUrl ?? this.iconUrl,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
        isFeatured: isFeatured ?? this.isFeatured,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        imageUrlFormatted: imageUrlFormatted ?? this.imageUrlFormatted,
        iconUrlFormatted: iconUrlFormatted ?? this.iconUrlFormatted,
        productCount: productCount ?? this.productCount,
        subcategories: subcategories ?? this.subcategories,
        products: products ?? this.products,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    iconUrl: json["icon_url"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    imageUrlFormatted: json["image_url_formatted"],
    iconUrlFormatted: json["icon_url_formatted"],
    productCount: json["product_count"],
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "icon_url": iconUrl,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_featured": isFeatured,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "image_url_formatted": imageUrlFormatted,
    "icon_url_formatted": iconUrlFormatted,
    "product_count": productCount,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  final int? id;
  final int? restaurantId;
  final int? categoryId;
  final int? subcategoryId;
  final String? name;
  final String? description;
  final dynamic imageUrl;
  final String? price;
  final String? originalPrice;
  final String? discountPercentage;
  final String? discountAmount;
  final String? ingredients;
  final String? allergens;
  final int? preparationTime;
  final int? calories;
  final String? dietaryInfo;
  final bool? isAvailable;
  final bool? isFeatured;
  final bool? isPopular;
  final bool? isRecommended;
  final dynamic stockQuantity;
  final bool? trackStock;
  final bool? allowOutOfStockOrders;
  final bool? allowCustomization;
  final String? customizationOptions;
  final int? sortOrder;
  final int? viewCount;
  final int? orderCount;
  final String? rating;
  final int? totalReviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic imageUrlFormatted;
  final String? finalPrice;
  final String? discountPercentageCalculated;
  final bool? isInStock;
  final String? averageRatingFormatted;
  final List<dynamic>? modifierGroups;

  Product({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.originalPrice,
    this.discountPercentage,
    this.discountAmount,
    this.ingredients,
    this.allergens,
    this.preparationTime,
    this.calories,
    this.dietaryInfo,
    this.isAvailable,
    this.isFeatured,
    this.isPopular,
    this.isRecommended,
    this.stockQuantity,
    this.trackStock,
    this.allowOutOfStockOrders,
    this.allowCustomization,
    this.customizationOptions,
    this.sortOrder,
    this.viewCount,
    this.orderCount,
    this.rating,
    this.totalReviews,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageUrlFormatted,
    this.finalPrice,
    this.discountPercentageCalculated,
    this.isInStock,
    this.averageRatingFormatted,
    this.modifierGroups,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    price: json["price"],
    originalPrice: json["original_price"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    ingredients: json["ingredients"],
    allergens: json["allergens"],
    preparationTime: json["preparation_time"],
    calories: json["calories"],
    dietaryInfo: json["dietary_info"],
    isAvailable: json["is_available"],
    isFeatured: json["is_featured"],
    isPopular: json["is_popular"],
    isRecommended: json["is_recommended"],
    stockQuantity: json["stock_quantity"],
    trackStock: json["track_stock"],
    allowOutOfStockOrders: json["allow_out_of_stock_orders"],
    allowCustomization: json["allow_customization"],
    customizationOptions: json["customization_options"],
    sortOrder: json["sort_order"],
    viewCount: json["view_count"],
    orderCount: json["order_count"],
    rating: json["rating"],
    totalReviews: json["total_reviews"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    imageUrlFormatted: json["image_url_formatted"],
    finalPrice: json["final_price"],
    discountPercentageCalculated: json["discount_percentage_calculated"],
    isInStock: json["is_in_stock"],
    averageRatingFormatted: json["average_rating_formatted"],
    modifierGroups: json["modifier_groups"] == null
        ? []
        : List<dynamic>.from(json["modifier_groups"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "price": price,
    "original_price": originalPrice,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "ingredients": ingredients,
    "allergens": allergens,
    "preparation_time": preparationTime,
    "calories": calories,
    "dietary_info": dietaryInfo,
    "is_available": isAvailable,
    "is_featured": isFeatured,
    "is_popular": isPopular,
    "is_recommended": isRecommended,
    "stock_quantity": stockQuantity,
    "track_stock": trackStock,
    "allow_out_of_stock_orders": allowOutOfStockOrders,
    "allow_customization": allowCustomization,
    "customization_options": customizationOptions,
    "sort_order": sortOrder,
    "view_count": viewCount,
    "order_count": orderCount,
    "rating": rating,
    "total_reviews": totalReviews,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "image_url_formatted": imageUrlFormatted,
    "final_price": finalPrice,
    "discount_percentage_calculated": discountPercentageCalculated,
    "is_in_stock": isInStock,
    "average_rating_formatted": averageRatingFormatted,
    "modifier_groups": modifierGroups == null
        ? []
        : List<dynamic>.from(modifierGroups!.map((x) => x)),
  };
}

class Subcategory {
  final int? id;
  final int? restaurantId;
  final int? categoryId;
  final String? name;
  final String? description;
  final dynamic imageUrl;
  final dynamic iconUrl;
  final int? sortOrder;
  final bool? isActive;
  final bool? isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic imageUrlFormatted;
  final dynamic iconUrlFormatted;
  final int? productCount;
  final List<Product>? products;

  Subcategory({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.name,
    this.description,
    this.imageUrl,
    this.iconUrl,
    this.sortOrder,
    this.isActive,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageUrlFormatted,
    this.iconUrlFormatted,
    this.productCount,
    this.products,
  });

  Subcategory copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    String? name,
    String? description,
    dynamic imageUrl,
    dynamic iconUrl,
    int? sortOrder,
    bool? isActive,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic imageUrlFormatted,
    dynamic iconUrlFormatted,
    int? productCount,
    List<Product>? products,
  }) =>
      Subcategory(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        iconUrl: iconUrl ?? this.iconUrl,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
        isFeatured: isFeatured ?? this.isFeatured,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        imageUrlFormatted: imageUrlFormatted ?? this.imageUrlFormatted,
        iconUrlFormatted: iconUrlFormatted ?? this.iconUrlFormatted,
        productCount: productCount ?? this.productCount,
        products: products ?? this.products,
      );

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    categoryId: json["category_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    iconUrl: json["icon_url"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    imageUrlFormatted: json["image_url_formatted"],
    iconUrlFormatted: json["icon_url_formatted"],
    productCount: json["product_count"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "category_id": categoryId,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "icon_url": iconUrl,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_featured": isFeatured,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "image_url_formatted": imageUrlFormatted,
    "icon_url_formatted": iconUrlFormatted,
    "product_count": productCount,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ModifierGroup {
  final int? id;
  final String? name;
  final String? selectionType;
  final dynamic requiredCount;
  final int? restaurantId;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<ServingSize>? modifiers;

  ModifierGroup({
    this.id,
    this.name,
    this.selectionType,
    this.requiredCount,
    this.restaurantId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.modifiers,
  });

  ModifierGroup copyWith({
    int? id,
    String? name,
    String? selectionType,
    dynamic requiredCount,
    int? restaurantId,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    List<ServingSize>? modifiers,
  }) =>
      ModifierGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        selectionType: selectionType ?? this.selectionType,
        requiredCount: requiredCount ?? this.requiredCount,
        restaurantId: restaurantId ?? this.restaurantId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        modifiers: modifiers ?? this.modifiers,
      );

  factory ModifierGroup.fromJson(Map<String, dynamic> json) => ModifierGroup(
    id: json["id"],
    name: json["name"],
    selectionType: json["selection_type"],
    requiredCount: json["required_count"],
    restaurantId: json["restaurant_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    modifiers: json["modifiers"] == null ? [] : List<ServingSize>.from(json["modifiers"]!.map((x) => ServingSize.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "selection_type": selectionType,
    "required_count": requiredCount,
    "restaurant_id": restaurantId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "modifiers": modifiers == null ? [] : List<dynamic>.from(modifiers!.map((x) => x.toJson())),
  };
}

class ServingSize {
  final int? id;
  final String? name;
  final String? description;
  final int? restaurantId;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Pivot? pivot;

  ServingSize({
    this.id,
    this.name,
    this.description,
    this.restaurantId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  ServingSize copyWith({
    int? id,
    String? name,
    String? description,
    int? restaurantId,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    Pivot? pivot,
  }) =>
      ServingSize(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        restaurantId: restaurantId ?? this.restaurantId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory ServingSize.fromJson(Map<String, dynamic> json) => ServingSize(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    restaurantId: json["restaurant_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "restaurant_id": restaurantId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  final int? modifierGroupId;
  final int? modifierId;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pivot({
    this.modifierGroupId,
    this.modifierId,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  Pivot copyWith({
    int? modifierGroupId,
    int? modifierId,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Pivot(
        modifierGroupId: modifierGroupId ?? this.modifierGroupId,
        modifierId: modifierId ?? this.modifierId,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modifierGroupId: json["modifier_group_id"],
    modifierId: json["modifier_id"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "modifier_group_id": modifierGroupId,
    "modifier_id": modifierId,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
