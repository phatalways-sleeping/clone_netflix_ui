import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_netflix_responsive_ui/assets.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({Key key, @required this.scrollOffset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      child: Responsive(
          mobile: _CustomAppBarMobile(), desktop: _CustomAppBarDesktop()),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Row(children: [
      Image.asset(Assets.netflixLogo0),
      const SizedBox(
        width: 12.0,
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AppBarButton(title: "TV Shows", onTap: () => print("TV Shows")),
            _AppBarButton(title: "Movies", onTap: () => print("Movies")),
            _AppBarButton(title: "My List", onTap: () => print("My List"))
          ],
        ),
      )
    ]));
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Row(children: [
      Image.asset(Assets.netflixLogo1),
      const SizedBox(
        width: 12.0,
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AppBarButton(title: "Home", onTap: () => print("Home")),
            _AppBarButton(title: "TV Shows", onTap: () => print("TV Shows")),
            _AppBarButton(title: "Movies", onTap: () => print("Movies")),
            _AppBarButton(title: "Latest", onTap: () => print("Latest")),
            _AppBarButton(title: "My List", onTap: () => print("My List"))
          ],
        ),
      ),
      const Spacer(),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () => print("Search"),
                icon: const Icon(Icons.search)),
            _AppBarButton(title: "KIDS", onTap: () => print("KIDS")),
            _AppBarButton(title: "DVD", onTap: () => print("DVD")),
            IconButton(
                padding: EdgeInsets.zero,
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () => print("Gift"),
                icon: const Icon(Icons.card_giftcard)),
            IconButton(
                padding: EdgeInsets.zero,
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () => print("Notifications"),
                icon: const Icon(Icons.notifications))
          ],
        ),
      )
    ]));
  }
}

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({Key key, @required this.title, @required this.onTap})
      : super(key: key);
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
