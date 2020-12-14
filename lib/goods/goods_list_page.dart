import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/goods/goods_detail_page.dart';
import 'package:flutter_facebook/interface/xfs_click_delegate.dart';
import 'package:flutter_facebook/models/search_result_model.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'goods_list_presenter.dart';

///商品列表
class GoodsListPage extends XFSBaseListPage {
  final List<SpuList> spuList;
  final XFSClickDelegate clickDelegate;

  GoodsListPage({this.clickDelegate, this.spuList});

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>>
      getState() => _GoodsListPageState();
}

class _GoodsListPageState extends XFSBaseListPageState<GoodsListPage, SpuList,
    GoodsListPagePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.getData(widget.spuList);
  }

  @override
  bool get isShowHeader => false;

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
                  child: XFSText(
                    '${spuEntry?.spu_Name}',
                    maxLines: 2,
                  ),
                ),
                Container(
                  child: XFSText('${spuEntry?.title}',
                      maxLines: 2,
                      textColor: Config.color999999,
                      fontSize: 10,
                      overflow: TextOverflow.fade),
                ),
                XFSText(
                  '${spuEntry?.priceRange}',
                  textColor: Colors.orange,
                ),
                Row(
                  children: [
                    Visibility(
                        visible: spuEntry?.stock != 0,
                        child: XFSText(
                          '现货',
                          textColor: Colors.orange,
                          fontSize: 12,
                          margin: EdgeInsets.only(right: 10),
                        )),
                    XFSText(
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

  @override
  void onLoadMore() {
    widget.clickDelegate.didSelectCell(clickType: 2, data: "上拉加载", data1: "");
  }

  @override
  void onRefresh() {
    widget.clickDelegate.didSelectCell(clickType: 1, data: "下拉刷新", data1: "");
  }

  @override
  void emptyViewAction() {
    presenter.getData(widget.spuList);
  }

  @override
  void errorViewAction() {
    presenter.getData(widget.spuList);
  }

  @override
  GoodsListPagePresenter initPresenter() {
    return GoodsListPagePresenter(this);
  }
}
