import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class AnimationIcon extends StatelessWidget{

  Color _touchIconColor;
  Color _UntouchIconColor;
  Color _touchShadowColor;
  Color _UntouchShadowColor;
  Color _touchBackgroundColor;
  Color _UntouchBackgroundColor;
  IconData _touchIconPath;
  IconData _UntouchIconPath;
  VoidCallback? pressMethod;
  double _touchWidth;
  double _UntouchWidth;
  double _touchHeight;
  double _UntouchHeight;
  double _touchSizeIcon;
  double _UntouchSizeIcon;


  AnimationIcon(
      this._touchIconColor,
      this._UntouchIconColor,
      this._touchShadowColor,
      this._UntouchShadowColor,
      this._touchBackgroundColor,
      this._UntouchBackgroundColor,
      this._touchIconPath,
      this._UntouchIconPath,
      this.pressMethod,
      this._touchWidth,
      this._UntouchWidth,
      this._touchHeight,
      this._UntouchHeight,
      this._touchSizeIcon,
      this._UntouchSizeIcon);

  @override
  Widget build(BuildContext context) {

    return PimpedButton(
      particle: DemoParticle(),
      pimpedWidgetBuilder: (context,controller){
        return BouncingWidget(
          onPressed: (){},
          child: BlocProvider<AnimatedButtonBloc>(
            create: (context) => AnimatedButtonBloc(),
            child: BlocBuilder<AnimatedButtonBloc, AnimatedButtonState>(

              buildWhen: (oldState, newState) => oldState != newState,
              builder: (context, state) => MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (value) {
                  context.read<AnimatedButtonBloc>().update(true);
                },
                onExit: (value) {
                  context.read<AnimatedButtonBloc>().update(false);
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.all(12),
                  duration: Duration(milliseconds: 180),
                  curve: Curves.ease,
                  height: state.touched ? _touchHeight : _UntouchHeight,  //50 : 40
                  width: state.touched ? _touchWidth  : _UntouchWidth,   //260 : 250
                  decoration: BoxDecoration(
                      color: state.touched ? _touchBackgroundColor :  _UntouchBackgroundColor,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: !state.touched
                      ? [
                      BoxShadow(
                        color:  _UntouchShadowColor,
                        offset: Offset(0.0, 5.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                      ]
                          : [
                      BoxShadow(
                      color: _touchShadowColor,
                      offset: Offset(0.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
                ],
              ),
              child: Material(
                color: state.touched ? _touchBackgroundColor :  _UntouchBackgroundColor, // state.touched ? widget.color : widget.color.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(14.0),
                    onTap: (){
                      controller.forward(from: 0.0);
                      pressMethod!.call();
                      },
                    child: Container(
                      child: Center(
                        child: Icon(
                          state.touched ? _touchIconPath : _UntouchIconPath,
                          size: state.touched ? _touchSizeIcon : _UntouchSizeIcon,
                          color: state.touched ? _touchIconColor : _UntouchIconColor,
                        ),
                      ),
                    )
                ),
              ),
            ),
          ),
        ),
        ),
        );
      },
    );
  }

}