import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_center/render_sliver_center.dart';

class SliverCenter extends SingleChildRenderObjectWidget {
  const SliverCenter({
    required Widget sliver,
    super.key,
  }) : super(child: sliver);

  @override
  RenderSliver createRenderObject(BuildContext context) {
    return RenderSliverCenter();
  }
}
