import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme.dart';
import '../../../data/mock_posts.dart';
import '../../../data/models.dart';
import '../../../shared/frosted_panel.dart';

/// Avatar + gradient "Ready to share" pill + community label.
class PostHeaderRow extends StatelessWidget {
  const PostHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            image: const DecorationImage(
              image: AssetImage('assets/images/avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.pillPink, AppColors.pillPurple]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text('✨ Ready to share',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 4),
              const Text('High-converting in Oriflame Community',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Pick 1 of 3" counter pill (top-right of the post).
class PickCounter extends StatelessWidget {
  const PickCounter({super.key, required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('${index + 1} of $total',
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}

/// Right-edge vertical page dots on a small dark blur pill (per Figma).
class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return FrostedPanel(
      radius: 18,
      color: Colors.black.withValues(alpha: 0.28),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < total; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == index ? AppColors.brandGreen : Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// "♫ Recommended: `track` by `artist`" strip.
class MusicRow extends StatelessWidget {
  const MusicRow({super.key, required this.post});

  final SmartPost post;

  @override
  Widget build(BuildContext context) {
    return FrostedPanel(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      color: Colors.black.withValues(alpha: 0.20),
      child: Row(
        children: [
          const Icon(Icons.music_note, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 14),
                children: [
                  const TextSpan(text: 'Recommended:  '),
                  TextSpan(
                      text: post.trackTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic)),
                  TextSpan(text: ' by ${post.trackArtist}'),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Product card ("Girodani Gold Lipstick · trending · 30% off").
/// Designer note: fades in from bottom after 3 s; whole box is clickable →
/// personal beauty store link.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FrostedPanel(
        padding: const EdgeInsets.all(8),
        color: Colors.white24,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: AppColors.cream,
                width: 56,
                height: 56,
                child: Image.asset(product.thumbAsset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${product.name}  ${product.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.trending_up,
                          color: Colors.white, size: 15),
                      const SizedBox(width: 4),
                      const Flexible(
                        child: Text('Trending right now and on sale',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white, fontSize: 11.5)),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.deepGreen,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(product.discount,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

/// Caption block: "CAPTION SUGGESTION / Edit Caption" header, collapsible
/// caption text, referral code + link. Tap → edit caption page.
class CaptionBlock extends StatefulWidget {
  const CaptionBlock({super.key, required this.post, required this.onEdit});

  final SmartPost post;
  final VoidCallback onEdit;

  @override
  State<CaptionBlock> createState() => _CaptionBlockState();
}

class _CaptionBlockState extends State<CaptionBlock> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    const italic = TextStyle(
        color: Colors.white70, fontSize: 13.5, fontStyle: FontStyle.italic);
    return GestureDetector(
      onTap: widget.onEdit,
      child: FrostedPanel(
        color: Colors.black.withValues(alpha: 0.24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('AI',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 8),
                const Text('CAPTION SUGGESTION',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5)),
                const Spacer(),
                const Icon(Icons.edit, color: Colors.white, size: 16),
                const SizedBox(width: 5),
                const Text('Edit Caption',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _expanded = !_expanded);
              },
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  // ponytail: fixed cap fits the 3 demo captions on phone
                  // screens; swap to LayoutBuilder if tablet support matters.
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: SingleChildScrollView(
                    physics: _expanded
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.35),
                        children: [
                          TextSpan(
                              text: _expanded
                                  ? widget.post.caption
                                  : '${widget.post.caption.substring(0, 96)}... '),
                          if (!_expanded)
                            const TextSpan(
                                text: 'see more',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Use my referral code: $referralCode', style: italic),
            const Text('Use my referral link: $referralLink', style: italic),
          ],
        ),
      ),
    );
  }
}

/// "Quick share to:" horizontally scrollable icon row.
class QuickShareRow extends StatelessWidget {
  const QuickShareRow({super.key, required this.onShare});

  final void Function(SharePlatform) onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Quick share to:',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            // Designer note: "This list is scrollable".
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sharePlatforms.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, i) {
                final p = sharePlatforms[i];
                return GestureDetector(
                  onTap: () => onShare(p),
                  child: ClipOval(
                    child: Image.asset(p.iconAsset,
                        width: 46, height: 46, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
