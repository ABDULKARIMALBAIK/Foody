import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class AnimatedButton extends StatelessWidget {

  Color _colorButton;
  GestureTapCallback? pressMethod;
  String textButton;

  AnimatedButton(this._colorButton,this.textButton,this.pressMethod);

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
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  curve: Curves.ease,
                  height: state.touched ? 60 : 50.0,
                  width: state.touched ? 260 : 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: !state.touched
                      ? [
                      BoxShadow(
                        color:  _colorButton,
                        offset: Offset(0.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                      ]
                          : [
                      BoxShadow(
                      color: _colorButton.withOpacity(0.7),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 7.0,
                  spreadRadius: 2,
                ),
                ],
              ),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                color: _colorButton,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.0),
                  onTap: (){
                    controller.forward(from: 0.0);
                    pressMethod!.call();
                  },
                  child: Center(
                    child: AutoSizeText(
                        textButton,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
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
