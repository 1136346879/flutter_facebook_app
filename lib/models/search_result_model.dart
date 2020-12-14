import 'package:flutter_facebook/config/xfs_header.dart';

class SearchResultModel{
  SearchResult searchResult;
  int curPage;
  List<CatAndNumXList> catAndNumXList;
  int totalPages;
  int errorCode;
  List<BrandList> brandList;
  int brandListNum;
  int catAndNumXListNum;
  Category category;
  PriceRange priceRange;
  int catLevel;

  SearchResultModel(
      {this.searchResult,
        this.curPage,
        this.catAndNumXList,
        this.totalPages,
        this.errorCode,
        this.brandList,
        this.brandListNum,
        this.catAndNumXListNum,
        this.category,
        this.priceRange,
        this.catLevel});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    searchResult = json['searchResult'] != null
        ? new SearchResult.fromJson(json['searchResult'])
        : null;
    curPage = json['curPage'];
    if (json['catAndNumXList'] != null) {
      catAndNumXList = new List<CatAndNumXList>();
      json['catAndNumXList'].forEach((v) {
        catAndNumXList.add(new CatAndNumXList.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    errorCode = json['errorCode'];
    if (json['brandList'] != null) {
      brandList = new List<BrandList>();
      json['brandList'].forEach((v) {
        brandList.add(new BrandList.fromJson(v));
      });
    }
    brandListNum = json['brandListNum'];
    catAndNumXListNum = json['catAndNumXListNum'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    priceRange = json['priceRange'] != null
        ? new PriceRange.fromJson(json['priceRange'])
        : null;
    catLevel = json['catLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchResult != null) {
      data['searchResult'] = this.searchResult.toJson();
    }
    data['curPage'] = this.curPage;
    if (this.catAndNumXList != null) {
      data['catAndNumXList'] =
          this.catAndNumXList.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['errorCode'] = this.errorCode;
    if (this.brandList != null) {
      data['brandList'] = this.brandList.map((v) => v.toJson()).toList();
    }
    data['brandListNum'] = this.brandListNum;
    data['catAndNumXListNum'] = this.catAndNumXListNum;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange.toJson();
    }
    data['catLevel'] = this.catLevel;
    return data;
  }
}

class SearchResult {
  int recordCount;
  String brandlogo;
  String branddescription;
  List<SpuList> spuList;
  int itemCode;

  SearchResult(
      {this.recordCount,
        this.brandlogo,
        this.branddescription,
        this.spuList,
        this.itemCode});

  SearchResult.fromJson(Map<String, dynamic> json) {
    recordCount = json['recordCount'];
    brandlogo = json['brandlogo'];
    branddescription = json['branddescription'];
    if (json['spuList'] != null) {
      spuList = new List<SpuList>();
      json['spuList'].forEach((v) {
        spuList.add(new SpuList.fromJson(v));
      });
    }
    itemCode = json['itemCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordCount'] = this.recordCount;
    data['brandlogo'] = this.brandlogo;
    data['branddescription'] = this.branddescription;
    if (this.spuList != null) {
      data['spuList'] = this.spuList.map((v) => v.toJson()).toList();
    }
    data['itemCode'] = this.itemCode;
    return data;
  }
}

class SpuList {
  int spuId;
  String spu_Name;
  int skuNum;
  String title;
  String categoryName1;
  String brand;
  String cityName;
  List<String> spuimages;
  String priceRange;
  String spuName;
  int stock;
  String activityType;

  SpuList(
      {this.spuId,
        this.spu_Name,
        this.skuNum,
        this.title,
        this.categoryName1,
        this.brand,
        this.cityName,
        this.spuimages,
        this.priceRange,
        this.spuName,
        this.stock,
        this.activityType});

  SpuList.fromJson(Map<String, dynamic> json) {
    spuId = json['spu_id'];
    spu_Name = json['spu_name'];
    skuNum = json['skuNum'];
    title = json['title'];
    categoryName1 = json['category_name1'];
    brand = json['brand'];
    cityName = json['cityName'];
    priceRange = json['priceRange'];
    if(json['spuimages'] != null){
      spuimages = new List<String>();
      json['spuimages'].forEach((v) {
        spuimages.add(v);
      });
    }
    spuName = json['spuName'];
    stock = json['stock'];
    activityType = json['activityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spu_id'] = this.spuId;
    data['spu_name'] = this.spu_Name;
    data['skuNum'] = this.skuNum;
    data['title'] = this.title;
    data['category_name1'] = this.categoryName1;
    data['brand'] = this.brand;
    data['cityName'] = this.cityName;
    data['spuimages'] = this.spuimages;
    data['priceRange'] = this.priceRange;
    data['spuName'] = this.spuName;
    data['stock'] = this.stock;
    data['activityType'] = this.activityType;
    return data;
  }
}

class CatAndNumXList {
  int categoryId;
  int category1Id;
  int category2Id;
  String categoryName;
  Null categoryName1;
  Null categoryName2;

  CatAndNumXList(
      {this.categoryId,
        this.category1Id,
        this.category2Id,
        this.categoryName,
        this.categoryName1,
        this.categoryName2});

  CatAndNumXList.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    category1Id = json['category1_id'];
    category2Id = json['category2_id'];
    categoryName = json['category_name'];
    categoryName1 = json['category_name1'];
    categoryName2 = json['category_name2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category1_id'] = this.category1Id;
    data['category2_id'] = this.category2Id;
    data['category_name'] = this.categoryName;
    data['category_name1'] = this.categoryName1;
    data['category_name2'] = this.categoryName2;
    return data;
  }
}

class BrandList {
  List<String> a;
  List<String> b;
  List<String> c;
  List<String> d;
  List<String> f;
  List<String> g;
  List<String> h;
  List<String> j;
  List<String> k;
  List<String> l;
  List<String> m;
  List<String> n;
  List<String> o;
  List<String> q;
  List<String> r;
  List<String> s;
  List<String> t;
  List<String> w;
  List<String> x;
  List<String> y;
  List<String> z;

  BrandList(
      {this.a,
        this.b,
        this.c,
        this.d,
        this.f,
        this.g,
        this.h,
        this.j,
        this.k,
        this.l,
        this.m,
        this.n,
        this.o,
        this.q,
        this.r,
        this.s,
        this.t,
        this.w,
        this.x,
        this.y,
        this.z});

  BrandList.fromJson(Map<String, dynamic> json) {
    a = json['A'].cast<String>();
    b = json['B'].cast<String>();
    c = json['C'].cast<String>();
    d = json['D'].cast<String>();
    f = json['F'].cast<String>();
    g = json['G'].cast<String>();
    h = json['H'].cast<String>();
    j = json['J'].cast<String>();
    k = json['K'].cast<String>();
    l = json['L'].cast<String>();
    m = json['M'].cast<String>();
    n = json['N'].cast<String>();
    o = json['O'].cast<String>();
    q = json['Q'].cast<String>();
    r = json['R'].cast<String>();
    s = json['S'].cast<String>();
    t = json['T'].cast<String>();
    w = json['W'].cast<String>();
    x = json['X'].cast<String>();
    y = json['Y'].cast<String>();
    z = json['Z'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    data['F'] = this.f;
    data['G'] = this.g;
    data['H'] = this.h;
    data['J'] = this.j;
    data['K'] = this.k;
    data['L'] = this.l;
    data['M'] = this.m;
    data['N'] = this.n;
    data['O'] = this.o;
    data['Q'] = this.q;
    data['R'] = this.r;
    data['S'] = this.s;
    data['T'] = this.t;
    data['W'] = this.w;
    data['X'] = this.x;
    data['Y'] = this.y;
    data['Z'] = this.z;
    return data;
  }
}

class Category {
  int categoryId;
  int category1Id;
  int category2Id;
  String categoryName;
  String categoryName1;
  String categoryName2;

  Category(
      {this.categoryId,
        this.category1Id,
        this.category2Id,
        this.categoryName,
        this.categoryName1,
        this.categoryName2});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    category1Id = json['category1_id'];
    category2Id = json['category2_id'];
    categoryName = json['category_name'];
    categoryName1 = json['category_name1'];
    categoryName2 = json['category_name2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category1_id'] = this.category1Id;
    data['category2_id'] = this.category2Id;
    data['category_name'] = this.categoryName;
    data['category_name1'] = this.categoryName1;
    data['category_name2'] = this.categoryName2;
    return data;
  }
}

class PriceRange {
  String attributeName;
  List<AttributeValueXList> attributeValueXList;

  PriceRange({this.attributeName, this.attributeValueXList});

  PriceRange.fromJson(Map<String, dynamic> json) {
    attributeName = json['attribute_name'];
    if (json['attributeValueXList'] != null) {
      attributeValueXList = new List<AttributeValueXList>();
      json['attributeValueXList'].forEach((v) {
        attributeValueXList.add(new AttributeValueXList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_name'] = this.attributeName;
    if (this.attributeValueXList != null) {
      data['attributeValueXList'] =
          this.attributeValueXList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeValueXList {
  String attriValue;

  AttributeValueXList({this.attriValue});

  AttributeValueXList.fromJson(Map<String, dynamic> json) {
    attriValue = json['attri_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attri_value'] = this.attriValue;
    return data;
  }
}