import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/XFSGoodsFiltModel.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

///
///       创建时间：2020/12/28
///       修改人  ：zhangyan
///       描述    ：
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
  TextEditingController _editingLowerPriceController;
  TextEditingController _editinghighterPriceController;
  @override
  void initState() {
    super.initState();
    _filtrateModel = widget.filtrateModel;
    _editingLowerPriceController = TextEditingController(text: _filtrateModel.lowPrice??"");
    _editinghighterPriceController = TextEditingController(text: _filtrateModel.heightPrice??"");
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
                XFSContainer(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      children:[
                        _buildEditTextView('请输入最低价',_editingLowerPriceController),
                        XFSText('-',margin: EdgeInsets.symmetric(horizontal: 5),),
                       _buildEditTextView('请输入最高价',_editinghighterPriceController),
                          ]
                  ),
                ),
                XFSText('门店'),
                XFSContainer(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children:[
                      Flexible(flex:1, child: XFSText('${_filtrateModel.storeName}')),
                      XFSTextButton.icon(title:'重新选择',icon:Icon(Icons.chevron_right),direction: XFSTextButtonIconTextDirection.textLIconR,),
                    ]
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, XFSAppRouteConfigure.xFSStoreChoicePage,arguments: "10").then((value) {
                      if(value!=null){
                        var xfsRaiseModel = (value as xfsSelfRaiseSearchModel);
                        Fluttertoast.showToast(msg: "${xfsRaiseModel.add_alias}");
                        _filtrateModel.storeName =xfsRaiseModel.add_alias;
                      }else{
                        _filtrateModel.storeName ="不限门店";
                      }
                      // setState(() {
                      // });

                    });
                  },
                )
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

  _buildEditTextView(String hintText, TextEditingController textEditingController) {
    return  Flexible(flex:1, child: XFSContainer(
        padding: EdgeInsets.all(10),
        backgroundColor: Config.colorEFEFF4,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: XFSTextField(
          onChanged: (value){
            if(hintText=='请输入最低价'){
              _filtrateModel.lowPrice = value;
            }else if( hintText == '请输入最高价'){
              _filtrateModel.heightPrice =value;
            }
          },
          controller: textEditingController,
            hintText:'$hintText',textAlign: TextAlign.center,keyboardType:TextInputType.number)));

  }
}







      