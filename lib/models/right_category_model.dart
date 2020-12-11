class RightCategoryModel {
  int id;
  int afterCategoryId;
  String fristCategoryName;
  String afterCategoryName;
  int categoryLevel;
  int parentCategoryId;
  int showSequence;
  int source;
  int platform;
  int warehouse;
  int status;
  String categoryCode;
  Null updateTime;
  List<SecondList> secondList;
  Null frontFirstCategoryId;

  RightCategoryModel(
      {this.id,
        this.afterCategoryId,
        this.fristCategoryName,
        this.afterCategoryName,
        this.categoryLevel,
        this.parentCategoryId,
        this.showSequence,
        this.source,
        this.platform,
        this.warehouse,
        this.status,
        this.categoryCode,
        this.updateTime,
        this.secondList,
        this.frontFirstCategoryId});

  RightCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    afterCategoryId = json['afterCategoryId'];
    fristCategoryName = json['fristCategoryName'];
    afterCategoryName = json['afterCategoryName'];
    categoryLevel = json['categoryLevel'];
    parentCategoryId = json['parentCategoryId'];
    showSequence = json['showSequence'];
    source = json['source'];
    platform = json['platform'];
    warehouse = json['warehouse'];
    status = json['status'];
    categoryCode = json['categoryCode'];
    updateTime = json['updateTime'];
    if (json['secondList'] != null) {
      secondList = new List<SecondList>();
      json['secondList'].forEach((v) {
        secondList.add(new SecondList.fromJson(v));
      });
    }
    frontFirstCategoryId = json['frontFirstCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['afterCategoryId'] = this.afterCategoryId;
    data['fristCategoryName'] = this.fristCategoryName;
    data['afterCategoryName'] = this.afterCategoryName;
    data['categoryLevel'] = this.categoryLevel;
    data['parentCategoryId'] = this.parentCategoryId;
    data['showSequence'] = this.showSequence;
    data['source'] = this.source;
    data['platform'] = this.platform;
    data['warehouse'] = this.warehouse;
    data['status'] = this.status;
    data['categoryCode'] = this.categoryCode;
    data['updateTime'] = this.updateTime;
    if (this.secondList != null) {
      data['secondList'] = this.secondList.map((v) => v.toJson()).toList();
    }
    data['frontFirstCategoryId'] = this.frontFirstCategoryId;
    return data;
  }
}

class SecondList {
  int id;
  int afterCategoryId;
  String fristCategoryName;
  String afterCategoryName;
  int categoryLevel;
  int parentCategoryId;
  int showSequence;
  int source;
  int platform;
  int warehouse;
  int status;
  String categoryCode;
  String updateTime;
  List<SecondListNext> secondList;
  Null frontFirstCategoryId;
  bool expand = false;


  SecondList(
      {this.id,
        this.afterCategoryId,
        this.fristCategoryName,
        this.afterCategoryName,
        this.categoryLevel,
        this.parentCategoryId,
        this.showSequence,
        this.source,
        this.platform,
        this.warehouse,
        this.status,
        this.categoryCode,
        this.updateTime,
        this.secondList,
        this.frontFirstCategoryId});

  SecondList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    afterCategoryId = json['afterCategoryId'];
    fristCategoryName = json['fristCategoryName'];
    afterCategoryName = json['afterCategoryName'];
    categoryLevel = json['categoryLevel'];
    parentCategoryId = json['parentCategoryId'];
    showSequence = json['showSequence'];
    source = json['source'];
    platform = json['platform'];
    expand = json['expand'];
    warehouse = json['warehouse'];
    status = json['status'];
    categoryCode = json['categoryCode'];
    updateTime = json['updateTime'];
    if (json['secondList'] != null) {
      secondList = new List<SecondListNext>();
      json['secondList'].forEach((v) {
        secondList.add(new SecondListNext.fromJson(v));
      });
    }
    frontFirstCategoryId = json['frontFirstCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['afterCategoryId'] = this.afterCategoryId;
    data['fristCategoryName'] = this.fristCategoryName;
    data['afterCategoryName'] = this.afterCategoryName;
    data['categoryLevel'] = this.categoryLevel;
    data['parentCategoryId'] = this.parentCategoryId;
    data['showSequence'] = this.showSequence;
    data['source'] = this.source;
    data['platform'] = this.platform;
    data['warehouse'] = this.warehouse;
    data['status'] = this.status;
    data['categoryCode'] = this.categoryCode;
    data['updateTime'] = this.updateTime;
    if (this.secondList != null) {
      data['secondList'] = this.secondList.map((v) => v.toJson()).toList();
    }
    data['frontFirstCategoryId'] = this.frontFirstCategoryId;
    return data;
  }
}

class SecondListNext{
  int id;
  int afterCategoryId;
  String fristCategoryName;
  String afterCategoryName;
  int categoryLevel;
  int parentCategoryId;
  int showSequence;
  int source;
  int platform;
  int warehouse;
  int status;
  String categoryCode;
  String updateTime;
  Null secondList;
  Null frontFirstCategoryId;
  SecondListNext(
      {this.id,
        this.afterCategoryId,
        this.fristCategoryName,
        this.afterCategoryName,
        this.categoryLevel,
        this.parentCategoryId,
        this.showSequence,
        this.source,
        this.platform,
        this.warehouse,
        this.status,
        this.categoryCode,
        this.updateTime,
        this.secondList,
        this.frontFirstCategoryId});

  SecondListNext.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    afterCategoryId = json['afterCategoryId'];
    fristCategoryName = json['fristCategoryName'];
    afterCategoryName = json['afterCategoryName'];
    categoryLevel = json['categoryLevel'];
    parentCategoryId = json['parentCategoryId'];
    showSequence = json['showSequence'];
    source = json['source'];
    platform = json['platform'];
    warehouse = json['warehouse'];
    status = json['status'];
    categoryCode = json['categoryCode'];
    updateTime = json['updateTime'];
    secondList = json['secondList'];
    frontFirstCategoryId = json['frontFirstCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['afterCategoryId'] = this.afterCategoryId;
    data['fristCategoryName'] = this.fristCategoryName;
    data['afterCategoryName'] = this.afterCategoryName;
    data['categoryLevel'] = this.categoryLevel;
    data['parentCategoryId'] = this.parentCategoryId;
    data['showSequence'] = this.showSequence;
    data['source'] = this.source;
    data['platform'] = this.platform;
    data['warehouse'] = this.warehouse;
    data['status'] = this.status;
    data['categoryCode'] = this.categoryCode;
    data['updateTime'] = this.updateTime;
    data['secondList'] = this.secondList;
    data['frontFirstCategoryId'] = this.frontFirstCategoryId;
    return data;
  }
}