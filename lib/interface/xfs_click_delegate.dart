/// Created by liuwei
/// on 2020-09-07
/// page xfs_item_delegate

abstract class XFSClickDelegate{

  /// item点击事件回调方法
  /// [section] 分区
  /// [row]     行数
  /// [clickType]  点击事件的类型
  /// [data]  传参
  /// [data1] 传参
  void didSelectCell({ int clickType, dynamic data, dynamic data1});

}