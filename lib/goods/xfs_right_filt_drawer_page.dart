import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/XFSGoodsFiltModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

///
///       创建时间：2020/12/28
///       修改人  ：zhangyan
///       描述    ：
///
///
class XFSRightFiltDrawerPage extends StatefulWidget {
  /// 筛选model
  XFSGoodsFiltModel filtrateModel;
  final Function(XFSGoodsFiltModel) confirmCallback;
  final Function(XFSGoodsFiltModel) resetCallback;

   XFSRightFiltDrawerPage({Key key, this.filtrateModel, this.confirmCallback, this.resetCallback}) : super(key: key);
  @override
  _XFSRightFiltDrawerPageState createState() => _XFSRightFiltDrawerPageState();
}

class _XFSRightFiltDrawerPageState extends State<XFSRightFiltDrawerPage> {
  XFSGoodsFiltModel _filtrateModel;
  @override
  void initState() {
    super.initState();
    _filtrateModel = widget.filtrateModel;
  }

  @override
  Widget build(BuildContext context) {
    return XFSDrawer(
      width: XFSScreenUtil.getScreenW(context) - 31,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                XFSText('品牌'),
                XFSText('分类'),
                XFSText('价格'),
                XFSText('门店'),
              ],
            ),
          ),
          _bottomView(),
        ],
      ),
    );
  }
  Widget _bottomView(){
    return Container(
      height: 49,
      child: Row(
        children: <Widget>[
          Expanded(
            child: XFSText('重置',
              backgroudColor: Config.colorF4F4F4,
              alignment: Alignment.center,
              textColor:Config.color333333,
              fontSize: 16,
              onTap: (){
                resetData();
              },
            ),
          ),
          Expanded(
            child: XFSText('确认',
              backgroudColor: Config.colorFFA200,
              alignment: Alignment.center,
              textColor: Colors.white,
              fontSize: 16,
              onTap: (){
                Navigator.pop(context);
                if (widget.confirmCallback != null){
                  widget.confirmCallback(_filtrateModel);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void resetData(){
    // widget.filtrateModel = XFSSuggestFiltrateModel();
    // _filtrateModel = widget.filtrateModel;
    // if (widget.resetCallback != null){
    //   widget.resetCallback(_filtrateModel);
    // }
    Fluttertoast.showToast(msg: '重置');
    setState(() {});
  }
}







      