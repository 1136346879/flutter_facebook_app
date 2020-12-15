

class GoodsDetailModel {
  num volumeSmall;
  String guaranteePeriod;
  String specifications;
  int isActivityBegin;
  String retailPrice;
  String partsNumber;
  int isTranPrice;
  num miniOrder;
  String customerType;
  int platformType;
  int numberDecimal;
  String price;
  String qrUrl;
  String skuName;
  String model;
  int spuId;
  String lastShelfTime;
  num maxLength;
  String unitLarge;
  int isExistSku;
  List<Images> images;
  num virtualStock;
  num maxLengthSmall;
  String subLengthLarge;
  String upperStock;
  String specifyPrice;
  num weight;
  int skuId;
  String brandName;
  String productNumber;
  String numberLarge;
  int brandId;
  String standards;
  num subLength;
  num volume;
  String numberRedium;
  String unit;
  String warehouseName;
  String name;
  String skuCode;
  num subLengthSmall;
  String numberSmall;
  num minLengthRedium;
  String color;
  num minLengthSmall;
  String liabilityPeriod;
  String unitSmall;
  num distributionPrice;
  String origin;
  int saleType;
  String packList;
  String weightLarge;
  String productCode;
  num actualStock;
  int orderLimitType;
  int onActivitySku;
  num maxLengthRedium;
  String unitRedium;
  int salesStatus;
  num weightRedium;
  int categoryId;
  String saleAttriValue;
  int isSignTranPrice;
  String subtitile;
  List<Alias> alias;
  String helpcode;
  String unitId;
  String revenueCode;
  int arrivalCycle;
  String costPrice;
  int isShowPrice;
  num minLength;
  String spuCode;
  num weightSmall;
  int isSpecifyPrice;
  String volumeLarge;
  String showPrice;
  num subLengthRedium;
  String salePrice;
  String miniBuyCount;
  List<String> categroyNames;
  int restricted;
  String maxLengthLarge;
  String minLengthLarge;
  String internationalBarcodeEan;
  num volumeRedium;
  int warehouseId;
  String lowerStock;

  GoodsDetailModel(
      {this.volumeSmall,
        this.guaranteePeriod,
        this.specifications,
        this.isActivityBegin,
        this.retailPrice,
        this.partsNumber,
        this.isTranPrice,
        this.miniOrder,
        this.customerType,
        this.platformType,
        this.numberDecimal,
        this.price,
        this.qrUrl,
        this.skuName,
        this.model,
        this.spuId,
        this.lastShelfTime,
        this.maxLength,
        this.unitLarge,
        this.isExistSku,
        this.images,
        this.virtualStock,
        this.maxLengthSmall,
        this.subLengthLarge,
        this.upperStock,
        this.specifyPrice,
        this.weight,
        this.skuId,
        this.brandName,
        this.productNumber,
        this.numberLarge,
        this.brandId,
        this.standards,
        this.subLength,
        this.volume,
        this.numberRedium,
        this.unit,
        this.warehouseName,
        this.name,
        this.skuCode,
        this.subLengthSmall,
        this.numberSmall,
        this.minLengthRedium,
        this.color,
        this.minLengthSmall,
        this.liabilityPeriod,
        this.unitSmall,
        this.distributionPrice,
        this.origin,
        this.saleType,
        this.packList,
        this.weightLarge,
        this.productCode,
        this.actualStock,
        this.orderLimitType,
        this.onActivitySku,
        this.maxLengthRedium,
        this.unitRedium,
        this.salesStatus,
        this.weightRedium,
        this.categoryId,
        this.saleAttriValue,
        this.isSignTranPrice,
        this.subtitile,
        this.alias,
        this.helpcode,
        this.unitId,
        this.revenueCode,
        this.arrivalCycle,
        this.costPrice,
        this.isShowPrice,
        this.minLength,
        this.spuCode,
        this.weightSmall,
        this.isSpecifyPrice,
        this.volumeLarge,
        this.showPrice,
        this.subLengthRedium,
        this.salePrice,
        this.miniBuyCount,
        this.categroyNames,
        this.restricted,
        this.maxLengthLarge,
        this.minLengthLarge,
        this.internationalBarcodeEan,
        this.volumeRedium,
        this.warehouseId,
        this.lowerStock});

  GoodsDetailModel.fromJson(Map<String, dynamic> json) {
    volumeSmall = json['volume_small'];
    guaranteePeriod = json['guarantee_period'];
    specifications = json['specifications'];
    isActivityBegin = json['isActivityBegin'];
    retailPrice = json['retail_price'];
    partsNumber = json['parts_number'];
    isTranPrice = json['is_tran_price'];
    miniOrder = json['mini_order'];
    customerType = json['customerType'];
    platformType = json['platform_type'];
    numberDecimal = json['number_decimal'];
    price = json['price'];
    qrUrl = json['qr_url'];
    skuName = json['sku_name'];
    model = json['model'];
    spuId = json['spu_id'];
    lastShelfTime = json['last_shelf_time'];
    maxLength = json['max_length'];
    unitLarge = json['unit_large'];
    isExistSku = json['is_exist_sku'];
    if (json['images'] != String) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    virtualStock = json['virtual_stock'];
    maxLengthSmall = json['max_length_small'];
    subLengthLarge = json['sub_length_large'];
    upperStock = json['upper_stock'];
    specifyPrice = json['specify_price'];
    weight = json['weight'];
    skuId = json['sku_id'];
    brandName = json['brand_name'];
    productNumber = json['productNumber'];
    numberLarge = json['number_large'];
    brandId = json['brand_id'];
    standards = json['standards'];
    subLength = json['sub_length'];
    volume = json['volume'];
    numberRedium = json['number_redium'];
    unit = json['unit'];
    warehouseName = json['warehouse_name'];
    name = json['name'];
    skuCode = json['sku_code'];
    subLengthSmall = json['sub_length_small'];
    numberSmall = json['number_small'];
    minLengthRedium = json['min_length_redium'];
    color = json['color'];
    minLengthSmall = json['min_length_small'];
    liabilityPeriod = json['liability_period'];
    unitSmall = json['unit_small'];
    distributionPrice = json['distribution_price'];
    origin = json['origin'];
    saleType = json['sale_type'];
    packList = json['pack_list'];
    weightLarge = json['weight_large'];
    productCode = json['product_code'];
    actualStock = json['actual_stock'];
    orderLimitType = json['order_limit_type'];
    onActivitySku = json['onActivitySku'];
    maxLengthRedium = json['max_length_redium'];
    unitRedium = json['unit_redium'];
    salesStatus = json['sales_status'];
    weightRedium = json['weight_redium'];
    categoryId = json['category_id'];
    saleAttriValue = json['sale_attri_value'];
    isSignTranPrice = json['is_sign_tran_price'];
    subtitile = json['subtitile'];
    if (json['alias'] != String) {
      alias = new List<Alias>();
      json['alias'].forEach((v) {
        alias.add(new Alias.fromJson(v));
      });
    }
    helpcode = json['helpcode'];
    unitId = json['unit_id'];
    revenueCode = json['revenue_code'];
    arrivalCycle = json['arrival_cycle'];
    costPrice = json['cost_price'];
    isShowPrice = json['is_show_price'];
    minLength = json['min_length'];
    spuCode = json['spu_code'];
    weightSmall = json['weight_small'];
    isSpecifyPrice = json['is_specify_price'];
    volumeLarge = json['volume_large'];
    showPrice = json['show_price'];
    subLengthRedium = json['sub_length_redium'];
    salePrice = json['sale_price'];
    miniBuyCount = json['mini_buy_count'];
    categroyNames = json['categroyNames'].cast<String>();
    restricted = json['restricted'];
    maxLengthLarge = json['max_length_large'];
    minLengthLarge = json['min_length_large'];
    internationalBarcodeEan = json['international_barcode_ean'];
    volumeRedium = json['volume_redium'];
    warehouseId = json['warehouse_id'];
    lowerStock = json['lower_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['volume_small'] = this.volumeSmall;
    data['guarantee_period'] = this.guaranteePeriod;
    data['specifications'] = this.specifications;
    data['isActivityBegin'] = this.isActivityBegin;
    data['retail_price'] = this.retailPrice;
    data['parts_number'] = this.partsNumber;
    data['is_tran_price'] = this.isTranPrice;
    data['mini_order'] = this.miniOrder;
    data['customerType'] = this.customerType;
    data['platform_type'] = this.platformType;
    data['number_decimal'] = this.numberDecimal;
    data['price'] = this.price;
    data['qr_url'] = this.qrUrl;
    data['sku_name'] = this.skuName;
    data['model'] = this.model;
    data['spu_id'] = this.spuId;
    data['last_shelf_time'] = this.lastShelfTime;
    data['max_length'] = this.maxLength;
    data['unit_large'] = this.unitLarge;
    data['is_exist_sku'] = this.isExistSku;
    if (this.images != String) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['virtual_stock'] = this.virtualStock;
    data['max_length_small'] = this.maxLengthSmall;
    data['sub_length_large'] = this.subLengthLarge;
    data['upper_stock'] = this.upperStock;
    data['specify_price'] = this.specifyPrice;
    data['weight'] = this.weight;
    data['sku_id'] = this.skuId;
    data['brand_name'] = this.brandName;
    data['productNumber'] = this.productNumber;
    data['number_large'] = this.numberLarge;
    data['brand_id'] = this.brandId;
    data['standards'] = this.standards;
    data['sub_length'] = this.subLength;
    data['volume'] = this.volume;
    data['number_redium'] = this.numberRedium;
    data['unit'] = this.unit;
    data['warehouse_name'] = this.warehouseName;
    data['name'] = this.name;
    data['sku_code'] = this.skuCode;
    data['sub_length_small'] = this.subLengthSmall;
    data['number_small'] = this.numberSmall;
    data['min_length_redium'] = this.minLengthRedium;
    data['color'] = this.color;
    data['min_length_small'] = this.minLengthSmall;
    data['liability_period'] = this.liabilityPeriod;
    data['unit_small'] = this.unitSmall;
    data['distribution_price'] = this.distributionPrice;
    data['origin'] = this.origin;
    data['sale_type'] = this.saleType;
    data['pack_list'] = this.packList;
    data['weight_large'] = this.weightLarge;
    data['product_code'] = this.productCode;
    data['actual_stock'] = this.actualStock;
    data['order_limit_type'] = this.orderLimitType;
    data['onActivitySku'] = this.onActivitySku;
    data['max_length_redium'] = this.maxLengthRedium;
    data['unit_redium'] = this.unitRedium;
    data['sales_status'] = this.salesStatus;
    data['weight_redium'] = this.weightRedium;
    data['category_id'] = this.categoryId;
    data['sale_attri_value'] = this.saleAttriValue;
    data['is_sign_tran_price'] = this.isSignTranPrice;
    data['subtitile'] = this.subtitile;
    if (this.alias != String) {
      data['alias'] = this.alias.map((v) => v.toJson()).toList();
    }
    data['helpcode'] = this.helpcode;
    data['unit_id'] = this.unitId;
    data['revenue_code'] = this.revenueCode;
    data['arrival_cycle'] = this.arrivalCycle;
    data['cost_price'] = this.costPrice;
    data['is_show_price'] = this.isShowPrice;
    data['min_length'] = this.minLength;
    data['spu_code'] = this.spuCode;
    data['weight_small'] = this.weightSmall;
    data['is_specify_price'] = this.isSpecifyPrice;
    data['volume_large'] = this.volumeLarge;
    data['show_price'] = this.showPrice;
    data['sub_length_redium'] = this.subLengthRedium;
    data['sale_price'] = this.salePrice;
    data['mini_buy_count'] = this.miniBuyCount;
    data['categroyNames'] = this.categroyNames;
    data['restricted'] = this.restricted;
    data['max_length_large'] = this.maxLengthLarge;
    data['min_length_large'] = this.minLengthLarge;
    data['international_barcode_ean'] = this.internationalBarcodeEan;
    data['volume_redium'] = this.volumeRedium;
    data['warehouse_id'] = this.warehouseId;
    data['lower_stock'] = this.lowerStock;
    return data;
  }
}

class Images {
  String imgType;
  String spuCode;
  String imgCode;
  String lastModifiedDate;
  int imgId;
  String creationDate;
  int lastModifiedBy;
  int imgSort;
  String creationBy;
  String imgName;
  String imgUrl;
  int spuImgId;
  int spuId;
  int status;
  int skuId;
  int skuImgId;
  String skuCode;

  Images(
      {this.imgType,
        this.spuCode,
        this.imgCode,
        this.lastModifiedDate,
        this.imgId,
        this.creationDate,
        this.lastModifiedBy,
        this.imgSort,
        this.creationBy,
        this.imgName,
        this.imgUrl,
        this.spuImgId,
        this.spuId,
        this.status,
        this.skuId,
        this.skuImgId,
        this.skuCode});

  Images.fromJson(Map<String, dynamic> json) {
    imgType = json['img_type'];
    spuCode = json['spu_code'];
    imgCode = json['img_code'];
    lastModifiedDate = json['last_modified_date'];
    imgId = json['img_id'];
    creationDate = json['creation_date'];
    lastModifiedBy = json['last_modified_by'];
    imgSort = json['img_sort'];
    creationBy = json['creation_by'];
    imgName = json['img_name'];
    imgUrl = json['img_url'];
    spuImgId = json['spu_img_id'];
    spuId = json['spu_id'];
    status = json['status'];
    skuId = json['sku_id'];
    skuImgId = json['sku_img_id'];
    skuCode = json['sku_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_type'] = this.imgType;
    data['spu_code'] = this.spuCode;
    data['img_code'] = this.imgCode;
    data['last_modified_date'] = this.lastModifiedDate;
    data['img_id'] = this.imgId;
    data['creation_date'] = this.creationDate;
    data['last_modified_by'] = this.lastModifiedBy;
    data['img_sort'] = this.imgSort;
    data['creation_by'] = this.creationBy;
    data['img_name'] = this.imgName;
    data['img_url'] = this.imgUrl;
    data['spu_img_id'] = this.spuImgId;
    data['spu_id'] = this.spuId;
    data['status'] = this.status;
    data['sku_id'] = this.skuId;
    data['sku_img_id'] = this.skuImgId;
    data['sku_code'] = this.skuCode;
    return data;
  }
}

class Alias {
  int spuId;
  String aliasValue;

  Alias({this.spuId, this.aliasValue});

  Alias.fromJson(Map<String, dynamic> json) {
    spuId = json['spu_id'];
    aliasValue = json['alias_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spu_id'] = this.spuId;
    data['alias_value'] = this.aliasValue;
    return data;
  }
}

class SectePrice {
  String maxPrice;
  String minPrice;

  SectePrice({this.maxPrice, this.minPrice});

  SectePrice.fromJson(Map<String, dynamic> json) {
    maxPrice = json['max_price'];
    minPrice = json['min_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_price'] = this.maxPrice;
    data['min_price'] = this.minPrice;
    return data;
  }
}