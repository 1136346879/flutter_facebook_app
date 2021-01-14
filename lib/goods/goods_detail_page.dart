import 'package:after_layout/after_layout.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';
import 'package:flutter_facebook/widgets/banner/pagination.dart';
import 'package:flutter_facebook/widgets/common_line_view.dart';
import 'package:flutter_facebook/widgets/sticky_tabbar_delegate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

import 'dialog_select_spec_widget_page.dart';
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
    GoodsDetailPresenter> with TickerProviderStateMixin implements GoodsDetailView{
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset >= expandedHeight) {
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
  ScrollController listViewControll = ScrollController();
  TabController tabControll;
  TabController tabTopControll;
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  double expandedHeight = 1000;

  updateExpandedHeight(height) {
    expandedHeight = height;
    setState(() {});
  }

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
                      backgroundColor: Colors.white,
                      expandedHeight: expandedHeight,
                      flexibleSpace: new FlexibleSpaceBar(
                        background: SliverAppBarWidgetCallBack(
                          listGoodsDetailModel: listGoodsDetailModel,
                          updateExpandedHeight: updateExpandedHeight,
                          spuId: widget.arguments,
                            listColors:listColors,
                        ),
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
                      Center(child: XFSText.normal('包装清单')),
                    ]),
              ),
              Positioned(bottom: 0, child: _bottomWidget(context))
            ]),
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
        child: XFSText.container(
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
          XFSText.container(
            '加入采购单',
            textColor: Colors.white,
            backgroudColor: Config.colorFFA200,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          ),
          XFSText.container(
            '立即购买',
            textColor: Colors.white,
            backgroudColor: Colors.orange,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          ),
        ],
      ),
    );
  }
  List<String> listColors = List();
  @override
  colors(List<String> listColors) {
    this.listColors = listColors;
  }
}

class SliverAppBarWidgetCallBack extends StatefulWidget {
  final List<GoodsDetailModel> listGoodsDetailModel;
  final Function(double) updateExpandedHeight;
  final int spuId;
  final List<String> listColors ;

  SliverAppBarWidgetCallBack(
      {Key key,
      @required this.listGoodsDetailModel,
      @required this.updateExpandedHeight, this.spuId, this.listColors})
      : super(key: key);

  @override
  _SliverAppBarWidgetCallBackState createState() =>
      _SliverAppBarWidgetCallBackState();
}

class _SliverAppBarWidgetCallBackState extends State<SliverAppBarWidgetCallBack>
    with AfterLayoutMixin {
  String cityName = '请选择城市';
  bool expand = false;
  double listviewHeight = 300;

  @override
  Widget build(BuildContext context) {
    var listGoodsDetailModel = widget.listGoodsDetailModel;
    listviewHeight = double.parse("${(listGoodsDetailModel.length + 1) * 50}");
    if (!expand) {
      if (listGoodsDetailModel.length > 5) {
        listviewHeight = 300;
      }
    }
    return Column(
      children: [
        Pagination(images: listGoodsDetailModel[0].images),
        XFSText.container(
          '${listGoodsDetailModel[0].skuName} ${listGoodsDetailModel[0].color ?? ""} ${listGoodsDetailModel[0].specifications} ',
          padding: EdgeInsets.all(10),
          fontWeight: FontWeight.bold,
        ),
        Visibility(
          visible: listGoodsDetailModel[0].subtitile.isNotEmpty,
          child: XFSText.container(
            '${listGoodsDetailModel[0].subtitile} ',
            textColor: Config.color666666,
            fontSize: 12,
            padding: EdgeInsets.only(bottom: 10, left: 10),
          ),
        ),
        Row(
          children: [
            XFSText.container(
              '签约价：${listGoodsDetailModel[0].salePrice}/${listGoodsDetailModel[0].unit}',
              padding: EdgeInsets.only(bottom: 10, left: 10),
              textColor: Colors.orange,
            ),
            XFSText.container(
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
              Flexible(
                flex: 3,
                child: XFSText.container("请选择规格", padding: EdgeInsets.all(10)),
              ),
              Icon(
                Icons.chevron_right,
                size: 25,
                color: Config.color999999,
              ),
            ],
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 4 / 5,
                    child:_buildBottomSheetVIew(widget.spuId,widget.listColors.length>0?widget.listColors:[""]),
                  );
                });
          },
        ),
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
            XFSText.container(
              '$cityName',
              textColor: Colors.orange,
              onTap: () {
                Navigator.pushNamed(
                        context, XFSAppRouteConfigure.azCityListPage)
                    .then((value) {
                  if (value != null) cityName = value ?? "$value";
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
        Container(
            height: listviewHeight,
            child: _listViewBuild(
                listGoodsDetailModel: listGoodsDetailModel,
                expand: expand,
                updateListViewHeight: updateListViewHeight)),
        Visibility(
            visible: listGoodsDetailModel.length > 5,
            child: XFSTextButton.icon(
              onPressed: () {
                expand = !expand;
                setState(() {
                  listviewHeight =
                      double.parse("${(listGoodsDetailModel.length + 1) * 50}");
                  if (!expand) {
                    listviewHeight = 300;
                  }
                });
                afterSecondLayout(
                    context,
                    double.parse("${(listGoodsDetailModel.length + 1) * 50}") -
                        300,
                    expand);
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

  updateListViewHeight(height) {
    listviewHeight = height;
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    double height =
        renderBox.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
    widget.updateExpandedHeight(height);
  }

  afterSecondLayout(
      BuildContext context, double changeHeight, bool expandbool) {
    RenderBox renderBox = context.findRenderObject();
    double height =
        renderBox.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
    expandbool
        ? widget.updateExpandedHeight(height + changeHeight)
        : widget.updateExpandedHeight(height - changeHeight);
  }

  _buildBottomSheetVIew(int spuId, List<String> listColors) {
    return
      Column(
        children: [
          Row(children: [
            Image.network('https://fsyuncai.oss-cn-beijing.aliyuncs.com/product/images/1554278804115007872b.jpg?x-oss-process=style/marking_text',width: 80,height: 80,),
            Column(children: [
              XFSText.normal('¥1亿～9块9',textColor: Config.colorFFA200,fontSize: 20,),
              XFSText.normal('必须全部购买',textColor: Config.color999999,),
            ],),
            XFSTextButton.icon(icon: Icon(Icons.close),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],),
          Expanded(
            child: XFSContainer(
                backgroundColor: Colors.white,
                child: DialogSelectSpecPage(spuId:spuId,listColors:listColors)),
          ),
          XFSText.container('确认',width: double.infinity,fontSize: 16,textColor: Colors.white,backgroudColor: Config.colorFFA200,alignment: Alignment.center,padding: EdgeInsets.symmetric(vertical: 10),)
        ],
      );
  }
}

class _listViewBuild extends StatefulWidget {
  final List<GoodsDetailModel> listGoodsDetailModel;

  final Function(double) updateListViewHeight;
  bool expand = false;

  _listViewBuild(
      {Key key,
      this.listGoodsDetailModel,
      this.expand,
      this.updateListViewHeight})
      : super(key: key);

  @override
  __listViewBuildState createState() => __listViewBuildState();
}

class __listViewBuildState extends State<_listViewBuild> {
  @override
  Widget build(BuildContext context) {
    var listGoodsDetailModel = widget.listGoodsDetailModel;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              Visibility(
                visible: index == 0,
                child: Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 3,
                          child: XFSText.container(
                            '规格型号',
                            padding: EdgeInsets.all(10),
                            fontSize: 12,
                          )),
                      Flexible(
                          flex: 2,
                          child: XFSText.container(
                            '价格（元）',
                            padding: EdgeInsets.all(10),
                            fontSize: 12,
                          )),
                      XFSText.container(
                        '操作',
                        padding: EdgeInsets.all(10),
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
              ),
              _buildItem(
                  listGoodsDetailModel: listGoodsDetailModel, index: index)
            ],
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listGoodsDetailModel.length < 6
            ? listGoodsDetailModel.length
            : !widget.expand
                ? 5
                : listGoodsDetailModel.length,
      ),
    );
  }
}

class _buildItem extends StatefulWidget {
  final List<GoodsDetailModel> listGoodsDetailModel;
  final int index;

  const _buildItem({Key key, this.listGoodsDetailModel, this.index})
      : super(key: key);

  @override
  __buildItemState createState() => __buildItemState();
}

class __buildItemState extends State<_buildItem> {
  @override
  Widget build(BuildContext context) {
    var listGoodsDetailModel = widget.listGoodsDetailModel;
    var index = widget.index;
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 3,
              child: XFSText.container(
                '${listGoodsDetailModel[index].color}/${listGoodsDetailModel[index].specifications}',
                padding: EdgeInsets.all(10),
                fontSize: 12,
              )),
          Flexible(
              flex: 2,
              child: XFSText.container(
                '${listGoodsDetailModel[index].salePrice}',
                padding: EdgeInsets.all(10),
                fontSize: 12,
              )),
          const XFSText.container(
            '查看',
            textColor: Colors.orange,
            padding: EdgeInsets.all(10),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
