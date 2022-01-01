import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class CrossAnimationButton extends StatelessWidget{

  final double? height;
  final double? width;
  final double? thickness;
  final Curve? curve;
  final int? milliseconds;
  final Color? unTouchEdgesColor;
  final Color? touchEdgesColor;
  final Color? unTouchBackgroundColor;
  final Color? touchBackgroundColor;
  final Color? unTouchTextColor;
  final Color? touchTextColor;
  final String? text;
  final VoidCallback onPress;


  CrossAnimationButton(
      this.height,
      this.width,
      this.thickness,
      this.curve,
      this.milliseconds,
      this.unTouchEdgesColor,
      this.touchEdgesColor,
      this.unTouchBackgroundColor,
      this.touchBackgroundColor,
      this.unTouchTextColor,
      this.touchTextColor,
      this.text,
      this.onPress);

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
              builder: (context, state) => Container(
                height: height,
                width: width,
                child: MouseRegion(
                  onEnter: (val) {
                    context.read<AnimatedButtonBloc>().update(true);
                  },
                  onExit: (val) {
                    context.read<AnimatedButtonBloc>().update(false);
                  },
                  cursor: SystemMouseCursors.click,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Material(
                        child: InkWell(
                          onTap: (){
                            controller.forward(from: 0.0);
                            onPress.call();
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: milliseconds! + 150),
                            curve: curve!,
                            height: height,
                            width: width,
                            color: state.touched
                                ? touchBackgroundColor
                                : unTouchBackgroundColor,
                            child: Center(
                                child: AutoSizeText(
                                    text.toString(),
                                    style: state.touched ?
                                    Theme.of(context).textTheme.subtitle1!.copyWith(color: touchTextColor) :
                                    Theme.of(context).textTheme.subtitle1!.copyWith(color: unTouchTextColor),
                                    minFontSize: 10,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: AnimatedContainer(
                          height: thickness,
                          width: state.touched ? width! : 15,
                          color: state.touched ? touchEdgesColor : unTouchEdgesColor,
                          duration: Duration(milliseconds: milliseconds!),
                          curve: curve!,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: AnimatedContainer(
                          height: state.touched ? height! : 15,
                          width: thickness,
                          color: state.touched ? touchEdgesColor : unTouchEdgesColor,
                          duration: Duration(milliseconds: milliseconds!),
                          curve: curve!,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AnimatedContainer(
                          height: thickness,
                          width: state.touched ? width! : 15,
                          color: state.touched ? touchEdgesColor : unTouchEdgesColor,
                          duration: Duration(milliseconds: milliseconds!),
                          curve: curve!,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AnimatedContainer(
                          height: state.touched ? height! : 15,
                          width: thickness,
                          color: state.touched ? touchEdgesColor : unTouchEdgesColor,
                          duration: Duration(milliseconds: milliseconds!),
                          curve: curve!,
                        ),
                      ),

                    ],
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