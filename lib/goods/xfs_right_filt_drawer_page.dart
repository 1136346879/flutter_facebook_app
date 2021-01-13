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
  List<String> _listBrand = [];
  List<String> _listBrandShow = [];
  List<CatAndNumXList> _listCategory = [];
  List<CatAndNumXList> _listCategoryShow = [];

  // List<CatAndNumXList> _listCategory = [];
  List<String> _select = [];
  String _choice = "";
  var storeName;
  var shipAddId;
  bool expandBrand = false;
  bool expandCategory = false;
  TextEditingController _editingLowerPriceController;
  TextEditingController _editinghighterPriceController;

  @override
  void initState() {
    super.initState();
    _filtrateModel = widget.filtrateModel;
    storeName = _filtrateModel.storeName ?? "不限门店";
    shipAddId = _filtrateModel.shipAddId ?? "";
    _listBrandShow = _filtrateModel.brandStringList ?? [];
    _listCategoryShow = _filtrateModel.categoryList ?? [];
    print('长度分别是：：${_listBrandShow.length}---${_listCategoryShow.length}');
    _editingLowerPriceController =
        TextEditingController(text: _filtrateModel.lowPrice ?? "");
    _editinghighterPriceController =
        TextEditingController(text: _filtrateModel.heightPrice ?? "");
  }

  brandList() {
    if (expandBrand || _listBrandShow.length <= 6) {
      _listBrand = _listBrandShow;
    } else {
      _listBrand = _listBrandShow.sublist(0, 6);
    }
    if (expandCategory || _listCategoryShow.length <= 6) {
      _listCategory = _listCategoryShow;
    } else {
      _listCategory = _listCategoryShow.sublist(0, 6);
    }
  }

  @override
  Widget build(BuildContext context) {
    brandList();
    return XFSDrawer(
      width: XFSScreenUtil.getScreenW(context) - 31,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildBrandFiltChip(),
                _buildCategoryChoiceChip(),
                _buildPriceLowerHight(),
                _buildStoreChoice(),
              ],
            ),
          ),
          _bottomView(),
        ],
      ),
    );
  }

  ///底部确认和重置
  Widget _bottomView() {
    return Container(
      height: 49,
      child: Row(
        children: <Widget>[
          Expanded(
            child: XFSText.container(
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
            child: XFSText.container(
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
    _choice = "";
    _select = [];
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
  _buildCategoryChoiceChip() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            children: [
              XFSText.container("分类",padding: EdgeInsets.all(10),),
              Flexible(
                flex: 1,
                child: XFSText.container(
                  "$_choice",
                  padding: EdgeInsets.all(10),
                  maxLines: 1,
                  alignment: Alignment.bottomRight,
                ),
              ),
              Visibility(
                visible: _listCategoryShow.length > 6,
                child: XFSTextButton.icon(
                  onPressed: () {
                    expandCategory = !expandCategory;
                    setState(() {});
                  },
                  icon: Icon(expandCategory
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:10,right: 10),
          child: Wrap(
              spacing: 20,
              children: _listCategory.map((it) {
                return ChoiceChip(
                  label: Text(it.categoryName),
                  selectedColor: Colors.pink,
                  selected: _choice == it.categoryName,
                  onSelected: (value) {
                    setState(() {
                      if (_choice == it.categoryName) {
                        _choice = '';
                      } else
                        _choice = it.categoryName;
                    });
                  },
                );
              }).toList()),
        ),
      ],
    );
  }

  ///多选 品牌
  _buildBrandFiltChip() {
    return Column(children: [
      Container(
        width: double.infinity,
        child: Row(
          children: [
            XFSText.container(
              "品牌",
              margin:EdgeInsets.all(10),
            ),
            Flexible(flex:1,child: XFSText.container("${_select.toString()}",padding:EdgeInsets.all(10),maxLines: 1, alignment: Alignment.bottomRight)),
            Visibility(
              visible: _listBrandShow.length > 6,
              child: XFSTextButton.icon(
                onPressed: () {
                  expandBrand = !expandBrand;
                  setState(() {});
                },
                icon: Icon(expandBrand
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left:10,right: 10),
        child: Wrap(
            spacing: 20,
            children: _listBrand.map((it) {
              return ChoiceChip(
                label: Text(it),
                selectedColor: Colors.pink,
                selected: _select.contains(it),
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
      ),
    ]);
  }

  ///价格输入
  _buildPriceLowerHight() {
    return Column(
      children: [
        XFSText.container('价格',padding: EdgeInsets.all(10),),
        XFSContainer(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            _buildEditTextView('请输入最低价', _editingLowerPriceController),
            XFSText.container(
              '-',
              margin: EdgeInsets.symmetric(horizontal: 5),
            ),
            _buildEditTextView('请输入最高价', _editinghighterPriceController),
          ]),
        ),
      ],
    );
  }

  ///门店选择
  _buildStoreChoice() {
    return Column(
      children: [
        XFSText.container('门店',padding: EdgeInsets.all(10),),
        XFSContainer(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Flexible(flex: 1, child: XFSText.container('$storeName')),
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
    );
  }
}
