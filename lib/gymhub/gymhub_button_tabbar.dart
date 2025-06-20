import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const double _kTabHeight = 46.0;

typedef _LayoutCallback = void Function(
    List<double> xOffsets, TextDirection textDirection, double width);

class _TabLabelBarRenderer extends RenderFlex {
  _TabLabelBarRenderer({
    required Axis direction,
    required MainAxisSize mainAxisSize,
    required MainAxisAlignment mainAxisAlignment,
    required CrossAxisAlignment crossAxisAlignment,
    required TextDirection textDirection,
    required VerticalDirection verticalDirection,
    required this.onPerformLayout,
  }) : super(
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        );

  _LayoutCallback onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();

    RenderBox? child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData =
          child.parentData! as FlexParentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    assert(textDirection != null);
    switch (textDirection!) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
        break;
      case TextDirection.ltr:
        xOffsets.add(size.width);
        break;
    }
    onPerformLayout(xOffsets, textDirection!, size.width);
  }
}


class _TabLabelBar extends Flex {
  _TabLabelBar({
    required List<Widget> children,
    required this.onPerformLayout,
  }) : super(
          children: children,
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
        );

  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}

class _IndicatorPainter extends CustomPainter {
  _IndicatorPainter({
    required this.controller,
    required this.tabKeys,
    required _IndicatorPainter? old,
  }) : super(repaint: controller.animation) {
    if (old != null) {
      saveTabOffsets(old._currentTabOffsets, old._currentTextDirection);
    }
  }

  final TabController controller;

  final List<GlobalKey> tabKeys;


  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  BoxPainter? _painter;
  bool _needsPaint = false;
  void markNeedsPaint() {
    _needsPaint = true;
  }

  void dispose() {
    _painter?.dispose();
  }

  void saveTabOffsets(List<double>? tabOffsets, TextDirection? textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }


  int get maxTabIndex => _currentTabOffsets!.length - 2;

  double centerOf(int tabIndex) {
    assert(_currentTabOffsets != null);
    assert(_currentTabOffsets!.isNotEmpty);
    assert(tabIndex >= 0);
    assert(tabIndex <= maxTabIndex);
    return (_currentTabOffsets![tabIndex] + _currentTabOffsets![tabIndex + 1]) /
        2.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _needsPaint = false;
  }

  @override
  bool shouldRepaint(_IndicatorPainter old) {
    return _needsPaint ||
        controller != old.controller ||
        tabKeys.length != old.tabKeys.length ||
        (!listEquals(_currentTabOffsets, old._currentTabOffsets)) ||
        _currentTextDirection != old._currentTextDirection;
  }
}



class _TabBarScrollPosition extends ScrollPositionWithSingleContext {
  _TabBarScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    required ScrollPosition? oldPosition,
    required this.tabBar,
  }) : super(
          initialPixels: null,
          physics: physics,
          context: context,
          oldPosition: oldPosition,
        );

  final _GymHubButtonTabBarState tabBar;

  bool _viewportDimensionWasNonZero = false;

  bool _needsPixelsCorrection = true;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    bool result = true;
    if (!_viewportDimensionWasNonZero) {
      _viewportDimensionWasNonZero = viewportDimension != 0.0;
    }

    if (!_viewportDimensionWasNonZero || _needsPixelsCorrection) {
      _needsPixelsCorrection = false;
      correctPixels(tabBar._initialScrollOffset(
          viewportDimension, minScrollExtent, maxScrollExtent));
      result = false;
    }
    return super.applyContentDimensions(minScrollExtent, maxScrollExtent) &&
        result;
  }

  void markNeedsPixelsCorrection() {
    _needsPixelsCorrection = true;
  }
}


class _TabBarScrollController extends ScrollController {
  _TabBarScrollController(this.tabBar);

  final _GymHubButtonTabBarState tabBar;

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition? oldPosition) {
    return _TabBarScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      tabBar: tabBar,
    );
  }
}

class GymHubButtonTabBar extends StatefulWidget
    implements PreferredSizeWidget {

  const GymHubButtonTabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.useToggleButtonStyle = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.decoration,
    this.unselectedDecoration,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.unselectedBorderColor = Colors.transparent,
    this.physics = const BouncingScrollPhysics(),
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.buttonMargin = const EdgeInsets.all(4),
    this.padding = EdgeInsets.zero,
    this.borderRadius = 8.0,
    this.elevation = 0,
  }) : super(key: key);


  final List<Widget> tabs;

  final TabController? controller;

  final bool isScrollable;

  final bool useToggleButtonStyle;

  final Color? backgroundColor;


  final Color? unselectedBackgroundColor;

  final BoxDecoration? decoration;


  final BoxDecoration? unselectedDecoration;


  final TextStyle? labelStyle;

  final Color? labelColor;

  final Color? unselectedLabelColor;


  final TextStyle? unselectedLabelStyle;

  final double borderWidth;


  final Color? borderColor;


  final Color? unselectedBorderColor;


  final EdgeInsetsGeometry labelPadding;


  final EdgeInsetsGeometry buttonMargin;

  final EdgeInsetsGeometry? padding;

  final double borderRadius;

  final double elevation;

  final DragStartBehavior dragStartBehavior;

  final ValueChanged<int>? onTap;

  final ScrollPhysics? physics;


  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(
        maxHeight + labelPadding.vertical + buttonMargin.vertical);
  }

  @override
  State<GymHubButtonTabBar> createState() =>
      _GymHubButtonTabBarState();
}

class _GymHubButtonTabBarState extends State<GymHubButtonTabBar>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _controller;
  _IndicatorPainter? _indicatorPainter;
  late AnimationController _animationController;
  int _currentIndex = 0;
  int _prevIndex = -1;

  late double _tabStripWidth;
  late List<GlobalKey> _tabKeys;

  final GlobalKey _tabsParentKey = GlobalKey();

  bool _debugHasScheduledValidTabsCountCheck = false;

  @override
  void initState() {
    super.initState();

    _tabKeys = widget.tabs.map((tab) => GlobalKey()).toList();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _animationController
      ..value = 1.0
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.maybeOf(context);
    assert(() {
      if (newController == null) {
        throw FlutterError(
          'No TabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must either provide an explicit '
          'TabController using the "controller" property, or you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.\n'
          'In this case, there was neither an explicit controller nor a default controller.',
        );
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _initIndicatorPainter() {
    _indicatorPainter = !_controllerIsValid
        ? null
        : _IndicatorPainter(
            controller: _controller!,
            tabKeys: _tabKeys,
            old: _indicatorPainter,
          );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
    _initIndicatorPainter();
  }

  @override
  void didUpdateWidget(GymHubButtonTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _initIndicatorPainter();
      // Adjust scroll position.
      if (_scrollController != null) {
        final ScrollPosition position = _scrollController!.position;
        if (position is _TabBarScrollPosition) {
          position.markNeedsPixelsCorrection();
        }
      }
    }

    if (widget.tabs.length > _tabKeys.length) {
      final int delta = widget.tabs.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.tabs.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.tabs.length, _tabKeys.length);
    }
  }

  @override
  void dispose() {
    _indicatorPainter!.dispose();
    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = null;
    // We don't own the _controller Animation, so it's not disposed here.
    super.dispose();
  }

  int get maxTabIndex => _indicatorPainter!.maxTabIndex;

  double _tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    if (!widget.isScrollable) {
      return 0.0;
    }
    double tabCenter = _indicatorPainter!.centerOf(index);
    double paddingStart;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        paddingStart = widget.padding?.resolve(TextDirection.rtl).right ?? 0;
        tabCenter = _tabStripWidth - tabCenter;
        break;
      case TextDirection.ltr:
        paddingStart = widget.padding?.resolve(TextDirection.ltr).left ?? 0;
        break;
    }

    return clampDouble(
        tabCenter + paddingStart - viewportWidth / 2.0, minExtent, maxExtent);
  }

  double _tabCenteredScrollOffset(int index) {
    final ScrollPosition position = _scrollController!.position;
    return _tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
  }

  double _initialScrollOffset(
      double viewportWidth, double minExtent, double maxExtent) {
    return _tabScrollOffset(_currentIndex, viewportWidth, minExtent, maxExtent);
  }

  void _scrollToCurrentIndex() {
    final double offset = _tabCenteredScrollOffset(_currentIndex);
    _scrollController!
        .animateTo(offset, duration: kTabScrollDuration, curve: Curves.ease);
  }

  void _scrollToControllerValue() {
    final double? leadingPosition =
        _currentIndex > 0 ? _tabCenteredScrollOffset(_currentIndex - 1) : null;
    final double middlePosition = _tabCenteredScrollOffset(_currentIndex);
    final double? trailingPosition = _currentIndex < maxTabIndex
        ? _tabCenteredScrollOffset(_currentIndex + 1)
        : null;

    final double index = _controller!.index.toDouble();
    final double value = _controller!.animation!.value;
    final double offset;
    if (value == index - 1.0) {
      offset = leadingPosition ?? middlePosition;
    } else if (value == index + 1.0) {
      offset = trailingPosition ?? middlePosition;
    } else if (value == index) {
      offset = middlePosition;
    } else if (value < index) {
      offset = leadingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, leadingPosition, index - value)!;
    } else {
      offset = trailingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, trailingPosition, value - index)!;
    }

    _scrollController!.jumpTo(offset);
  }

  void _handleTabControllerAnimationTick() {
    assert(mounted);
    if (!_controller!.indexIsChanging && widget.isScrollable) {
      // Sync the TabBar's scroll position with the TabBarView's PageView.
      _currentIndex = _controller!.index;
      _scrollToControllerValue();
    }
  }

  void _handleTabControllerTick() {
    if (_controller!.index != _currentIndex) {
      _prevIndex = _currentIndex;
      _currentIndex = _controller!.index;
      _triggerAnimation();
      if (widget.isScrollable) {
        _scrollToCurrentIndex();
      }
    }
    setState(() {
      // Rebuild the tabs after a (potentially animated) index change
      // has completed.
    });
  }

  void _triggerAnimation() {
    // reset the animation so it's ready to go
    _animationController
      ..reset()
      ..forward();
  }

  // Called each time layout completes.
  void _saveTabOffsets(
      List<double> tabOffsets, TextDirection textDirection, double width) {
    _tabStripWidth = width;
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.tabs.length);
    _controller?.animateTo(index);
    widget.onTap?.call(index);
  }

  Widget _buildStyledTab(Widget child, int index) {
    final tabBarTheme = TabBarTheme.of(context);

    final double animationValue;
    if (index == _currentIndex) {
      animationValue = _animationController.value;
    } else if (index == _prevIndex) {
      animationValue = 1 - _animationController.value;
    } else {
      animationValue = 0;
    }

    final TextStyle? textStyle = TextStyle.lerp(
        (widget.unselectedLabelStyle ??
                tabBarTheme.labelStyle ??
                DefaultTextStyle.of(context).style)
            .copyWith(
          color: widget.unselectedLabelColor,
        ),
        (widget.labelStyle ??
                tabBarTheme.labelStyle ??
                DefaultTextStyle.of(context).style)
            .copyWith(
          color: widget.labelColor,
        ),
        animationValue);

    final Color? textColor = Color.lerp(
        widget.unselectedLabelColor, widget.labelColor, animationValue);

    final Color? borderColor = Color.lerp(
        widget.unselectedBorderColor, widget.borderColor, animationValue);

    BoxDecoration? boxDecoration = BoxDecoration.lerp(
        BoxDecoration(
          color: widget.unselectedDecoration?.color ??
              widget.unselectedBackgroundColor ??
              Colors.transparent,
          boxShadow: widget.unselectedDecoration?.boxShadow,
          gradient: widget.unselectedDecoration?.gradient,
          borderRadius: widget.useToggleButtonStyle
              ? null
              : BorderRadius.circular(widget.borderRadius),
        ),
        BoxDecoration(
          color: widget.decoration?.color ??
              widget.backgroundColor ??
              Colors.transparent,
          boxShadow: widget.decoration?.boxShadow,
          gradient: widget.decoration?.gradient,
          borderRadius: widget.useToggleButtonStyle
              ? null
              : BorderRadius.circular(widget.borderRadius),
        ),
        animationValue);

    if (widget.useToggleButtonStyle &&
        widget.borderWidth > 0 &&
        boxDecoration != null) {
      if (index == 0) {
        boxDecoration = boxDecoration.copyWith(
          border: Border(
            right: BorderSide(
              color: widget.unselectedBorderColor ?? Colors.transparent,
              width: widget.borderWidth / 2,
            ),
          ),
        );
      } else if (index == widget.tabs.length - 1) {
        boxDecoration = boxDecoration.copyWith(
          border: Border(
            left: BorderSide(
              color: widget.unselectedBorderColor ?? Colors.transparent,
              width: widget.borderWidth / 2,
            ),
          ),
        );
      } else {
        boxDecoration = boxDecoration.copyWith(
          border: Border.symmetric(
            vertical: BorderSide(
              color: widget.unselectedBorderColor ?? Colors.transparent,
              width: widget.borderWidth / 2,
            ),
          ),
        );
      }
    }

    return Padding(
      key: _tabKeys[index],
      // padding for the buttons
      padding:
          widget.useToggleButtonStyle ? EdgeInsets.zero : widget.buttonMargin,
      child: TextButton(
        onPressed: () => _handleTap(index),
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(
              widget.useToggleButtonStyle ? 0 : widget.elevation),

          /// give a pretty small minimum size
          minimumSize: WidgetStateProperty.all(const Size(10, 10)),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          textStyle: WidgetStateProperty.all(textStyle),
          foregroundColor: WidgetStateProperty.all(textColor),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStateProperty.all(
            widget.useToggleButtonStyle
                ? const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  )
                : RoundedRectangleBorder(
                    side: (widget.borderWidth == 0)
                        ? BorderSide.none
                        : BorderSide(
                            color: borderColor ?? Colors.transparent,
                            width: widget.borderWidth,
                          ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
          ),
        ),
        child: Ink(
          decoration: boxDecoration,
          child: Container(
            padding: widget.labelPadding,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  bool _debugScheduleCheckHasValidTabsCount() {
    if (_debugHasScheduledValidTabsCountCheck) {
      return true;
    }
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _debugHasScheduledValidTabsCountCheck = false;
      if (!mounted) {
        return;
      }
      assert(() {
        if (_controller!.length != widget.tabs.length) {
          throw FlutterError(
            "Controller's length property (${_controller!.length}) does not match the "
            "number of tabs (${widget.tabs.length}) present in TabBar's tabs property.",
          );
        }
        return true;
      }());
    });
    _debugHasScheduledValidTabsCountCheck = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugScheduleCheckHasValidTabsCount());

    if (_controller!.length == 0) {
      return Container(
        height: _kTabHeight +
            widget.labelPadding.vertical +
            widget.buttonMargin.vertical,
      );
    }

    final List<Widget> wrappedTabs =
        List<Widget>.generate(widget.tabs.length, (int index) {
      return _buildStyledTab(widget.tabs[index], index);
    });

    final int tabCount = widget.tabs.length;
    // Add the tap handler to each tab. If the tab bar is not scrollable,
    // then give all of the tabs equal flexibility so that they each occupy
    // the same share of the tab bar's overall width.

    for (int index = 0; index < tabCount; index += 1) {
      if (!widget.isScrollable) {
        wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
      }
    }

    Widget tabBar = AnimatedBuilder(
      animation: _animationController,
      key: _tabsParentKey,
      builder: (context, child) {
        Widget tabBarTemp = _TabLabelBar(
          onPerformLayout: _saveTabOffsets,
          children: wrappedTabs,
        );

        if (widget.useToggleButtonStyle) {
          tabBarTemp = Material(
            shape: widget.useToggleButtonStyle
                ? RoundedRectangleBorder(
                    side: (widget.borderWidth == 0)
                        ? BorderSide.none
                        : BorderSide(
                            color: widget.borderColor ?? Colors.transparent,
                            width: widget.borderWidth,
                            style: BorderStyle.solid,
                          ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  )
                : null,
            elevation: widget.useToggleButtonStyle ? widget.elevation : 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: tabBarTemp,
          );
        }
        return CustomPaint(
          painter: _indicatorPainter,
          child: tabBarTemp,
        );
      },
    );

    if (widget.isScrollable) {
      _scrollController ??= _TabBarScrollController(this);
      tabBar = SingleChildScrollView(
        dragStartBehavior: widget.dragStartBehavior,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        padding: widget.padding,
        physics: widget.physics,
        child: tabBar,
      );
    } else if (widget.padding != null) {
      tabBar = Padding(
        padding: widget.padding!,
        child: tabBar,
      );
    }

    return tabBar;
  }
}
