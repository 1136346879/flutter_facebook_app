import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/goods/goods_list_page.dart';
import 'package:flutter_facebook/goods/xfs_right_filt_drawer_page.dart';
import 'package:flutter_facebook/interface/xfs_click_delegate.dart';
import 'package:flutter_facebook/models/XFSGoodsFiltModel.dart';
import 'package:flutter_facebook/models/category_to_list_model.dart';
import 'package:flutter_facebook/models/search_result_model.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'goods_detail_page.dart';
import 'goods_presenter.dart';

///商品页面
class SearchGoodsListPage extends XFSBaseListPage {
  CategoryToListModel arguments;

  SearchGoodsListPage({this.arguments});

  @override
  XFSBaseListPageState getState() => _GoodsLisPageState();
}

class _GoodsLisPageState
    extends XFSBaseListPageState<SearchGoodsListPage, SpuList, GoodsPresenter>
    implements GoodsListView, XFSClickDelegate {
  XFSGoodsFiltModel _filtrateModel = XFSGoodsFiltModel();
  @override
  void initState() {
    super.initState();
    presenter.getSearchProData(widget.arguments,false);
  }

  @override
  GoodsPresenter initPresenter() {
    return GoodsPresenter(this);
  }

  @override
  Widget buildAppBarTitleView() {
    return XFSCupertinoTextField(
      prefix: Icon(
        Icons.search,
        size: 15,
        color: Colors.grey,
      ),
      prefixMode: OverlayVisibilityMode.always,
      clearButtonMode: OverlayVisibilityMode.editing,
      backgroudColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      hintText: " lsit请输入商品名称，型号或编码",
      maxLines: 1,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      hintTextFontSize: 16.0,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        // presenter.searchSelfRaiseData(list: list, text: value);
      },
      onSubmitted: (text) {
        // presenter.searchSelfRaiseData(list: list, text: text);
      },
    );
  }

  @override
  Widget initEndDrawer() {
    return XFSRightFiltDrawerPage(
      filtrateModel: _filtrateModel,
      confirmCallback: (value){
        _filtrateModel=value;
        Fluttertoast.showToast(msg: '确认--请列表刷新页面');
      },
      resetCallback: (value){
      },
    );
  }
  @override
  Widget buildTopView(List<SpuList> object) {
    String mCategoryName =
    object.isNullOrEmpty() ? "" : object[0].categoryName1;
    return Column(
      children: [
        Visibility(
          visible: !mCategoryName.isNullOrEmpty() &&
              widget.arguments.mCategoryLevel == 1,
          child: Container(
            padding: EdgeInsets.all(10),
            child: XFSText.container(
              '$mCategoryName',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center,
            ),
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            XFSText.container(
              '综合',
              padding: EdgeInsets.only(left: 20),
              textColor: true ? Colors.orange : Config.color333333,
              onTap: () {
                Fluttertoast.showToast(msg: "综合");
              },

            ),
            Flexible(
                flex: 2,
                child: XFSTextButton.icon(
                    title: '价格',
                    textColor: false ? Colors.orange : Config.color333333,
                    gap: 2,
                    icon: Column(
                      children: [
                        Icon(
                          Icons.arrow_drop_up_outlined,
                          color: false ? Colors.orange : Config.color333333,
                          size: 10,
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: false ? Colors.orange : Config.color333333,
                          size: 10,
                        ),
                      ],
                    ),
                    direction: XFSTextButtonIconTextDirection.textLIconR,
                    onPressed: () {
                      Fluttertoast.showToast(msg: "价格排序");
                    },

                )),
            Flexible(
                flex: 1,
                child: XFSText.container(
                  '促销',
                  textColor: false ? Colors.orange : Config.color333333,
                  onTap: () {
                    Fluttertoast.showToast(msg: "促销");
                  },

                )),
            Flexible(
                flex: 1,
                child: XFSText.container(
                  '有库存',
                  textColor: false ? Colors.orange : Config.color333333,
                  onTap: () {
                    Fluttertoast.showToast(msg: "有库存");
                  },

                )),
            XFSText.normal(
              '|',
              textColor: Colors.grey,
            ),
            Flexible(
              flex: 2,
              child: XFSTextButton.icon(
                  title: '筛选',
                  textColor: false ? Colors.orange : Config.color333333,
                  gap: 2,
                  direction: XFSTextButtonIconTextDirection.textLIconR,
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: false ? Colors.orange : Config.color333333,
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(msg: "筛选");
                    openEndDrawer();
                  },
                  ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  // @override
  // Widget buildWidget(BuildContext context, SearchResult object) {
  //   if (object.isNullOrEmpty() || object.spuList.isNullOrEmpty())
  //     return XFSText.normal('');
  //   return
  //       GoodsListPage(
  //         spuList: object?.spuList,
  //         clickDelegate: this,
  //   );
  // }

  @override
  priceSort() {
    ///价格排序
  }

  @override
  void didSelectCell({int clickType, data, data1}) {
    if (1 == clickType) {
      Fluttertoast.showToast(msg: '$data');
    }
    if (2 == clickType) {
      Fluttertoast.showToast(msg: '$data');
    }
  }

  @override
  siftData(List<String> brandListString) {
      _filtrateModel.brandStringList = brandListString;
      setState(() {
      });
  }

  @override
  categoryData(List<CatAndNumXList> categoryList) {
    _filtrateModel.categoryList = categoryList;
    setState(() {
    });
  }

  @override
  Widget buildItem(SpuList spuEntry, int index) {
    return XFSContainer(
      // border: Border.all(color: Config.colorE7E7E7, width: 1),
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          XFSNetImageLoader.loadNetImage(
              url: (spuEntry?.spuimages != null &&
                  spuEntry.spuimages?.length != null &&
                  spuEntry.spuimages.length > 0
                  ? spuEntry?.spuimages[0]
                  : "") ??
                  "",
              width: 100,
              height: 100),
          Container(
            width: MediaQuery.of(context).size.width - 140.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: XFSText.normal(
                    '${spuEntry?.spu_Name}',
                    maxLines: 2,
                  ),
                ),
                Container(
                  child: XFSText.normal('${spuEntry?.title}',
                      maxLines: 2,
                      textColor: Config.color999999,
                      fontSize: 10,
                      overflow: TextOverflow.fade),
                ),
                XFSText.normal(
                  '${spuEntry?.priceRange}',
                  textColor: Colors.orange,
                ),
                Row(
                  children: [
                    Visibility(
                        visible: spuEntry?.stock != 0,
                        child: XFSText.container(
                          '现货',
                          textColor: Colors.orange,
                          fontSize: 12,
                          margin: EdgeInsets.only(right: 10),
                        )),
                    XFSText.container(
                      '规格数量： ${spuEntry?.skuNum}个',
                      fontSize: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Fluttertoast.showToast(msg: "${spuEntry?.spu_Name ?? ""}==${ spuEntry.spuId}");

        GoodsDetailPage.push(context,arguments: spuEntry.spuId);
      },
    );
  }
}
