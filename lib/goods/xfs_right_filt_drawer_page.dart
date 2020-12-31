import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/XFSGoodsFiltModel.dart';
import 'package:flutter_facebook/models/search_result_model.dart';
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

  XFSRightFiltDrawerPage(
      {Key key, this.filtrateModel, this.confirmCallback, this.resetCallback})
      : super(key: key);

  @override
  _XFSRightFiltDrawerPageState createState() => _XFSRightFiltDrawerPageState();
}

class _XFSRightFiltDrawerPageState extends State<XFSRightFiltDrawerPage> {
  XFSGoodsFiltModel _filtrateModel;
  List<String> _listBrand = ["C罗", "梅西", "内马尔", "萨拉赫"];
  List<CatAndNumXList> _listCategory = [];
  // List<CatAndNumXList> _listCategory = [];
  List<String> _select = [];
  String _choice = "";
  var storeName;
  var shipAddId;
  TextEditingController _editingLowerPriceController;
  TextEditingController _editinghighterPriceController;

  @override
  void initState() {
    super.initState();
    _filtrateModel = widget.filtrateModel;
    storeName = _filtrateModel.storeName??"不限门店";
    shipAddId = _filtrateModel.shipAddId??"";
    _listBrand = _filtrateModel.brandStringList??[];
    _listCategory = _filtrateModel.categoryList??[];
    _editingLowerPriceController =
        TextEditingController(text: _filtrateModel.lowPrice ?? "");
    _editinghighterPriceController =
        TextEditingController(text: _filtrateModel.heightPrice ?? "");
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
                _buildFiltChip(),
                _buildChoiceChip(),
                XFSText('价格'),
                XFSContainer(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    _buildEditTextView('请输入最低价', _editingLowerPriceController),
                    XFSText(
                      '-',
                      margin: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    _buildEditTextView(
                        '请输入最高价', _editinghighterPriceController),
                  ]),
                ),
                XFSText('门店'),
                XFSContainer(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Flexible(flex: 1, child: XFSText('$storeName')),
                    XFSTextButton.icon(
                      title: '重新选择',
                      icon: Icon(Icons.chevron_right),
                      direction: XFSTextButtonIconTextDirection.textLIconR,
                    ),
                  ]),
                  onTap: () {
                    Navigator.pushNamed(
                            context, XFSAppRouteConfigure.xFSStoreChoicePage,
                            arguments: shipAddId)
                        .then((value) {
                      if (value != null) {
                        var xfsRaiseModel = (value as xfsSelfRaiseSearchModel);
                        _filtrateModel.storeName = xfsRaiseModel.add_alias;
                        _filtrateModel.shipAddId = xfsRaiseModel.ship_add_id;
                        storeName = xfsRaiseModel.add_alias;
                        shipAddId = xfsRaiseModel.ship_add_id;
                      } else {
                        _filtrateModel.storeName = "不限门店";
                      }
                      setState(() {});
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

  Widget _bottomView() {
    return Container(
      height: 49,
      child: Row(
        children: <Widget>[
          Expanded(
            child: XFSText(
              '重置',
              backgroudColor: Config.colorF4F4F4,
              alignment: Alignment.center,
              textColor: Config.color333333,
              fontSize: 16,
              onTap: () {
                resetData();
              },
            ),
          ),
          Expanded(
            child: XFSText(
              '确认',
              backgroudColor: Config.colorFFA200,
              alignment: Alignment.center,
              textColor: Colors.white,
              fontSize: 16,
              onTap: () {
                Navigator.pop(context);
                if (widget.confirmCallback != null) {
                  widget.confirmCallback(_filtrateModel);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void resetData() {
    // widget.filtrateModel = XFSSuggestFiltrateModel();
    // _filtrateModel = widget.filtrateModel;
    // if (widget.resetCallback != null){
    //   widget.resetCallback(_filtrateModel);
    // }
    Fluttertoast.showToast(msg: '重置');
    _choice="";
    _select=[];
    setState(() {});
  }

  _buildEditTextView(
      String hintText, TextEditingController textEditingController) {
    return Flexible(
        flex: 1,
        child: XFSContainer(
            padding: EdgeInsets.all(10),
            backgroundColor: Config.colorEFEFF4,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: XFSTextField(
                onChanged: (value) {
                  if (hintText == '请输入最低价') {
                    _filtrateModel.lowPrice = value;
                  } else if (hintText == '请输入最高价') {
                    _filtrateModel.heightPrice = value;
                  }
                },
                controller: textEditingController,
                hintText: '$hintText',
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number)));
  }
///单选 分类
  _buildChoiceChip() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text("分类：$_choice"),
        ),
        Wrap(
            spacing: 20,
            children: _listCategory.map((it) {
              return ChoiceChip(
                label: Text(it.categoryName),
                selectedColor: Colors.pink,
                selected: _choice == it.categoryName,
                onSelected: (value) {
                  setState(() {
                    if(_choice ==it.categoryName){
                      _choice='';
                    }else
                    _choice = it.categoryName;
                  });
                },
              );
            }).toList()),
      ],
    );
  }
///多选 品牌
  _buildFiltChip() {
    return Column(
        children: [
          Container(
            width: double.infinity,
            child:   Text("品牌：$_select"),
          ),
          Wrap(
              spacing: 20,
              children: _listBrand.map((it) {
                return ChoiceChip(
                  label: Text(it),
                  selectedColor: Colors.pink,
                  selected:  _select.contains(it),
                  onSelected: (value) {
                    setState(() {
                      if (_select.contains(it)) {
                        _select.remove(it);
                      } else {
                        _select.add(it);
                      }
                    });
                  },
                );
              }).toList()),
    ]);
  }
}
