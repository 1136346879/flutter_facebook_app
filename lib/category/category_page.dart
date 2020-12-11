import 'package:flutter_facebook/category/category_presenter.dart';
import 'package:flutter_facebook/category/right_category_page.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/category_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends XFSBasePage {
  @override
  XFSBasePageState getState() => _CategoryPageState();
}

class _CategoryPageState
    extends XFSBasePageState<CategoryPage, List<Data>, CategoryPresenter> {
  int selectedIndex = 0;
  GlobalKey<RightCategoryListPageState> globalKey = GlobalKey();
  int frontCategoryId = 0;
  String fristCategoryName;
  @override
  void initState() {
    super.initState();
    presenter.getListFirstPlay();
  }

  @override
  CategoryPresenter initPresenter() {
    return CategoryPresenter(this);
  }

  @override
  String get naviTitle => "Category";

  @override
  Widget buildWidget(BuildContext context, List<Data> object) {
    frontCategoryId = object[0].relationFirstLevelObject[0].frontCategoryId;
    fristCategoryName = object[0].relationFirstLevelObject[0].fristCategoryName;
    return object.isNotNullOrEmpty()
        ? Container(
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _itemBuildFirstCategory(object, index);
                    },
                    itemCount: object.length ?? 0,
                  ),
                ),
                Expanded(child: RightCategoryListPage(categoryId: frontCategoryId,globalKey: globalKey,categoryName: fristCategoryName,)),
              ],
            ),
          )
        : XFSText('加载中。。。');
  }

  Widget _itemBuildFirstCategory(List<Data> object, int index) {

    return XFSContainer(
      onTap: () {
        if(index == selectedIndex){
          return;
        }
        object.forEach((element) {
          element.selected = false;
        });
        object[index].selected = true;
        selectedIndex =index;
        frontCategoryId = object[index].relationFirstLevelObject[0].frontCategoryId;
        fristCategoryName = object[index].relationFirstLevelObject[0].fristCategoryName;
        globalKey.currentState.changeCategory(frontCategoryId,fristCategoryName);
        setState(() {});
      },
      backgroundColor:
          object[index]?.selected ?? false ? Colors.orange : Colors.white,
      padding: EdgeInsets.all(15),
      child: XFSText('${object[index]?.displayContent ?? ""}'),
    );
  }
}
