import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook/config/xfs_header.dart';

///
///       创建时间：2020/12/24
///       修改人  ：zhangyan
///       描述    ：
///
class CameraMainPage extends XFSBasePage {
  var arguments;

  CameraMainPage({this.arguments});

  @override
  XFSBasePageState getState() => _CameraMainPageState();
}

class _CameraMainPageState
    extends XFSBasePageState<CameraMainPage, Object, XFSBasePresenter> {
  int cameraState = 0;
  CameraController cameraController;
  var camera;
  bool ifProcess = false;
  List<Face> faces;
  List<Rect> rects;
  double widthRate;
  CustomPainter painter;

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  List<Widget> actions() {
    return [
      Container(
        child: XFSTextButton.icon(
          width: 6,
          icon: Icon(
            Icons.camera_front,
            color: Colors.white,
          ),
          onPressed: () {
            if (cameraState == 0) {
              cameraState = 1; //前置摄像头
            } else {
              cameraState = 0; //后置摄像头
            }
            cameraController =
                CameraController(camera[cameraState], ResolutionPreset.high);
            cameraController.initialize().then((value) {
              if (!mounted) {
                return;
              }
            });
            setState(() {});
          },
        ),
      ),
    ];
  }

  getCameras() async {
    camera = await availableCameras();
    cameraController =
        CameraController(camera[cameraState], ResolutionPreset.max);
    await cameraController.initialize();

    cameraController.startImageStream((CameraImage image) async {
      if (!ifProcess && mounted) {
        // ifProcess = true;
        final detector = FirebaseVision.instance.faceDetector(
          FaceDetectorOptions(enableContours: true,mode: FaceDetectorMode.fast)
        );
        final visionImage = FirebaseVisionImage.fromBytes(
            // concatenatePlanes(image.planes),
            image.planes[0].bytes,
            buildMetaData(image, ImageRotation.rotation90));
        faces = await detector.processImage(visionImage);
        widthRate = image.width / size.width;
        rects = List<Rect>();
        if (rects != null) rects.clear();
        faces.forEach((face) => rects.add(face.boundingBox));
        // faces.forEach((face) => rects.add(
        //       Rect.fromLTWH(
        //           face.boundingBox.left / widthRate,
        //           face.boundingBox.top / widthRate,
        //           face.boundingBox.width / widthRate,
        //           face.boundingBox.height / widthRate),
        //     ));
        // faces[0].getContour(FaceContourType.face);
        setState(() {
          faces = faces;
          ifProcess = false;
          widthRate = widthRate;
          rects = rects;
          painter = FacePainter(
              rects: rects,
              faces: faces,
              imageSize: cameraController.value.previewSize,
              origSize: size);
        });
      }
    });
  }

  FirebaseVisionImageMetadata buildMetaData(
    CameraImage image,
    ImageRotation rotation,
  ) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map((Plane plane) {
        return FirebaseVisionImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      }).toList(),
    );
  }

  @override
  String get naviTitle => '时时相机';

  @override
  XFSBasePresenter initPresenter() {}

  concatenatePlanes(List<Plane> planes) {
    WriteBuffer writeBuffer = WriteBuffer();
    planes.forEach((plane) => writeBuffer.putUint8List(plane.bytes));
    return writeBuffer.done().buffer.asInt8List();
  }

  @override
  bool get isUseSafeArea => true;//安全区域 适配ios新机型

  @override
  Widget buildWidget(BuildContext context, Object object) {
    final deviceRatio = size.width / size.height;
    if (cameraController.isNullOrEmpty() ||
        !cameraController.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        Transform.scale(
          scale: cameraController.value.aspectRatio / deviceRatio,
          child: Center(
              child: AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),//相机预览
          )),
        ),
        FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
                width: size.width,
                height: size.width * cameraController.value.aspectRatio,
                child: CustomPaint(painter: painter)))
      ],
    );
  }

  @override
  void dispose() {
    ///资源释放
    cameraController?.dispose();
    super.dispose();
  }
}

///脸部画笔
class FacePainter extends CustomPainter {
  final List<Rect> rects;
  final Size imageSize;
  final Size origSize;

  final List<Face> faces; //屏幕大小
  FacePainter({this.imageSize, this.origSize, this.rects, this.faces});

  @override
  void paint(Canvas canvas, Size size) {
    ///渐变色  彩虹
    Gradient gradient = LinearGradient(
      colors: [
        Colors.red,
        Colors.green,
        Colors.yellow,
        Colors.orange,
        Colors.blue,
      ],
      stops: [0.15, 0.4, 0.6, 0.8, 0.9],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    /// 在屏幕上cavans与图片的转换
    double scale = origSize.width / imageSize.height;

  ///画笔
    Paint paint = Paint()
      ..style = PaintingStyle.fill //stroke
      ..strokeWidth = 3
      ..color = Colors.red;
    Path path = Path();///path 路径
    for(var face in faces){
      List<Offset> upperTOP =
          face.getContour(FaceContourType.upperLipTop).positionsList;
      List<Offset> upperBottom =
          face.getContour(FaceContourType.upperLipBottom).positionsList;
      List<Offset> LOWerTop =
          face.getContour(FaceContourType.lowerLipTop).positionsList;
      List<Offset> lowerBottom =
          face.getContour(FaceContourType.lowerLipBottom).positionsList;
      double leftX = upperBottom.first.dx;
      double leftY = upperBottom.first.dy;
      double rightX = upperBottom.last.dx;
      double rightY = upperBottom.last.dy;
      double mouthWidth = rightX - leftX;

      ///嘴巴的宽度
      double peak = 1 / 4 * mouthWidth;
      int middlePosition = (upperBottom.length / 2).floor();

      ///中部元素的
      double mouthHeight =
          LOWerTop[middlePosition].dy - upperBottom[middlePosition].dy;

      ///嘴巴的高度

// if(mouthHeight>=mouthWidth/2) { //真人
  if (mouthHeight >= 0) {
    //图片
    ///左嘴角的位置
    path = path..moveTo(leftX * scale, leftY * scale);
    ///波峰数量
    double waves = 5.0;
    /// 图片高度=  相机预览的宽度，反转了
    double imageHeight = imageSize.width;
    ///获取Y坐标的集合
    List<double> ys = spiltDouble(leftY, imageHeight, 2000);
    ///X坐标的集合
    List<double> xs = List<double>();
    ys.forEach((y) {
      double curX = leftX +
          peak * sin((y - leftY) * pi / ((imageHeight - leftY) / waves));
      ///波浪线X坐标集合
      xs.add(curX);
      ///path移动  lineTo
      path = path..lineTo(curX * scale, y * scale);
    });
    ///下方横线，Y坐标不变，X坐标需要加上 嘴的宽度
    path = path..lineTo((xs.last+ mouthWidth) * scale, ys.last * scale);
    ///X和Y坐标的集合 反转，从下到上
    xs = xs.reversed.toList();
    ys = ys.reversed.toList();

    for (int i = 0; i < xs.length; i++) {
      ///X坐标需要加上 嘴的宽度  path继续lineTo
      path = path..lineTo((xs[i]+ mouthWidth) * scale, ys[i] * scale);
    }
    ///封闭path
    path.lineTo(leftX * scale, leftY * scale);
    ///绘制区域
    Rect rect = Rect.fromLTWH((leftX - peak) * scale, leftY * scale,
        (mouthWidth + 2 * peak) * scale, (imageHeight - leftY) * scale);
    paint = paint..shader = gradient.createShader(rect);
    canvas.drawPath(path, paint);
  }
      // ///获取脸上的元素，画出红点
      // canvas.drawPoints(PointMode.points, scalePointPostion(face.getContour(FaceContourType.allPoints)), paint);
    }
    // for (Rect rect in rects) {
    //   //找出脸布位置，然后画红框标出
    //   canvas.drawRect(scaleRect(size, rect), paint);
    // }
  }

  Rect scaleRect(Size cavasSize, Rect rect) {
    double scaleX = origSize.width / imageSize.height;
    double scaleY = scaleX;
    Rect newRect = Rect.fromLTRB(rect.left * scaleX, rect.top * scaleY,
        rect.right * scaleX, rect.bottom * scaleY);
    return newRect;
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    // return oldDelegate.faces != faces && faces.length>=0 ;
    return true;
  }

  // @override
  // bool shouldRebuildSemantics(FacePainter oldDelegate) {
  //   return false;
  // }

  ///获取脸上的元素，画出红点
  List<Offset> scalePointPostion(FaceContour contour) {
    double scale = origSize.width / imageSize.height;
    List<Offset> newContour = List<Offset>();
    for (int i = 0; i < contour.positionsList.length; i++) {
      Offset curPoint = contour.positionsList[i];
      newContour.add(Offset(curPoint.dx * scale, curPoint.dy * scale));
    }
    return newContour;
  }

  ///波浪线Y坐标集合
  ///  begin
  ///  end
  ///  count  Y方向 分为count份
  List<double> spiltDouble(double begin, double end, int count) {
    List<double> result = List<double>();
    double each = (end - begin) / count;
    for (int i = 0; i < count; i++) {
      result.add(begin + each * i);
    }
    return result;
  }
}
