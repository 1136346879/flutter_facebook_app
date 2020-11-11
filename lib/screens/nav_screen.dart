import 'package:flutter/material.dart';
import 'package:flutter_facebook/data/data.dart';
import 'package:flutter_facebook/models/user_model.dart';
import 'package:flutter_facebook/screens/screens.dart';
import 'package:flutter_facebook/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_page.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';

import 'nav_screen_presenter.dart';

class NavScreen extends XFSBasePage {
  @override
  _NavScreenState createState() => _NavScreenState();

  @override
  XFSBasePageState<XFSBasePage, Object, XFSBasePresenter<XFSBaseView>> getState() {
   return _NavScreenState();
  }
}

class _NavScreenState extends XFSBasePageState<NavScreen,
    User, NavScreenPresenter>{
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];
  int _selectedIndex = 0;
@override
  void initState() {
    super.initState();
    presenter.getCurrentUserInf();
  }

  @override
  Widget buildWidget(BuildContext context, User currentUser ) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
          preferredSize: Size(screenSize.width, 100.0),
          child: CustomAppBar(
            currentUser: currentUser,
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        )
            : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
          // padding: const EdgeInsets.only(bottom: 12.0),
          color: Colors.white,
          child: CustomTabBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  NavScreenPresenter initPresenter() {
    return NavScreenPresenter(this);
  }

  @override
  bool get isShowHeader => false;
}
