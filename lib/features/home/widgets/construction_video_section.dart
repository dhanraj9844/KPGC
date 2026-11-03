import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/section_heading.dart';

class ConstructionVideoSection extends StatelessWidget {
  const ConstructionVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.forest,
      child: SplitLayout(
        leftFlex: 4,
        rightFlex: 5,
        left: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: const LoopingVideo(asset: ImageConfig.constructionVideo),
        ),
      ),
        right: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              light: true,
              eyebrow: 'From vacant land to finished residence',
              title: 'Watch Royal Woods take shape, from empty plot to finished residence.',
              subtitle: 'A cinematic look at how a project grows from raw land into a refined, landscaped home.',
            ),
            const SizedBox(height: 24),
            Text('Illustrative architectural animation. It is not actual construction progress.',
                style: AppText.body(size: 12, color: const Color(0xFF9AA39D))),
          ],
        ),
      ),
    );
  }
}

/// Muted, looping video (browsers allow muted autoplay).
class LoopingVideo extends StatefulWidget {
  const LoopingVideo({super.key, required this.asset});

  final String asset;

  @override
  State<LoopingVideo> createState() => _LoopingVideoState();
}

class _LoopingVideoState extends State<LoopingVideo> {
  late final VideoPlayerController _c = VideoPlayerController.asset(widget.asset);
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _c.initialize();
      await _c.setLooping(true);
      await _c.setVolume(0);
      await _c.play();
      if (mounted) setState(() => _ready = true);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(fit: StackFit.expand, children: [
        Container(color: Colors.black),
        if (_ready)
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(width: _c.value.size.width, height: _c.value.size.height, child: VideoPlayer(_c)),
          )
        else if (_failed)
          Image.asset(ImageConfig.heroImage, fit: BoxFit.cover)
        else
          const LoadingWidget(),
        if (_ready)
          Positioned(
            right: 8,
            bottom: 8,
            child: IconButton(
              tooltip: _c.value.isPlaying ? 'Pause video' : 'Play video',
              color: AppColors.white,
              icon: Icon(_c.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline, size: 34),
              onPressed: () {
                _c.value.isPlaying ? _c.pause() : _c.play();
                setState(() {});
              },
            ),
          ),
      ]),
    );
  }
}
