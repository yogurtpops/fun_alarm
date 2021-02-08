import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MyRiveAnimation extends StatefulWidget {
  final String riveFileName;
  final List<String> animations;

  const MyRiveAnimation({Key key, this.riveFileName, this.animations}) : super(key: key);

  @override
  MyRiveAnimationState createState() => MyRiveAnimationState();
}

class MyRiveAnimationState extends State<MyRiveAnimation> {
  Artboard _artboard;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(widget.riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() {
        for (String anim in widget.animations){
          file.mainArtboard.addController(SimpleAnimation(anim));
        }
        _artboard = file.mainArtboard;
      });
    }
  }

  pause(String animation){

  }

  resume(String animation){

  }

  startLoop(String animation, {double speed}) {
    SimpleAnimation(animation).instance.animation
      // ..speed = speed ?? 1
      ..loop = Loop.loop;
  }

  // use this for stopping
  doOneShot(String animation, {double speed}) => SimpleAnimation(animation).instance.animation
    ..loop = Loop.oneShot
    ..speed = speed ?? 1;

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? Rive(

      artboard: _artboard,
      fit: BoxFit.contain,
    )
        : Container();
  }
}