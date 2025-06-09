import '/gymhub/gymhub_icon_button.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'botones_paginas_nav_bar_model.dart';
export 'botones_paginas_nav_bar_model.dart';

class BotonesPaginasNavBarWidget extends StatefulWidget {
  const BotonesPaginasNavBarWidget({super.key});

  @override
  State<BotonesPaginasNavBarWidget> createState() =>
      _BotonesPaginasNavBarWidgetState();
}

class _BotonesPaginasNavBarWidgetState
    extends State<BotonesPaginasNavBarWidget> {
  late BotonesPaginasNavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BotonesPaginasNavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GymHubIconButton(
          borderRadius: 10.0,
          buttonSize: 50.0,
          fillColor: Color(0x7FCDCDCD),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: GymHubTheme.of(context).info,
            size: 25.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        GymHubIconButton(
          borderRadius: 10.0,
          buttonSize: 50.0,
          fillColor: Color(0x7FCDCDCD),
          icon: Icon(
            FFIcons.kframe,
            color: GymHubTheme.of(context).info,
            size: 25.0,
          ),
          onPressed: () async {
            if (Navigator.of(context).canPop()) {
              context.pop();
            }
            context.pushNamed(
              PerfilWidget.routeName,
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                ),
              },
            );
          },
        ),
      ],
    );
  }
}
