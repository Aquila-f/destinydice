import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(MaterialApp(home: MyApp(),));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{


  AnimationController _controller;
  Animation<int> _animation;
  int nnn = 72;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this,);
    _animation = new IntTween(begin: 0, end: nnn).animate(CurvedAnimation(parent: _controller,reverseCurve: Curves.easeIn ,curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int distinynumberbasis = 50;
  double _slidervalue = 50;
  int sliderint = 50;





  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(title: Text('Dice'),),
      body: Container(
        child:Column(children: <Widget>[
          Expanded(flex: 3,child: Column(children: <Widget>[
            destinyresult(),
            Text('${_controller.status.toString()}'),
            Text('${nnn.toString()}'),
//            Text('${_animation.value.toDouble()%7}'),
            Text('${_controller.lowerBound.toString()}'),

            Expanded(child: Row(children: <Widget>[
              Expanded(child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget child) {
                  int frame = _animation.value%16;
//                      .padLeft(1, '0');
                  return new Image.asset(
                    'lib/images/frame_${frame}_delay-0.1s.gif',
                    gaplessPlayback: true,
                  );
                },
              ),),
              Expanded(child: Center(child: IconButton(
                  icon: Icon(Icons.build),
                  onPressed: (){
                    print(destinyresult());
//                    _controller.dispose();
//                    _controller.repeat();
                    if(_controller.status == AnimationStatus.dismissed){
                      _controller.forward();
                    }
                    if(_controller.status == AnimationStatus.completed){
                      _controller.reverse();
                    }
                    print(_controller.toString());

                    setState(() {

                    });
                  },
              ))),
            ],)),
            Expanded(child: Center(child: destinyoutputcolor(),)),
          ],)),
//          Expanded(child: ListView.builder(itemCount: 10,
//              itemBuilder:(context , index){
//                return contt(distinynumberbasis);
//              })),
            Expanded(child: Container(
              child: Slider(
                label: "${_slidervalue.round()}/${100-_slidervalue.round()}",
                max: 100,
                min: 0,
                divisions: 10,
                value: _slidervalue,
                onChanged: (a){
                  setState(() {
                    _slidervalue = a;
                    sliderint = _slidervalue.round();
                  });
                },
              ),))
        ],)
          ),
      floatingActionButton: FloatingActionButton(child:Icon(Icons.refresh),
        onPressed: (){
          distinynumberbasis = Random().nextInt(100);
          if(distinynumberbasis > _slidervalue){
            nnn=64;
            _controller.reset();
            _controller.forward();
          }
          if(distinynumberbasis < _slidervalue){
            nnn=72;
            _controller.reset();
            _controller.forward();
          }
          setState(() {
          });
        },
      ),
    );
  }
  
  destinyoutputcolor(){
    Color bgc = Colors.white;
    if(distinynumberbasis > _slidervalue){
      bgc = Colors.red;
    }
    if(distinynumberbasis == _slidervalue){
      bgc = Colors.yellow;
    }
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: bgc,
        borderRadius: BorderRadius.all(Radius.circular(75))
      ),
    );
  }

  destinyresult(){
    return Container(
      child: Text(distinynumberbasis.toString()),
    );
  }

  contt(aa){
    Color bgcolor;
    if(aa <= _slidervalue ){
      bgcolor = Colors.red;
    }
    return Container(
        margin: EdgeInsets.only(top: 5,right: 30,left: 30,bottom: 5),
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        child: Center(child: Container(child: Text(aa.toString(),style: TextStyle(fontSize: 33),),height: 60,)));
  }
}

