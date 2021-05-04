import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  final Widget child;
  final bool inAsyncall;
  final double opacity;
  final Color color;
  final Animation <Color> colorVal;

  const CircularLoader({Key key, this.inAsyncall, this.opacity, this.color, this.colorVal, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);

    if(inAsyncall){
      final Loader =  new Stack(
        children: [
          new Opacity(
              opacity: opacity,
              child: ModalBarrier(dismissible: false,color: color),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      
      widgetList.add(Loader);
    }
    return Stack(
      children: widgetList,
    );
  }
}
