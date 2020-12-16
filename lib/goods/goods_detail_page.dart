import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';
import 'package:flutter_facebook/widgets/banner/pagination.dart';
import 'package:flutter_facebook/widgets/common_line_view.dart';
import 'package:flutter_facebook/widgets/sticky_tabbar_delegate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

import 'goods_detail_presenter.dart';

class GoodsDetailPage extends XFSBasePage {
  final int arguments;

  GoodsDetailPage({this.arguments});

  static push(BuildContext context, {int arguments}) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.goodsDetailPage,
            arguments: arguments)
        .then((value) {});
  }

  @override
  XFSBasePageState getState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends XFSBasePageState<
    GoodsDetailPage,
    List<GoodsDetailModel>,
    GoodsDetailPresenter> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // if (scrollController.offset > XFSScreenUtil.getScreenW(context)/3*2 + 300 - MediaQuery.of(context).padding.top){
      var offset = scrollController.offset;
      if (offset >= 1000) {
        if (tabTopControll.index != 1) {
          tabTopControll.animateTo(1);
        }
      } else {
        if (tabTopControll.index != 0) {
          tabTopControll.animateTo(0);
        }
      }

      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
    tabControll = TabController(vsync: this, length: 2, initialIndex: 0);
    tabTopControll = TabController(vsync: this, length: 2, initialIndex: 0);
    presenter.getGoodsDetialData(spuId: widget.arguments);
  }

  @override
  GoodsDetailPresenter initPresenter() {
    return GoodsDetailPresenter(this);
  }

  @override
  bool get isUseSafeArea => true;

  @override
  bool get isShowHeader => false;

  @override
  List<Widget> actions() {
    return [
      XFSTextButton.icon(
        icon: Icon(
          Icons.share,
          color: Colors.white,
        ),
        width: 6,
        onPressed: () {
          Fluttertoast.showToast(msg: '分享');
        },
      ),
    ];
  }

  ScrollController listViewControll = ScrollController();
  bool expand = false;
  String cityName = '请选择城市';
  TabController tabControll;
  TabController tabTopControll;
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  @override
  Widget buildWidget(
      BuildContext context, List<GoodsDetailModel> listGoodsDetailModel) {
    return listGoodsDetailModel.isNullOrEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : XFSContainer(
            backgroundColor: Colors.white,
            child: Stack(children: [
              NestedScrollView(
                controller: scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      stretch: true,
                      leading: _buildLeftBack(),
                      titleSpacing: 0,
                      title: tabbar(),
                      backgroundColor: Colors.transparent,
                      expandedHeight: 1000,
                      flexibleSpace: new FlexibleSpaceBar(
                        background: _buildTopWidget(listGoodsDetailModel),
                        collapseMode: CollapseMode.pin,
                        stretchModes: const <StretchMode>[
                          StretchMode.fadeTitle
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: StickyTabBarDelegate(
                        child: TabBar(
                          labelColor: Colors.black,
                          controller: this.tabControll,
                          tabs: <Widget>[
                            Tab(text: '商品介绍'),
                            Tab(text: '包装清单'),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                    controller: tabControll,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return XFSNetImageLoader.loadNetImage(
                                height: 200,
                                url: listGoodsDetailModel[0]
                                    .images[index]
                                    .imgUrl);
                          },
                          itemCount: listGoodsDetailModel[0].images.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                      Center(child: XFSText('包装清单')),
                    ]),
              ),
              Positioned(bottom: 0, child: _bottomWidget(context))
            ]),
          );
  }

  _buildTopWidget(List<GoodsDetailModel> listGoodsDetailModel) {
    return Column(
      children: [
        Pagination(images: listGoodsDetailModel[0].images),
        XFSText(
          '${listGoodsDetailModel[0].skuName} ${listGoodsDetailModel[0].color ?? ""} ${listGoodsDetailModel[0].specifications} ',
          padding: EdgeInsets.all(10),
          fontWeight: FontWeight.bold,
        ),
        Visibility(
          visible: listGoodsDetailModel[0].subtitile.isNotEmpty,
          child: XFSText(
            '${listGoodsDetailModel[0].subtitile} ',
            textColor: Config.color666666,
            fontSize: 12,
            padding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        ),
        Row(
          children: [
            XFSText(
              '签约价：${listGoodsDetailModel[0].salePrice}/${listGoodsDetailModel[0].unit}',
              padding: EdgeInsets.only(bottom: 10, left: 10),
              textColor: Colors.orange,
            ),
            XFSText(
              '售价：￥${listGoodsDetailModel[0].retailPrice}/${listGoodsDetailModel[0].unit}',
              padding: EdgeInsets.only(bottom: 10, left: 10),
              decoration: TextDecoration.lineThrough,
            ),
          ],
        ),
        CommonLineView(
          height: 20,
          color: Config.colorF5F5F5,
        ),
        XFSContainer(
            child: Row(
          children: [
            Flexible(
              flex: 1,
              child: XFSTextButton.icon(
                icon: Icon(
                  Icons.wysiwyg,
                  color: Colors.orange,
                  size: 50,
                ),
                title: '规格',
                direction: XFSTextButtonIconTextDirection.textBIconT,
              ),
            ),
            CommonLineView(
              height: 60,
              color: Config.colorF5F5F5,
              width: 1,
            ),
            XFSText(
              "请选择规格",
              padding: EdgeInsets.all(10),
            ),
            Icon(
              Icons.chevron_right,
              size: 25,
              color: Config.color999999,
            ),
          ],
        )),
        CommonLineView(
          height: 1,
          color: Config.colorF5F5F5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            XFSTextButton.icon(
              icon: Icon(
                Icons.location_on,
                color: Colors.orange,
              ),
              title: '配送区域选择：',
              direction: XFSTextButtonIconTextDirection.textLIconR,
            ),
            XFSText(
              '$cityName',
              textColor: Colors.orange,
              onTap: () {
                Navigator.pushNamed(
                        context, XFSAppRouteConfigure.azCityListPage)
                    .then((value) {
                  if (value == null) return cityName = value ?? "$cityName";
                  setState(() {});
                });
              },
            ),
          ],
        ),
        CommonLineView(
          height: 20,
          color: Config.colorF5F5F5,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Visibility(
                    visible: index == 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 3,
                            child: XFSText(
                              '规格型号',
                              padding: EdgeInsets.all(10),
                              fontSize: 12,
                            )),
                        Flexible(
                            flex: 2,
                            child: XFSText(
                              '价格（元）',
                              padding: EdgeInsets.all(10),
                              fontSize: 12,
                            )),
                        XFSText(
                          '操作',
                          padding: EdgeInsets.all(10),
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 3,
                          child: XFSText(
                            '${listGoodsDetailModel[index].color}/${listGoodsDetailModel[index].specifications}',
                            padding: EdgeInsets.all(10),
                            fontSize: 12,
                          )),
                      Flexible(
                          flex: 2,
                          child: XFSText(
                            '${listGoodsDetailModel[index].salePrice}',
                            padding: EdgeInsets.all(10),
                            fontSize: 12,
                          )),
                      const XFSText(
                        '查看',
                        textColor: Colors.orange,
                        padding: EdgeInsets.all(10),
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listGoodsDetailModel.length < 6
                ? listGoodsDetailModel.length
                : !expand
                    ? 5
                    : listGoodsDetailModel.length,
          ),
        ),
        Visibility(
            visible: listGoodsDetailModel.length > 5,
            child: XFSTextButton.icon(
              onPressed: () {
                expand = !expand;
                setState(() {});
              },
              icon: Icon(
                expand
                    ? Icons.keyboard_arrow_up_sharp
                    : Icons.keyboard_arrow_down,
                color: Colors.orange,
              ),
              title: expand ? '收起全部' : "展开全部",
              direction: XFSTextButtonIconTextDirection.textBIconT,
              textColor: Colors.orange,
            )),
        CommonLineView(
          height: 20,
          color: Config.colorF5F5F5,
        ),
        XFSTextButton.icon(
          icon: Icon(
            Icons.keyboard_arrow_up_sharp,
            color: Config.color999999,
          ),
          title: '上拉查看图文详情',
          direction: XFSTextButtonIconTextDirection.textRIconL,
          textColor: Config.color999999,
        ),
        CommonLineView(
          height: 20,
          color: Config.colorF5F5F5,
        ),
      ],
    );
  }

  Widget tabbar() {
    return Opacity(
      opacity: navAlpha,
      child: Container(
        color: Colors.black,
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: TabBar(
          tabs: [
            Tab(
              text: '商品',
            ),
            Tab(
              text: '详情',
            ),
          ],
          controller: tabTopControll,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          onTap: (index) {
            if (index == 0) {
              // scrollController.animateTo(0, duration: Duration(milliseconds: 1000), curve: null)
              scrollController.jumpTo(0);
            } else {
              scrollController.jumpTo(1000);
              // scrollController.jumpTo(XFSScreenUtil.getScreenW(context)/3*2 + 300);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLeftBack() {
    return Opacity(
        opacity: navAlpha,
        child: XFSText(
          'back',
          padding: EdgeInsets.symmetric(horizontal: 10),
          backgroudColor: Colors.black,
          textColor: Colors.white,
          onTap: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget _bottomWidget(BuildContext context) {
    return XFSContainer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          XFSTextButton.icon(
            icon: Icon(
              Icons.home_rounded,
              size: 18,
            ),
            title: '首页',
            fontSize: 10,
            direction: XFSTextButtonIconTextDirection.textBIconT,
          ),
          XFSTextButton.icon(
            icon: Icon(
              Icons.shopping_basket,
              size: 18,
            ),
            title: '采购单',
            fontSize: 10,
            direction: XFSTextButtonIconTextDirection.textBIconT,
          ),
          XFSTextButton.icon(
            icon: Icon(
              Icons.contacts_rounded,
              size: 18,
            ),
            title: '客服',
            fontSize: 10,
            direction: XFSTextButtonIconTextDirection.textBIconT,
          ),
          XFSText(
            '加入采购单',
            textColor: Colors.white,
            backgroudColor: Config.colorFFA200,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          ),
          XFSText(
            '立即购买',
            textColor: Colors.white,
            backgroudColor: Colors.orange,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          ),
        ],
      ),
    );
  }
}
