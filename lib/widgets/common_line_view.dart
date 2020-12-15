import 'package:flutter_facebook/config/xfs_header.dart';

///
///       创建时间：2020/12/14
///       修改人  ：zhangyan
///       描述    ：
///

class CommonLineView extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const CommonLineView({Key key, @required this.color, this.height, this.width,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height:height??1,
      width: width??double.infinity,
      color: color,
      child: Divider(color: color,),
    );
  }
}








      