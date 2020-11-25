class CategoryModel {
  String errorCode;
  String errorMessage;
  List<Data> data;

  CategoryModel({this.errorCode, this.errorMessage, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMessage'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int frontFirstCategoryId;
  String pictureUrl;
  String displayContent;
  int showSequence;
  int source;
  int platform;
  int warehouse;
  List<RelationFirstLevelObject> relationFirstLevelObject;
  List<Null> linkedObj;

  Data(
      {this.frontFirstCategoryId,
        this.pictureUrl,
        this.displayContent,
        this.showSequence,
        this.source,
        this.platform,
        this.warehouse,
        this.relationFirstLevelObject,
        this.linkedObj});

  Data.fromJson(Map<String, dynamic> json) {
    frontFirstCategoryId = json['frontFirstCategoryId'];
    pictureUrl = json['pictureUrl'];
    displayContent = json['displayContent'];
    showSequence = json['showSequence'];
    source = json['source'];
    platform = json['platform'];
    warehouse = json['warehouse'];
    if (json['relationFirstLevelObject'] != null) {
      relationFirstLevelObject = new List<RelationFirstLevelObject>();
      json['relationFirstLevelObject'].forEach((v) {
        relationFirstLevelObject.add(new RelationFirstLevelObject.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frontFirstCategoryId'] = this.frontFirstCategoryId;
    data['pictureUrl'] = this.pictureUrl;
    data['displayContent'] = this.displayContent;
    data['showSequence'] = this.showSequence;
    data['source'] = this.source;
    data['platform'] = this.platform;
    data['warehouse'] = this.warehouse;
    if (this.relationFirstLevelObject != null) {
      data['relationFirstLevelObject'] =
          this.relationFirstLevelObject.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class RelationFirstLevelObject {
  int id;
  int frontFirstCategoryId;
  int frontCategoryId;
  String fristCategoryName;
  int showSequence;

  RelationFirstLevelObject(
      {this.id,
        this.frontFirstCategoryId,
        this.frontCategoryId,
        this.fristCategoryName,
        this.showSequence});

  RelationFirstLevelObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frontFirstCategoryId = json['frontFirstCategoryId'];
    frontCategoryId = json['frontCategoryId'];
    fristCategoryName = json['fristCategoryName'];
    showSequence = json['showSequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['frontFirstCategoryId'] = this.frontFirstCategoryId;
    data['frontCategoryId'] = this.frontCategoryId;
    data['fristCategoryName'] = this.fristCategoryName;
    data['showSequence'] = this.showSequence;
    return data;
  }
}

