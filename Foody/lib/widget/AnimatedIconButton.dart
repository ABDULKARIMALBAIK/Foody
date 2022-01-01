import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class AnimatedIconButton extends StatelessWidget{

  Color _colorButton;
  Color _colorText;
  Color _colorShadow;
  String _iconPathTouched;
  String _iconPathUnTouched;
  String _text;
  GestureTapCallback? pressMethod;
  double _width;
  double _height;

  AnimatedIconButton(this._width,this._height,this._colorButton,this._iconPathTouched,this._iconPathUnTouched,this._text,this._colorText,this._colorShadow , this.pressMethod);

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
                onEnter: (value) {
                  context.read<AnimatedButtonBloc>().update(true);
                  // setState(() {
                  //   touched = true;
                  //   print(touched);
                  // });
                },
                onExit: (value) {
                  context.read<AnimatedButtonBloc>().update(false);
                  // setState(() {
                  //   touched = false;
                  //   print(touched);
                  // });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  curve: Curves.ease,
                  height: state.touched ? _height + 10 : _height,  //50 : 40
                  width: state.touched ? _width + 10 : _width,   //260 : 250
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: !state.touched
                      ? [
                      BoxShadow(
                        color:  _colorShadow,
                        offset: Offset(0.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                      ]
                          : [
                      BoxShadow(
                      color: _colorShadow.withOpacity(0.7),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 7.0,
                  spreadRadius: 2.0,
                ),
                ],
              ),
              child: Material(
                color: _colorButton, // state.touched ? widget.color : widget.color.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  side: BorderSide(width: 2 , color: _colorShadow)
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.0),
                  onTap: (){
                    controller.forward(from: 0.0);
                    pressMethod!.call();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: SvgPicture.asset(state.touched ? _iconPathTouched : _iconPathUnTouched, width: 30, height: 30,),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        flex: 8,
                        child: Center(
                          child: AutoSizeText(
                              AppLocalizations.of(context)!.translate(_text),
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                              minFontSize: 8,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
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