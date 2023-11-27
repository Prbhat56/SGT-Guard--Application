import 'dart:convert';

// class Products {
//   bool? success;
//   String? message;
//   List<Datum>? data;

//   Products({
//     this.success,
//     this.message,
//     this.data,
//   });

//   factory Products.fromRawJson(String str) =>
//       Products.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Products.fromJson(Map<String, dynamic> json) => Products(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   String? id;
//   bool? onSale;
//   int? salePercent;
//   int? sold;
//   bool? sliderNew;
//   bool? sliderRecent;
//   bool? sliderSold;
//   String? date;
//   String? title;
//   Categories? categories;
//   Categories? subcat;
//   Shop? shop;
//   String? price;
//   String? saleTitle;
//   String? salePrice;
//   String? description;
//   String? color;
//   String? size;
//   bool? inWishlist;
//   List<Image>? images;

//   Datum({
//     this.id,
//     this.onSale,
//     this.salePercent,
//     this.sold,
//     this.sliderNew,
//     this.sliderRecent,
//     this.sliderSold,
//     this.date,
//     this.title,
//     this.categories,
//     this.subcat,
//     this.shop,
//     this.price,
//     this.saleTitle,
//     this.salePrice,
//     this.description,
//     this.color,
//     this.size,
//     this.inWishlist,
//     this.images,
//   });

//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         onSale: json["on_sale"],
//         salePercent: json["sale_percent"],
//         sold: json["sold"],
//         sliderNew: json["slider_new"],
//         sliderRecent: json["slider_recent"],
//         sliderSold: json["slider_sold"],
//         date: json["date"],
//         title: json["title"],
//         categories: json["categories"] == null
//             ? null
//             : Categories.fromJson(json["categories"]),
//         subcat:
//             json["subcat"] == null ? null : Categories.fromJson(json["subcat"]),
//         shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
//         price: json["price"],
//         saleTitle: json["sale_title"],
//         salePrice: json["sale_price"],
//         description: json["description"],
//         color: json["color"],
//         size: json["size"],
//         inWishlist: json["in_wishlist"],
//         images: json["images"] == null
//             ? []
//             : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "on_sale": onSale,
//         "sale_percent": salePercent,
//         "sold": sold,
//         "slider_new": sliderNew,
//         "slider_recent": sliderRecent,
//         "slider_sold": sliderSold,
//         "date": date,
//         "title": title,
//         "categories": categories?.toJson(),
//         "subcat": subcat?.toJson(),
//         "shop": shop?.toJson(),
//         "price": price,
//         "sale_title": saleTitle,
//         "sale_price": salePrice,
//         "description": description,
//         "color": color,
//         "size": size,
//         "in_wishlist": inWishlist,
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images!.map((x) => x.toJson())),
//       };
// }

// class Categories {
//   String? id;
//   String? type;
//   int? salePercent;
//   String? date;
//   String? name;
//   String? image;

//   Categories({
//     this.id,
//     this.type,
//     this.salePercent,
//     this.date,
//     this.name,
//     this.image,
//   });

//   factory Categories.fromRawJson(String str) =>
//       Categories.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Categories.fromJson(Map<String, dynamic> json) => Categories(
//         id: json["_id"],
//         type: json["type"],
//         salePercent: json["sale_percent"],
//         date: json["date"],
//         name: json["name"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "type": type,
//         "sale_percent": salePercent,
//         "date": date,
//         "name": name,
//         "image": image,
//       };
// }

// class Image {
//   String? id;
//   String? url;

//   Image({
//     this.id,
//     this.url,
//   });

//   factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "url": url,
//       };
// }

// class Shop {
//   String? id;
//   bool? isActive;
//   String? createdAt;
//   String? name;
//   String? description;
//   String? shopemail;
//   String? shopaddress;
//   String? shopcity;
//   String? userid;
//   String? image;

//   Shop({
//     this.id,
//     this.isActive,
//     this.createdAt,
//     this.name,
//     this.description,
//     this.shopemail,
//     this.shopaddress,
//     this.shopcity,
//     this.userid,
//     this.image,
//   });

//   factory Shop.fromRawJson(String str) => Shop.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Shop.fromJson(Map<String, dynamic> json) => Shop(
//         id: json["_id"],
//         isActive: json["is_active"],
//         createdAt: json["created_At"],
//         name: json["name"],
//         description: json["description"],
//         shopemail: json["shopemail"],
//         shopaddress: json["shopaddress"],
//         shopcity: json["shopcity"],
//         userid: json["userid"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "is_active": isActive,
//         "created_At": createdAt,
//         "name": name,
//         "description": description,
//         "shopemail": shopemail,
//         "shopaddress": shopaddress,
//         "shopcity": shopcity,
//         "userid": userid,
//         "image": image,
//       };
// }

// Guard Home

class GuardHome {
  Teams? teams;
  Jobs? jobs;
  String? imageBaseUrl;
  int? status;

  GuardHome({
    this.teams,
    this.jobs,
    this.imageBaseUrl,
    this.status,
  });

  factory GuardHome.fromRawJson(String str) =>
      GuardHome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GuardHome.fromJson(Map<String, dynamic> json) => GuardHome(
        teams: json["teams"] == null ? null : Teams.fromJson(json["teams"]),
        jobs: json["jobs"] == null ? null : Jobs.fromJson(json["jobs"]),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "teams": teams?.toJson(),
        "jobs": jobs?.toJson(),
        "image_base_url": imageBaseUrl,
        "status": status,
      };
}

class Jobs {
  int? currentPage;
  List<JobsDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Jobs({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Jobs.fromRawJson(String str) => Jobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<JobsDatum>.from(
                json["data"]!.map((x) => JobsDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class JobsDatum {
  int? id;
  int? propertyOwnerId;
  String? propertyName;
  String? type;
  int? assignStaff;
  String? area;
  String? country;
  String? state;
  String? city;
  String? postCode;
  String? propertyDescription;
  String? location;
  String? longitude;
  String? latitude;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PropertyAvatar>? propertyAvatars;

  JobsDatum({
    this.id,
    this.propertyOwnerId,
    this.propertyName,
    this.type,
    this.assignStaff,
    this.area,
    this.country,
    this.state,
    this.city,
    this.postCode,
    this.propertyDescription,
    this.location,
    this.longitude,
    this.latitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.propertyAvatars,
  });

  factory JobsDatum.fromRawJson(String str) =>
      JobsDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobsDatum.fromJson(Map<String, dynamic> json) => JobsDatum(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyName: json["property_name"],
        type: json["type"],
        assignStaff: json["assign_staff"],
        area: json["area"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postCode: json["post_code"],
        propertyDescription: json["property_description"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        propertyAvatars: json["property_avatars"] == null
            ? []
            : List<PropertyAvatar>.from(json["property_avatars"]!
                .map((x) => PropertyAvatar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_name": propertyName,
        "type": type,
        "assign_staff": assignStaff,
        "area": area,
        "country": country,
        "state": state,
        "city": city,
        "post_code": postCode,
        "property_description": propertyDescription,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "property_avatars": propertyAvatars == null
            ? []
            : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
      };
}

class PropertyAvatar {
  int? id;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatar({
    this.id,
    this.propertyId,
    this.propertyAvatar,
  });

  factory PropertyAvatar.fromRawJson(String str) =>
      PropertyAvatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Teams {
  int? currentPage;
  List<TeamsDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Teams({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Teams.fromRawJson(String str) => Teams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<TeamsDatum>.from(
                json["data"]!.map((x) => TeamsDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class TeamsDatum {
  int? id;
  String? avatar;
  String? status;
  String? firstName;
  String? lastName;
  String? apiToken;

  TeamsDatum({
    this.id,
    this.avatar,
    this.status,
    this.firstName,
    this.lastName,
    this.apiToken,
  });

  factory TeamsDatum.fromRawJson(String str) =>
      TeamsDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamsDatum.fromJson(Map<String, dynamic> json) => TeamsDatum(
        id: json["id"],
        avatar: json["avatar"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "api_token": apiToken,
      };
}
