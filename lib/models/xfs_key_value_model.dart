import 'package:xfs_flutter_utils/widgets/xfs_data_picker.dart';

/// Created by liuwei
/// on 2020-09-22
/// page xfs_key_value_model
/// 键值对model

class XFSKeyValueModel implements XFSDataPickerViewTitle{

  int id;
  String name;

  XFSKeyValueModel({this.id, this.name});

  @override
  String getPickerItemTitle() {
    return name;
  }
}