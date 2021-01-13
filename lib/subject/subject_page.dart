import 'dart:ffi';

import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/SubjectModel.dart';
import 'package:flutter_facebook/subject/subject_presenter.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubectListPage extends XFSBaseListPage {
  String arguments;

  SubectListPage({@required this.arguments});

  static pushName(BuildContext context, {String arguments}) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.subectListPage,
            arguments: arguments)
        .then((value) => {});
  }

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>>
      getState() => _SubectListPageState();
}

class _SubectListPageState
    extends XFSBaseListPageState<SubectListPage, ModelList, SubjectPresenter> {
  @override
  String get naviTitle => "专题列表";

  @override
  void initState() {
    super.initState();
    presenter.getSubjectListData();
  }

  String colorDefault = "#f5f5f5";
  Color _color =  Color(0Xff2030ac);

  @override
  Widget buildItem(ModelList modelList, int index) {
    if (modelList.modelType == 1) {
      return XFSContainer(
          backgroundColor:_color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              XFSNetImageLoader.loadNetImage(
                  url: modelList.urlList[0].modelUrl,
                  height: modelList.urlList[0].picHeight.toDouble() > 219
                      ? 219
                      : modelList.urlList[0].picHeight.toDouble(),
                  fit: BoxFit.fill),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else if (modelList.modelType == 2) {
      return XFSContainer(
          padding: EdgeInsets.only(left: 10, right: 10),
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[0].modelUrl, height: 219)),
                  SizedBox(
                    width: 12,
                    height: 219,
                  ),

                  ///width: (XFSScreenUtil().screenWidth-12)/2
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 219)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else if (modelList.modelType == 3) {
      XFSContainer(
          padding: EdgeInsets.only(left: 10, right: 10),
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[0].modelUrl, height: 150)),
                  SizedBox(
                    width: 12,
                    height: 150,
                  ),
                  Column(
                    children: [
                      Expanded(
                          child: XFSNetImageLoader.loadNetImage(
                              url: modelList.urlList[1].modelUrl, height: 71)),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                          child: XFSNetImageLoader.loadNetImage(
                              url: modelList.urlList[2].modelUrl, height: 71)),
                    ],
                  ),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else if (modelList.modelType == 4) {
      return XFSContainer(
          padding: EdgeInsets.only(left: 10, right: 10),
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[0].modelUrl, height: 219)),
                  SizedBox(
                    width: 12,
                    height: 219,
                  ),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 219)),
                  SizedBox(
                    width: 12,
                    height: 219,
                  ),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[2].modelUrl, height: 219)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else if (modelList.modelType == 5) {
      return XFSContainer(
        padding: EdgeInsets.only(left: 10, right: 10),
        backgroundColor: _color,
        onTap: () =>
            Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
        child: Column(
          children: [
            Row(
              children: [
                XFSNetImageLoader.loadNetImage(
                    url: modelList.urlList[0].modelUrl, height: 110, width: 110),
                Expanded(
                  child: Container(
                    height: 110,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          child: XFSText.container(
                            '${modelList.urlList[0].productTitle}',
                            margin: EdgeInsets.only(bottom: 20, top: 10),
                            padding: EdgeInsets.only(left: 10),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                  child: XFSText.container(
                                '￥${modelList.urlList[0].productPrice}',
                                padding: EdgeInsets.only(left: 10),
                              )),
                              XFSText.container(
                                '立即购买',
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(right: 20),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                backgroudColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: modelList.modelSpace == 1,
                child: Divider(
                  height: 12,
                  color: _color,
                ))
          ],
        ),
      );
    } else if (modelList.modelType == 6) {
      return XFSContainer(
        height: 220,
        backgroundColor: _color,
        child:
            ListView.builder(
              shrinkWrap: true,
              scrollDirection:Axis.horizontal ,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction){
                    setState(() {
                         modelList.urlList.removeAt(index);
                    });

                  },
                  confirmDismiss: (direction){
                    return getTrueFalse();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: (index==modelList.urlList.length-1)?0:8),
                    child: Column(
                        children: [
                          XFSNetImageLoader.loadNetImage(
                              url: modelList.urlList[index].modelUrl,
                              height: 110,
                              width: 110),
                          Container(
                            width: 110,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 XFSText.container(
                                    '${modelList.urlList[index].productTitle}',
                                    maxLines: 2,
                                    margin: EdgeInsets.all(10),
                                  ),
                               XFSText.container(
                                  '￥${modelList.urlList[index].productPrice}',
                                  textColor: Colors.red,
                                  padding: EdgeInsets.only(left: 10,bottom: 10),
                                ),
                    ]
                            ),
                          ),
                        ],

                    ),
                  ),
                );
              },
              itemCount: modelList.urlList.length ?? 0,
            ),
            // Visibility(
            //     visible: modelList.modelSpace == 1,
            //     child: Divider(
            //       height: 12,
            //       color: Colors.blue,
            //     ))
        // ),
      );
    } else if (modelList.modelType == 7) {
      return XFSContainer(
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              XFSNetImageLoader.loadNetImage(
                  url: modelList.urlList[0].modelUrl, height: 150),
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 150)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[2].modelUrl, height: 150)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: Colors.blue,
                  ))
            ],
          ));
    } else if (modelList.modelType == 8) {
      return XFSContainer(
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              XFSNetImageLoader.loadNetImage(
                  url: modelList.urlList[0].modelUrl, height: 150),
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 150)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[2].modelUrl, height: 150)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[3].modelUrl, height: 150)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: Colors.blue,
                  ))
            ],
          ));
    } else if (modelList.modelType == 9) {
      return XFSContainer(
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[0].modelUrl, height: 219)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 219)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else if (modelList.modelType == 10) {
      return XFSContainer(
          backgroundColor: _color,
          onTap: () =>
              Fluttertoast.showToast(msg: '模板一${modelList.modelType}！！！'),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[0].modelUrl, height: 219)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[1].modelUrl, height: 219)),
                  Expanded(
                      child: XFSNetImageLoader.loadNetImage(
                          url: modelList.urlList[2].modelUrl, height: 219)),
                ],
              ),
              Visibility(
                  visible: modelList.modelSpace == 1,
                  child: Divider(
                    height: 12,
                    color: _color,
                  ))
            ],
          ));
    } else {
      return XFSContainer(
        backgroundColor: _color,
        onTap: () => Fluttertoast.showToast(msg: '当前版本不支持，点击升级查看！！！'),
        child: XFSText.normal('当前版本不支持，点击升级查看！！！'),
      );
    }
  }

  @override
  void onLoadMore() {
    presenter.getSubjectListData();
  }

  @override
  void onRefresh() {
    presenter.getSubjectListData();

  }

  @override
  SubjectPresenter initPresenter() {
    return SubjectPresenter(this);
  }
}

 getTrueFalse() {
  return true;
}
