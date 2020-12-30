import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_item_build_widget.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_stores_choice_presenter.dart';

/// Created by wdx
/// on 2020-12-21
/// page XFSStoreChoicePage 门店选择页面
typedef Widget ItemWidgetBuilder(BuildContext context, dynamic model);
class XFSStoreChoicePage extends XFSBasePage {
  final String arguments;
  XFSStoreChoicePage({this.arguments});
  @override
  XFSBasePageState getState() => _XFSStoreChoicePageState();
}

class _XFSStoreChoicePageState extends XFSBasePageState<XFSStoreChoicePage,
    List<xfsSelfRaiseSearchModel>, XFSStoreChoicePresenter> {
  ///已选择的门店
  var selfRaiseModel;
  ///搜索后点击的item——position
  int positionIn = -1;
  ///搜索传递的列表数据
  List<xfsSelfRaiseSearchModel> searchStoreList = List();

  @override
  bool get isUseSafeArea => true;
  @override
  void initState() {
    super.initState();
    presenter.getStores(widget.arguments ?? "");
  }

  @override
  String get naviTitle => "选择门店";

  @override
  void errorViewAction() {
    presenter.getStores(widget.arguments ?? "");
  }
  @override
  List<Widget> actions() {
    return [
      XFSText('搜索门店',
          padding: EdgeInsets.only(left: 10, right: 10),
          textColor: Colors.white, onTap: () {
        Navigator.pushNamed(
                context, XFSAppRouteConfigure.xfsSelfRaiseSearchAddress,
                arguments: searchStoreList)
            .then((value) => {
                  if (value != null){
                      positionIn = searchStoreList?.indexWhere(
                          (element) => element.ship_add_id == value),
                      if (positionIn != -1){///再返回原生筛选
                          // XFSCommonUtils.goBackNative(
                          //   argument: searchStoreList?.elementAt(positionIn)?.toJson(),
                          // )
            Navigator.pop(context, searchStoreList?.elementAt(positionIn))
                        }
                    },
                });
      }
          // showXFSSearch(
          //   context: context,
          //   delegate: XFSSearchPageDelegate(
          //     list: searchStoreList,
          //     hint: '请输入搜索的门店',
          //     itemBuilder: (context, model){
          //       return XFSSelfItemBuildWidget(model: model);
          //     },
          //   ),
          // ).then((value){
          //   if (value != null){
          //     // CommonUtils.showToast(msg: value.name);
          //     Navigator.pop(context,value?.name);
          //   }
          // });
          ),
    ];
  }

  @override
  XFSStoreChoicePresenter initPresenter() => XFSStoreChoicePresenter(this);

  @override
  Widget buildWidget(
      BuildContext context, List<xfsSelfRaiseSearchModel> storeList) {
    if (storeList.isNullOrEmpty()) return Container();
    if (searchStoreList.isEmpty) searchStoreList.addAll(storeList);
    if (widget.arguments.isNotNullOrEmpty()) {
      int index = storeList
          ?.indexWhere((element) => element.ship_add_id == widget.arguments);
      if (index != -1) {
        selfRaiseModel = storeList?.elementAt(index);
        storeList?.remove(selfRaiseModel);
      }
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Visibility(
                child: Column(
                  children: [
                    _sectionBuildView(title:'当前选择的门店',iconData:Icons.location_searching),
                    XFSSelfItemBuildWidget(model: selfRaiseModel),
                  ],
                ),
                visible: selfRaiseModel?.isSelected ?? false,
              ),
              _sectionBuildView(title:'可选门店',iconData:Icons.store_mall_directory_outlined),
              _buildListView(storeList),
            ],
          ),
        ),
        _bottomView(),
      ],
    );
  }

  @override
  void backAction() {
    super.backAction();
    // XFSCommonUtils.goBackNative();
  }
  ///底部不限门店
  _bottomView() {
   return Container(
      color: Config.colorFFA200,
      child: XFSTextButton.text(
        width: double.infinity,
        textColor: Colors.white,
        title: '不限门店',
        padding: EdgeInsets.all(10),
        fontSize: 16,
        onPressed: () {
          // XFSCommonUtils.goBackNative(argument: "不限门店");
          Navigator.pop(context,"不限门店");
        },
      ),
    );
  }
  ///中部可选门店 列表
  _buildListView(List<xfsSelfRaiseSearchModel> storeList) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (cnt, index) {
        return XFSSelfItemBuildWidget(model: storeList[index],listItem: true,);
      },
      itemCount: storeList?.length ?? 0,
      physics: NeverScrollableScrollPhysics(),
    );
  }
  ///sectionView
  _sectionBuildView({String title, IconData iconData}) {
    return  Container(
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      child: XFSTextButton.icon(
        icon: Icon(
          iconData,
          color: Config.colorFFA200,
          size: 14,
        ),
        textColor: Config.color333333,
        fontSize: 14,
        title: '$title',
      ),
    );
  }
}
///搜索delegate
class XFSSearchPageDelegate<T> extends XFSSearchDelegate {
  List<T> _searchResultList = List();
  final List<T> list;
  final ItemWidgetBuilder itemBuilder;
  final String hint;
  XFSSearchPageDelegate({
    @required this.itemBuilder,
    @required this.list,
    this.hint,
  }) : super(searchFieldLabel: hint,);
  @override
  List<Widget> buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    _searchData();
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(context, _searchResultList[index]);
      },
      itemCount: _searchResultList?.length ?? 0,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _searchData();
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(context, _searchResultList[index]);
      },
      itemCount: _searchResultList?.length ?? 0,
    );
  }

  Widget _buildItem(BuildContext context, T model) {
    if (model is xfsSelfRaiseSearchModel) {
      return InkWell(
        child: itemBuilder(context, model),
        onTap: () {
          close(context, model);
        },
      );
    }
    return Container();
  }

  _searchData() {
    _searchResultList = list.map((e) {
      if (e is xfsSelfRaiseSearchModel) {
        if (e.add_alias.contains(query) ||
            e.allPinyin.contains(query) ||
            e.simplePinyin.contains(query)) {
          return e;
        }
      }
    }).toList();
  }

  @override
  Widget buildCancelButton(BuildContext context) {
    return XFSText(
      '取消',
      textColor: Config.colorFFA200,
      padding: EdgeInsets.symmetric(horizontal: 10),
      onTap: () {
        close(context, null);
      },
    );
  }

  @override
  String initTitle() {
    return '请选择';
  }

  @override
  Widget buildSearchBarLeftButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Icon(
        Icons.search,
        size: 15,
        color: Config.colorB2B22B2,
      ),
    );
  }

  @override
  Widget buildSearchBarRightButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.cancel,
        size: 15,
        color: Config.colorB2B22B2,
      ),
      onPressed: () {
        query = '';
      },
    );
  }
}
