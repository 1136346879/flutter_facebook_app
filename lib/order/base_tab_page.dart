import 'package:flutter/material.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';
///携带tabbar的base类
abstract class BaseTabPage extends XFSBasePage {
  BaseTabPage({Key key}) : super(key: key);

  @override
  BaseTabPageState createState() {
   return getState();
  }

  ///子类实现
  BaseTabPageState getState();
}

abstract class BaseTabPageState<T extends BaseTabPage, O extends Object,
        P extends XFSBasePresenter> extends XFSBasePageState<T, O, P> with SingleTickerProviderStateMixin {
  TabController _tabController;
  TabController get tabController => _tabController;

  PageController _pageController;
  PageController get pageController => _pageController;
  int get initialIndex => 0;
  /// 当前index
  int _currentTabIndex;
  int get currentTabIndex => _currentTabIndex;

  /// tabbar相关配置
  TabbarTheme get theme => TabbarTheme();
  ///自定义标题
  List get tabs;

  @override
  void initState() {
    super.initState();
    print("-----------${tabs.length}");
    _tabController = TabController(length: buildTabs().length, vsync: this, initialIndex: initialIndex);
    _pageController = PageController(initialPage: initialIndex);
  }
  @override
  Widget buildWidget(BuildContext context, O object) {
    return Column(
      children: [
        tabbar(),
        Expanded(
            child: _tabView()
        ),
      ],
    );
  }
  ///tabbar
  List<Widget> buildTabs();
  ///pageview
  List<Widget> buildTabViews();


  ScrollPhysics configScrollPhysics() {
    return ClampingScrollPhysics();
  }



  Widget tabbar() {
    return Container(
      color: theme.backgroundColor,
      padding: theme.tabbarPadding,
      child: TabBar(
        tabs: buildTabs(),
        controller: _tabController,
        isScrollable: theme.isScrollable,
        indicatorSize: theme.indicatorSize,
        indicatorPadding: theme.indicatorPadding,
        labelColor: theme.labelColor,
        unselectedLabelColor: theme.unselectedLabelColor,
        labelStyle: theme.labelStyle,
        unselectedLabelStyle: theme.unselectedLabelStyle,
        indicatorColor: theme.indicatorColor,
        indicatorWeight: theme.indicatorWeight,
        onTap: (index){
          _currentTabIndex = index;
          _pageController.jumpToPage(index);
          pageChange(index);
        },
      ),
    );
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: TabBar(
        tabs: buildTabs(),
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.orange,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.black,
        indicatorWeight: 1,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _tabView() {
    return PageView(
      controller: _pageController,
      children: buildTabViews(),
      onPageChanged: (index){
        _currentTabIndex = index;
        _tabController.animateTo(index);
        pageChange(index);
      },
      physics: configScrollPhysics(),
    );
    return PageView(
      controller: _pageController,
      children: buildTabViews(),
      onPageChanged: (index) {
        _tabController.animateTo(index);
      },
      physics: configScrollPhysics(),
    );
  }

  /// 页面切换
  void pageChange(int index){}
}

/// tabbar配置
class TabbarTheme{

  final Color backgroundColor;
  final EdgeInsetsGeometry indicatorPadding;
  final bool isScrollable;
  final EdgeInsetsGeometry tabbarPadding;
  final TabBarIndicatorSize indicatorSize;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Color indicatorColor;
  final double indicatorWeight;

  TabbarTheme( {
    this.backgroundColor=Colors.white,
    this.isScrollable=false,
    this.indicatorPadding=const EdgeInsets.all(0),
    this.indicatorSize=TabBarIndicatorSize.label,
    this.labelColor=Config.app_main,
    this.unselectedLabelColor=Config.color333333,
    this.labelStyle=const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.unselectedLabelStyle=const TextStyle(fontSize:14, fontWeight: FontWeight.bold),
    this.indicatorColor=Config.app_main,
    this.indicatorWeight=1,
    this.tabbarPadding=const EdgeInsets.only(bottom: 5),
  });

}