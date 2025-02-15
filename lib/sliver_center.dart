import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverCenter extends SingleChildRenderObjectWidget {
  const SliverCenter({
    required Widget sliver,
  }) : super(child: sliver);

  @override
  RenderSliver createRenderObject(BuildContext context) {
    return _RenderSliverCenter();
  }
}

// RenderObject class for SliverCenter
class _RenderSliverCenter extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  _RenderSliverCenter();

  bool leftPaddingAdded = false;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    child!.layout(constraints, parentUsesSize: true);

    final childGeometry = child!.geometry;
    // Ensure the offset is clamped within the valid range
    if (childGeometry != null) {
      geometry = SliverGeometry(
        scrollExtent: childGeometry.scrollExtent,
        paintExtent: childGeometry.paintExtent,
        maxPaintExtent: childGeometry.maxPaintExtent,
        layoutExtent: childGeometry.layoutExtent,
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      center();
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        context.paintChild(
          child!,
          offset + (parentData.paintOffset),
        );
      }
    }
  }

  @override
  bool hitTestSelf({
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    return false;
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child == null) {
      return false;
    }

    final parentData = child!.parentData;
    if (parentData is SliverPhysicalParentData) {
      final adjustedCrossAxisPosition =
          crossAxisPosition - parentData.paintOffset.dx;

      return child!.hitTest(
        result,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: adjustedCrossAxisPosition,
      );
    }
    return false;
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    final childParentData = child.parentData;
    if (child.parentData is SliverPhysicalParentData) {
      (childParentData! as SliverPhysicalParentData)
          .applyPaintTransform(transform);
    }
  }

  void center() {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        final parentConstaints = parent?.constraints;
        if (parentConstaints != null) {
          final double? parentSize;
          if (parentConstaints is BoxConstraints) {
            parentSize = parentConstaints.maxWidth;
          } else if (parentConstaints is SliverConstraints) {
            parentSize = parentConstaints.crossAxisExtent;
          } else {
            parentSize = null;
          }
          if (parentSize != null) {
            final childConstaints = child!.constraints;
            final childSize = childConstaints.crossAxisExtent;
            final horizontalPadding = parentSize - childSize;
            parentData.paintOffset = Offset(horizontalPadding / 2, 0);
            leftPaddingAdded = true;
            return;
          }
        }
      }
      if (leftPaddingAdded) {
        final parentData = child!.parentData;
        if (parentData is SliverPhysicalParentData) {
          parentData.paintOffset = Offset.zero;
          leftPaddingAdded = false;
        }
      }
    }
  }
}
