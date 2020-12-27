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
return[
  Container(
    child: XFSTextButton.icon(
      width: 6,
      icon: Icon(Icons.camera_front,color: Colors.white,),
      onPressed: (){
        if(cameraState == 0){
          cameraState =1;//前置摄像头
        }else{
          cameraState =0;//后置摄像头
        }
        cameraController = CameraController(camera[cameraState], ResolutionPreset.high);
        cameraController.initialize().then((value){
          if(!mounted){
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
    cameraController = CameraController(camera[cameraState], ResolutionPreset.high);
    await cameraController.initialize();

    cameraController.startImageStream((CameraImage image) async {
      if (!ifProcess) {
        ifProcess = true;
        final detector = FirebaseVision.instance.faceDetector();
        final visionImage = FirebaseVisionImage.fromBytes(
            // concatenatePlanes(image.planes),
            image.planes[0].bytes,
            buildMetaData(image, ImageRotation.rotation90));
        faces = await detector.processImage(visionImage);
        widthRate = image.width / size.height;
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
  bool get isUseSafeArea => true;
  @override
  Widget buildWidget(BuildContext context, Object object) {
    if (cameraController.isNullOrEmpty() ||
        !cameraController.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: cameraController.value.aspectRatio,
          child: CameraPreview(cameraController),
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
    cameraController?.dispose();
    super.dispose();
  }
}

class FacePainter extends CustomPainter {
  final List<Rect> rects;
  final Size imageSize;
  final Size origSize; //屏幕大小
  FacePainter({this.imageSize, this.origSize, this.rects});

  Rect scaleRect(Size cavasSize, Rect rect) {
    double scaleX = origSize.width / imageSize.height;
    double scaleY = scaleX;
    Rect newRect = Rect.fromLTRB(rect.left * scaleX, rect.top * scaleY,
        rect.right * scaleX, rect.bottom * scaleY);
    return newRect;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.red;

    for (Rect rect in rects) {
      canvas.drawRect(scaleRect(size, rect), paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.rects != rects;
  }

  @override
  bool shouldRebuildSemantics(FacePainter oldDelegate) {
    return false;
  }
}
