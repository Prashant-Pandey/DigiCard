import 'dart:async';

import '../bloc_navigation/navigation_bloc.dart';
import 'package:digi_card/sidebar/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final bool isSidebarOpened = true;
  final _animationDuration = const Duration(milliseconds: 400);

  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void _onPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      _animationController.forward();
      isSidebarOpenedSink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : -screenWidth,
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 55,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "Akhil",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          "akhilkc9@gmail.com",
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.perm_identity, color: Colors.white),
                        ),
                      ),
                      Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32),
                      MenuItem(
                        title: "Home",
                        icon: Icons.home,
                        onTap: () {
                          _onPressed();
                          BlocProvider.of<NavigationBloc>(context).add(
                              new NavigationEvents.onlyEvent(
                                  EventType.HomePageClickedEvent));
                        },
                      ),
                      MenuItem(
                          title: "My Card",
                          icon: Icons.person,
                          onTap: () {
                            _onPressed();
                            BlocProvider.of<NavigationBloc>(context).add(
                                new NavigationEvents.onlyEvent(
                                    EventType.MyCardClickedEvent));
                          }),
                      MenuItem(
                        title: "Add Card",
                        icon: Icons.add_comment,
                      ),
                      Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32),
                      MenuItem(title: "Log Out", icon: Icons.exit_to_app),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _onPressed,
                child: Align(
                  alignment: Alignment(0, -0.9),
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 45,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController.view,
                          color: Color(0xFF1BB5FD),
                          size: 25),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
