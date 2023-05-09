import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'const/const.dart';
import 'models/rating_data.dart';

class FunStarRatingWidget extends StatefulWidget {
  const FunStarRatingWidget({
    super.key,
    required this.child,
    this.onRatingValueChanged,
    this.initialRatingValue = 0,
  });

  final Widget child;
  final int initialRatingValue;
  final Function(int)? onRatingValueChanged;

  @override
  State<FunStarRatingWidget> createState() => _FunStarRatingWidgetState();
}

class _FunStarRatingWidgetState extends State<FunStarRatingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final StreamController<int> _streamController;
  late final GlobalKey _globalKey;
  late bool _isPointerUp;
  late double _previousPointerPosition;
  late int _currentRatingValue;

  OverlayEntry? _entry;
  Offset? _widgetOffset;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 0,
      vsync: this,
    );
    _streamController = StreamController<int>.broadcast();
    _streamController.stream.listen((value) {
      _currentRatingValue = value;
    });
    _streamController.sink.add(widget.initialRatingValue);
    _globalKey = GlobalKey();
    _isPointerUp = true;
    _previousPointerPosition = 0;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        key: _globalKey,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: widget.child,
      );

  void _onDragStart(DragStartDetails details) {
    _getWidgetInfo();
    _showOverlay();
    _isPointerUp = false;
    _animationController.forward().whenComplete(
      () {
        if (_isPointerUp) {
          _animationController.reverse().whenComplete(() => _entry!.remove());
        }
      },
    );
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(builder: (context) => _buildOverlay());
    overlay.insert(_entry!);
  }

  void _getWidgetInfo() {
    final RenderBox renderBox =
        _globalKey.currentContext?.findRenderObject() as RenderBox;
    _widgetOffset = renderBox.localToGlobal(Offset.zero);
  }

  Widget _buildOverlay() {
    final ratingWidget = Container(
      padding: const EdgeInsets.all(8.0),
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildStarWidget(mapStarPositionOne),
          _buildStarWidget(mapStarPositionTwo),
          _buildStarWidget(mapStarPositionThree),
          _buildStarWidget(mapStarPositionFour),
          _buildStarWidget(mapStarPositionFive),
        ],
      ),
    );

    final screenSize = MediaQuery.of(context).size;

    final animateBuilder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Opacity(
        opacity: _animationController.value * 1,
        child: Transform.translate(
          offset: Offset(
            (_widgetOffset!.dx / 1.5 -
                    ((screenSize.width / 2 - 75) * _animationController.value))
                .abs(),
            _widgetOffset!.dy -
                (screenSize.height / 4 * _animationController.value),
          ),
          child: Transform.scale(
            scale: _animationController.value,
            child: ratingWidget,
          ),
        ),
      ),
    );

    return Positioned(
      height: 80,
      child: animateBuilder,
    );
  }

  Widget _buildStarWidget(Map<int, RatingData> map) => StreamBuilder<int>(
        stream: _streamController.stream,
        builder: (context, snapshot) => Expanded(
          child: SvgPicture.asset(
            map[_currentRatingValue]?.asset ?? "assets/images/star_empty.svg",
            height: 60.0,
            width: 60.0,
            color: map[_currentRatingValue]?.color ?? Colors.grey,
            colorBlendMode: BlendMode.modulate,
          ),
        ),
      );

  void _onDragUpdate(DragUpdateDetails details) {
    double currentPointerPosition = details.globalPosition.dx;
    bool isIncrement = false;
    bool isDecrement = false;
    if (currentPointerPosition - _previousPointerPosition >= 30.0) {
      isIncrement = true;
      _previousPointerPosition = currentPointerPosition;
    } else {
      if (currentPointerPosition - _previousPointerPosition <= -30.0) {
        isDecrement = true;
        _previousPointerPosition = currentPointerPosition;
      }
    }
    _updateRatingValue(isIncrement, isDecrement);
  }

  void _updateRatingValue(isIncrement, isDecrement) {
    int updatedValue = _currentRatingValue;
    if (isIncrement && _currentRatingValue < 5) {
      updatedValue = _currentRatingValue + 1;
    } else {
      if (isDecrement && _currentRatingValue > 0) {
        updatedValue = _currentRatingValue - 1;
      }
    }
    _streamController.sink.add(updatedValue);
  }

  void _onDragEnd(DragEndDetails details) async {
    _isPointerUp = true;
    if (_animationController.isCompleted) {
      _animationController.reverse().whenComplete(() => _entry!.remove());
      widget.onRatingValueChanged?.call(_currentRatingValue);
    }
  }
}
