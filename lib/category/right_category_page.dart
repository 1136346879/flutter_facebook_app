import 'package:flutter_facebook/category/right_category_list_presenter.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/right_category_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RightCategoryListPage extends XFSBaseListPage {
  int categoryId;
  String categoryName;
  GlobalKey globalKey = GlobalKey();

  RightCategoryListPage({
    this.categoryId,
    this.categoryName,
    this.globalKey,
  }) : super(key: globalKey);

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>>
      getState() => RightCategoryListPageState();
}

class RightCategoryListPageState extends XFSBaseListPageState<
    RightCategoryListPage, SecondList, RightCategoryListPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.getLinkedCategoryData(widget.categoryId);
  }

  @override
  Widget buildItem(SecondList rightCategoryModel, int index) {
    return index == 0
        ? 
            XFSText(
                  "${rightCategoryModel?.afterCategoryName??""}",
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  backgroudColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.center,
                )
        : Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: XFSText(
                        '${rightCategoryModel?.afterCategoryName ?? ""}',
                        padding: EdgeInsets.all(10),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Visibility(
                      visible: ((rightCategoryModel?.secondList ?? []).length)>6,
                      child: XFSTextButton.icon(
                        onPressed: (){
                          rightCategoryModel?.expand = !(rightCategoryModel.expand ??false);
                          setState(() {
                          });
                        },
                        icon: Icon(rightCategoryModel.expand ?? false ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)),
                    ),
                  ],
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  controller: ScrollController(),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  //水平子Widget之间间距
                  crossAxisSpacing: 1,
                  //垂直子Widget之间间距
                  mainAxisSpacing: 1,
                  //GridView内边距
                  // padding: EdgeInsets.all(10.0),
                  //一行的Widget数量
                  crossAxisCount: 3,
                  //子Widget宽高比例
                  childAspectRatio: 2.0,
                  //子Widget列表
                  children:
                      getWidgetList(rightCategoryModel?.secondList ?? null,rightCategoryModel.expand??false),
                )
              ],
            ),
          );
  }

  List<Widget> getWidgetList(List<SecondListNext> object, bool expand) {
    if (object.isNullOrEmpty()) {
      return [];
    }
    List<SecondListNext> objectList = expand || object.length <= 6 ? object: object.sublist(0,6);
    return objectList ?.map((item) => XFSText(
              item?.afterCategoryName ?? "",
              fontSize: 12,
              backgroudColor: Colors.white,
              alignment: Alignment.center,
              onTap: () {
                Fluttertoast.showToast(msg: "${item.afterCategoryName}");
              },
            )

    )?.toList();
  }

  @override
  void onLoadMore() {}

  @override
  bool isRefresh() {
    return false;
  }

  @override
  bool isLoadMore() {
    return false;
  }

  @override
  bool get isShowHeader => false;

  @override
  void onRefresh() {}

  changeCategory(int categoryId, String categoryName) {
    widget.categoryName = categoryName;
    print("widget.categoryName----${widget.categoryName}");
    presenter.getLinkedCategoryData(
      categoryId,
    );
    scrollController.jumpTo(0.0);
  }

  @override
  RightCategoryListPresenter initPresenter() {
    return RightCategoryListPresenter(this);
  }
}
