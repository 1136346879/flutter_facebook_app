import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/city_list_model.dart';
import 'package:flutter_facebook/pages/city_list_presenter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

const stringConst = "QWERTYUIOPASDFGHJKLZXCVBNM";

class CityLiStPage extends XFSBaseListPage {
  static pushName(BuildContext context) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.cityLiStPage)
        .then((value) {});
  }

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>>
      getState() => _CityLiStPageState();
}

class _CityLiStPageState
    extends XFSBaseListPageState<CityLiStPage, City, CityListPresenter> {
  @override
  void initState() {
    super.initState();
    locationCity();
    presenter.getCityListData();
  }

  String cityName="";
  @override
  String get naviTitle => '请选择城市';

  @override
  bool isRefresh() => false;

  @override
  bool isLoadMore() => false;

  @override
  Widget buildItem(City city, int index) {
    return index == 0
        ? Column(
            children: [
              Row(
                children: [
                  XFSTextButton.icon(
                    title: '$cityName',
                    fontWeight: FontWeight.bold,
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.orange,
                    ),
                    direction: XFSTextButtonIconTextDirection.textRIconL,
                    onPressed: (){
                      locationCity();
                    },
                  ),
                  XFSText.normal(
                    'GPS定位',
                    textColor: Colors.grey,
                    fontSize: 12,
                  ),
                ],
              ),
            ],
          )
        :
              XFSContainer(
                onTap: (){
                    if( !stringConst.contains(city.name)){
                      Fluttertoast.showToast(msg: "${city.name}+${city.warehouseCode}");
                    }
                },
                backgroundColor: stringConst.contains(city.name)
                    ? Colors.black12
                    : Colors.white,
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XFSTextButton.text(
                      title: "${city.name}",
                      padding: EdgeInsets.only(left: 10),

                        ),
                    Visibility(
                        visible:!stringConst.contains(city.name) ,
                        child: SizedBox(height: 1, child:Container(color: Colors.black12))),
                  ],
                ),
              );
  }

  @override
  Widget buildAppBarTitleView() {
    return XFSCupertinoTextField(
      hintText: '请输入配送地址',
    );
  }

  @override
  CityListPresenter initPresenter() {
    return CityListPresenter(this);
  }

   void locationCity() async{
   Geolocator geolocator =   Geolocator()..forceAndroidLocationManager;
     bool isLocationServiceEnabled  = await geolocator.isLocationServiceEnabled();
   // GeolocationStatus permission = await geolocator.checkGeolocationPermissionStatus();
    Fluttertoast.showToast(msg: "$isLocationServiceEnabled");
    print( "1======================");
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print( "2======================");
    List<Placemark>  placemark = await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
    print( "3======================");
    // Fluttertoast.showToast(msg: "$isLocationServiceEnabled+${placemark[0].administrativeArea}+${placemark[0].country}");
    setState(() {
    print( "4======================");
      cityName = "${placemark[0].country}-${placemark[0].administrativeArea}";
    });

  }
}
