import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/city_list_model.dart';
import 'package:flutter_facebook/pages/az_city_list_presenter.dart';
import 'package:flutter_facebook/util/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
typedef Widget ItemWidgetBuilder(BuildContext context, dynamic model);
class AzCityListPage extends XFSBasePage{
  static pushName(BuildContext context) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.azCityListPage)
      .then((value) {
      Fluttertoast.showToast(msg: "$value");
    });
  }
  @override
  XFSBasePageState getState() => _AzCityListPageState();

}

class _AzCityListPageState extends XFSBasePageState<AzCityListPage, List<City>, AZCityListPresenter> {

  @override
  String get naviTitle => '请选择城市';


  @override
  void initState() {
    super.initState();
    presenter.getCityListData();
  }

  @override
  AZCityListPresenter initPresenter() {
    return AZCityListPresenter(this);
  }

  @override
  Widget buildWidget(BuildContext context, List<City> cityList) {
    return cityList.isNotNullOrEmpty() ?Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Config.colorF6F6F6,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(Icons.search),
                  ),
                  XFSText.normal('搜索', textColor: Config.color999999,)
                ],
              ),
            ),
          ),
          onTap: (){
            showXFSSearch(
              context: context,
              delegate: XFSSearchPageDelegate(
                list: cityList,
                hint: '请输入搜索内容',
                itemBuilder: (context, model){
                  return _listItem(model);
                },
              ),
            ).then((value){
              if (value != null){
                Navigator.pop(context,value?.name);
              }
            });
          },
        ),
        Expanded(
          child: XFSAZListView(
            itemBuilder: (context, model){
              return _buildItem(model);
            },
            list: cityList,
          ),
        )
      ],
    ): Text('加载中。。。');
  }
  Widget _buildItem(City model){
    return InkWell(
      child: _listItem(model),
      onTap: (){
        Navigator.pop(context,model?.name);
      },
    );
  }

  Widget _listItem(City model){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.name, textAlign: TextAlign.start,),
          Text('warehouseCode:${model?.warehouseCode}: ${model?.namePinyin}', style: TextStyle(fontSize: 12, color: Colors.grey),),
        ],
      ),
    );
  }
}



class XFSSearchPageDelegate<T> extends XFSSearchDelegate{

  List<T> _searchResultList = List();

  final List<T> list;
  final ItemWidgetBuilder itemBuilder;
  final String hint;

  XFSSearchPageDelegate({
    @required this.itemBuilder,
    @required this.list,
    this.hint,
  }) : super(
    searchFieldLabel: hint,
  );


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
      itemCount: _searchResultList?.length??0,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _searchData();
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(context, _searchResultList[index]);
      },
      itemCount: _searchResultList?.length??0,
    );
  }


  Widget _buildItem(BuildContext context,T model){

    if (model is XFSAZModel){
      return InkWell(
        child: itemBuilder(context, model),
        onTap: (){
          close(context, model);
        },
      );
    }
    return Container();

  }

  _searchData(){
    _searchResultList = list.map((e){
      if (e is XFSAZModel){
        if (e.namePinyin.contains(query) || e.getTitle().contains(query)){
          return e;
        }
      }
    }).toList();
  }

  @override
  Widget buildCancelButton(BuildContext context) {

    return XFSText.container('取消',
      textColor: Config.colorFFA200,
      padding: EdgeInsets.symmetric(horizontal: 10),
      onTap: (){
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
      child: Icon(Icons.search, size: 15, color: Config.colorB2B22B2,),
    );
  }

  @override
  Widget buildSearchBarRightButton(BuildContext context) {
    return  IconButton(
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