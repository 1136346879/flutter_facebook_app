

class BannerModel {
  int total;
  int totalPage;
  int pageNumber;
  int pageSize;
  int startIndex;
  List<BannerModelData> data;

  BannerModel(
      {this.total,
        this.totalPage,
        this.pageNumber,
        this.pageSize,
        this.startIndex,
        this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    startIndex = json['startIndex'];
    if (json['data'] != null) {
      data = new List<BannerModelData>();
      json['data'].forEach((v) {
        data.add(new BannerModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['totalPage'] = this.totalPage;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['startIndex'] = this.startIndex;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerModelData {
  int picId;
  String picTitle;
  String picUrl;
  int picStatus;
  int picOrder;
  int platform;
  String startTime;
  String endTime;
  int isRetailCustomer;
  int placeType;
  String placeContent;
  String detailContent;
  int isDelete;
  String userName;
  String createTime;
  String updateTime;
  List<int> areaList;
  Null picIds;
  Null source;
  int pageNum;
  int pageSize;
  int startIndex;
  int afterFrom;

  BannerModelData(
      {this.picId,
        this.picTitle,
        this.picUrl,
        this.picStatus,
        this.picOrder,
        this.platform,
        this.startTime,
        this.endTime,
        this.isRetailCustomer,
        this.placeType,
        this.placeContent,
        this.detailContent,
        this.isDelete,
        this.userName,
        this.createTime,
        this.updateTime,
        this.areaList,
        this.picIds,
        this.source,
        this.pageNum,
        this.pageSize,
        this.startIndex,
        this.afterFrom});

  BannerModelData.fromJson(Map<String, dynamic> json) {
    picId = json['picId'];
    picTitle = json['picTitle'];
    picUrl = json['picUrl'];
    picStatus = json['picStatus'];
    picOrder = json['picOrder'];
    platform = json['platform'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isRetailCustomer = json['isRetailCustomer'];
    placeType = json['placeType'];
    placeContent = json['placeContent'];
    detailContent = json['detailContent'];
    isDelete = json['isDelete'];
    userName = json['userName'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    areaList = json['areaList'].cast<int>();
    picIds = json['picIds'];
    source = json['source'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    startIndex = json['startIndex'];
    afterFrom = json['afterFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picId'] = this.picId;
    data['picTitle'] = this.picTitle;
    data['picUrl'] = this.picUrl;
    data['picStatus'] = this.picStatus;
    data['picOrder'] = this.picOrder;
    data['platform'] = this.platform;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isRetailCustomer'] = this.isRetailCustomer;
    data['placeType'] = this.placeType;
    data['placeContent'] = this.placeContent;
    data['detailContent'] = this.detailContent;
    data['isDelete'] = this.isDelete;
    data['userName'] = this.userName;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['areaList'] = this.areaList;
    data['picIds'] = this.picIds;
    data['source'] = this.source;
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['startIndex'] = this.startIndex;
    data['afterFrom'] = this.afterFrom;
    return data;
  }
}
