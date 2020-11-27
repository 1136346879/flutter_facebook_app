
class SubjectModel {
  String id;
  String subId;
  String subName;
  String subTitle;
  int titleHide;
  String subColor;
  int subStatus;
  String userName;
  String createTime;
  String updateTime;
  List<ModelList> modelList;

  SubjectModel(
      {this.id,
        this.subId,
        this.subName,
        this.subTitle,
        this.titleHide,
        this.subColor,
        this.subStatus,
        this.userName,
        this.createTime,
        this.updateTime,
        this.modelList});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['subId'];
    subName = json['subName'];
    subTitle = json['subTitle'];
    titleHide = json['titleHide'];
    subColor = json['subColor'];
    subStatus = json['subStatus'];
    userName = json['userName'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    if (json['modelList'] != null) {
      modelList = new List<ModelList>();
      json['modelList'].forEach((v) {
        modelList.add(new ModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subId'] = this.subId;
    data['subName'] = this.subName;
    data['subTitle'] = this.subTitle;
    data['titleHide'] = this.titleHide;
    data['subColor'] = this.subColor;
    data['subStatus'] = this.subStatus;
    data['userName'] = this.userName;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    if (this.modelList != null) {
      data['modelList'] = this.modelList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelList {
  Null modelId;
  Null subId;
  int modelArrayId;
  Null modelUrl;
  Null picMsg;
  int modelType;
  int modelIndex;
  Null contentIndex;
  Null modelStatus;
  int modelSpace;
  Null placeType;
  Null placeContent;
  Null detailContent;
  Null createTime;
  Null updateTime;
  Null userName;
  List<UrlList> urlList;

  ModelList(
      {this.modelId,
        this.subId,
        this.modelArrayId,
        this.modelUrl,
        this.picMsg,
        this.modelType,
        this.modelIndex,
        this.contentIndex,
        this.modelStatus,
        this.modelSpace,
        this.placeType,
        this.placeContent,
        this.detailContent,
        this.createTime,
        this.updateTime,
        this.userName,
        this.urlList});

  ModelList.fromJson(Map<String, dynamic> json) {
    modelId = json['modelId'];
    subId = json['subId'];
    modelArrayId = json['modelArrayId'];
    modelUrl = json['modelUrl'];
    picMsg = json['picMsg'];
    modelType = json['modelType'];
    modelIndex = json['modelIndex'];
    contentIndex = json['contentIndex'];
    modelStatus = json['modelStatus'];
    modelSpace = json['modelSpace'];
    placeType = json['placeType'];
    placeContent = json['placeContent'];
    detailContent = json['detailContent'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    userName = json['userName'];
    if (json['urlList'] != null) {
      urlList = new List<UrlList>();
      json['urlList'].forEach((v) {
        urlList.add(new UrlList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelId'] = this.modelId;
    data['subId'] = this.subId;
    data['modelArrayId'] = this.modelArrayId;
    data['modelUrl'] = this.modelUrl;
    data['picMsg'] = this.picMsg;
    data['modelType'] = this.modelType;
    data['modelIndex'] = this.modelIndex;
    data['contentIndex'] = this.contentIndex;
    data['modelStatus'] = this.modelStatus;
    data['modelSpace'] = this.modelSpace;
    data['placeType'] = this.placeType;
    data['placeContent'] = this.placeContent;
    data['detailContent'] = this.detailContent;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['userName'] = this.userName;
    if (this.urlList != null) {
      data['urlList'] = this.urlList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UrlList {
  int modelId;
  String subId;
  int modelArrayId;
  String modelUrl;
  String picMsg;
  int modelType;
  int modelIndex;
  int contentIndex;
  int modelStatus;
  int modelSpace;
  int placeType;
  String placeContent;
  Null detailContent;
  String createTime;
  String updateTime;
  Null userName;
  String productTitle;
  Null productSubTitle;
  double productPrice;
  String picHeight;
  String picWidth;

  UrlList(
      {this.modelId,
        this.subId,
        this.modelArrayId,
        this.modelUrl,
        this.picMsg,
        this.modelType,
        this.modelIndex,
        this.contentIndex,
        this.modelStatus,
        this.modelSpace,
        this.placeType,
        this.placeContent,
        this.detailContent,
        this.createTime,
        this.updateTime,
        this.userName,
        this.productTitle,
        this.productSubTitle,
        this.productPrice,
        this.picHeight,
        this.picWidth});

  UrlList.fromJson(Map<String, dynamic> json) {
    modelId = json['modelId'];
    subId = json['subId'];
    modelArrayId = json['modelArrayId'];
    modelUrl = json['modelUrl'];
    picMsg = json['picMsg'];
    modelType = json['modelType'];
    modelIndex = json['modelIndex'];
    contentIndex = json['contentIndex'];
    modelStatus = json['modelStatus'];
    modelSpace = json['modelSpace'];
    placeType = json['placeType'];
    placeContent = json['placeContent'];
    detailContent = json['detailContent'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    userName = json['userName'];
    productTitle = json['productTitle'];
    productSubTitle = json['productSubTitle'];
    productPrice = json['productPrice'];
    picHeight = json['picHeight'];
    picWidth = json['picWidth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelId'] = this.modelId;
    data['subId'] = this.subId;
    data['modelArrayId'] = this.modelArrayId;
    data['modelUrl'] = this.modelUrl;
    data['picMsg'] = this.picMsg;
    data['modelType'] = this.modelType;
    data['modelIndex'] = this.modelIndex;
    data['contentIndex'] = this.contentIndex;
    data['modelStatus'] = this.modelStatus;
    data['modelSpace'] = this.modelSpace;
    data['placeType'] = this.placeType;
    data['placeContent'] = this.placeContent;
    data['detailContent'] = this.detailContent;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['userName'] = this.userName;
    data['productTitle'] = this.productTitle;
    data['productSubTitle'] = this.productSubTitle;
    data['productPrice'] = this.productPrice;
    data['picHeight'] = this.picHeight;
    data['picWidth'] = this.picWidth;
    return data;
  }
}