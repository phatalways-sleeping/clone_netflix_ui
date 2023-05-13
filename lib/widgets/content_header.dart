import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:video_player/video_player.dart';
import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featureContent;

  const ContentHeader({Key key, @required this.featureContent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Responsive(
        mobile: _ContentHeaderMobile(
          featureContent: featureContent,
        ),
        desktop: _ContentHeaderDesktop(featureContent: featureContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featureContent;

  const _ContentHeaderMobile({Key key, @required this.featureContent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(featureContent.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featureContent.titleImageUrl),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: "List",
                  onTap: () => print("My List"),
                ),
                _PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: "Info",
                  onTap: () => print("Info"),
                )
              ],
            ))
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featureContent;

  const _ContentHeaderDesktop({Key key, @required this.featureContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoController;
  bool isMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    _videoController =
        VideoPlayerController.network(widget.featureContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: _videoController.value.isInitialized
                  ? VideoPlayer(_videoController)
                  : Image.asset(
                      widget.featureContent.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: 500.0,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
          Positioned(
              left: 60.0,
              right: 60.0,
              bottom: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: Image.asset(widget.featureContent.titleImageUrl),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    widget.featureContent.description,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2.0, 4.0),
                              blurRadius: 6.0)
                        ]),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      _PlayButton(),
                      const SizedBox(
                        width: 16.0,
                      ),
                      TextButton.icon(
                          onPressed: () => print("More Info"),
                          icon: const Icon(Icons.info_outline),
                          style: ButtonStyle(
                              iconColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          label: const Text("More Info",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(
                        width: 16.0,
                      ),
                      if (_videoController.value.isInitialized)
                        IconButton(
                            onPressed: () => setState(() {
                                  isMuted
                                      ? _videoController.setVolume(100)
                                      : _videoController.setVolume(0);
                                  isMuted = !isMuted;
                                }),
                            iconSize: 30.0,
                            color: Colors.white,
                            icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            iconColor: MaterialStatePropertyAll(Colors.black),
            padding: MaterialStatePropertyAll(
                const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0))),
        onPressed: () => print("Play"),
        icon: const Icon(
          Icons.play_arrow,
          size: 30.0,
        ),
        label: const Text(
          "Play",
          style: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
        ));
  }
}
