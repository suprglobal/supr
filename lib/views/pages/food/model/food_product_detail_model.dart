// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

FoodProductDetailModel foodProductDetailModelFromJson(String str) => FoodProductDetailModel.fromJson(json.decode(str));

String foodProductDetailModelToJson(FoodProductDetailModel data) => json.encode(data.toJson());

class FoodProductDetailModel {
  final bool? success;
  final FoodProductDetailRecord? data;
  final String? message;

  FoodProductDetailModel({
    this.success,
    this.data,
    this.message,
  });

  FoodProductDetailModel copyWith({
    bool? success,
    FoodProductDetailRecord? data,
    String? message,
  }) =>
      FoodProductDetailModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory FoodProductDetailModel.fromJson(Map<String, dynamic> json) => FoodProductDetailModel(
    success: json["success"],
    data: json["data"] == null ? null : FoodProductDetailRecord.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class FoodProductDetailRecord {
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
  final Restaurant? restaurant;
  final Category? category;
  final Category? subcategory;
  final List<ModifierGroup>? modifierGroups;

  FoodProductDetailRecord({
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
    this.restaurant,
    this.category,
    this.subcategory,
    this.modifierGroups,
  });

  FoodProductDetailRecord copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    int? subcategoryId,
    String? name,
    String? description,
    dynamic imageUrl,
    String? price,
    String? originalPrice,
    String? discountPercentage,
    String? discountAmount,
    String? ingredients,
    String? allergens,
    int? preparationTime,
    int? calories,
    String? dietaryInfo,
    bool? isAvailable,
    bool? isFeatured,
    bool? isPopular,
    bool? isRecommended,
    dynamic stockQuantity,
    bool? trackStock,
    bool? allowOutOfStockOrders,
    bool? allowCustomization,
    String? customizationOptions,
    int? sortOrder,
    int? viewCount,
    int? orderCount,
    String? rating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    dynamic imageUrlFormatted,
    String? finalPrice,
    String? discountPercentageCalculated,
    bool? isInStock,
    String? averageRatingFormatted,
    Restaurant? restaurant,
    Category? category,
    Category? subcategory,
    List<ModifierGroup>? modifierGroups,
  }) =>
      FoodProductDetailRecord(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        categoryId: categoryId ?? this.categoryId,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        price: price ?? this.price,
        originalPrice: originalPrice ?? this.originalPrice,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        discountAmount: discountAmount ?? this.discountAmount,
        ingredients: ingredients ?? this.ingredients,
        allergens: allergens ?? this.allergens,
        preparationTime: preparationTime ?? this.preparationTime,
        calories: calories ?? this.calories,
        dietaryInfo: dietaryInfo ?? this.dietaryInfo,
        isAvailable: isAvailable ?? this.isAvailable,
        isFeatured: isFeatured ?? this.isFeatured,
        isPopular: isPopular ?? this.isPopular,
        isRecommended: isRecommended ?? this.isRecommended,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        trackStock: trackStock ?? this.trackStock,
        allowOutOfStockOrders: allowOutOfStockOrders ?? this.allowOutOfStockOrders,
        allowCustomization: allowCustomization ?? this.allowCustomization,
        customizationOptions: customizationOptions ?? this.customizationOptions,
        sortOrder: sortOrder ?? this.sortOrder,
        viewCount: viewCount ?? this.viewCount,
        orderCount: orderCount ?? this.orderCount,
        rating: rating ?? this.rating,
        totalReviews: totalReviews ?? this.totalReviews,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        imageUrlFormatted: imageUrlFormatted ?? this.imageUrlFormatted,
        finalPrice: finalPrice ?? this.finalPrice,
        discountPercentageCalculated: discountPercentageCalculated ?? this.discountPercentageCalculated,
        isInStock: isInStock ?? this.isInStock,
        averageRatingFormatted: averageRatingFormatted ?? this.averageRatingFormatted,
        restaurant: restaurant ?? this.restaurant,
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        modifierGroups: modifierGroups ?? this.modifierGroups,
      );

  factory FoodProductDetailRecord.fromJson(Map<String, dynamic> json) => FoodProductDetailRecord(
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
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
    modifierGroups: json["modifier_groups"] == null ? [] : List<ModifierGroup>.from(json["modifier_groups"]!.map((x) => ModifierGroup.fromJson(x))),
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
    "restaurant": restaurant?.toJson(),
    "category": category?.toJson(),
    "subcategory": subcategory?.toJson(),
    "modifier_groups": modifierGroups == null ? [] : List<dynamic>.from(modifierGroups!.map((x) => x.toJson())),
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
  final int? categoryId;

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
    this.categoryId,
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
    int? categoryId,
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
        categoryId: categoryId ?? this.categoryId,
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
    categoryId: json["category_id"],
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
    "category_id": categoryId,
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
  final List<Modifier>? modifiers;

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
    List<Modifier>? modifiers,
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
    modifiers: json["modifiers"] == null ? [] : List<Modifier>.from(json["modifiers"]!.map((x) => Modifier.fromJson(x))),
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

class Modifier {
  final int? id;
  final String? name;
  final String? description;
  final int? restaurantId;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Pivot? pivot;

  Modifier({
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

  Modifier copyWith({
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
      Modifier(
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

  factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
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

class Restaurant {
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

  Restaurant({
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
  });

  Restaurant copyWith({
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
  }) =>
      Restaurant(
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
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
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
  };
}
