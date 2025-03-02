import 'package:flutter/rendering.dart';

class RenderSliverCenter extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  double? horizontalPadding;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    // Layout the child with the current constraints
    child!.layout(constraints, parentUsesSize: true);

    final childGeometry = child!.geometry;
    if (childGeometry != null) {
      // Update the center offset during layout so we don't recalc on each paint
      _updateCenterOffset();
      geometry = SliverGeometry(
        scrollExtent: childGeometry.scrollExtent,
        paintExtent: childGeometry.paintExtent,
        maxPaintExtent: childGeometry.maxPaintExtent,
        layoutExtent: childGeometry.layoutExtent,
      );
    }
  }

  /// Helper method to calculate left padding for centering
  /// and update the paintOffset.
  void _updateCenterOffset() {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        final parentConstraints = parent?.constraints;
        double? parentSize;
        if (parentConstraints is BoxConstraints) {
          parentSize = parentConstraints.maxWidth;
        } else if (parentConstraints is SliverConstraints) {
          parentSize = parentConstraints.crossAxisExtent;
        }
        if (parentSize != null) {
          final childConstraints = child!.constraints;
          final childSize = childConstraints.crossAxisExtent;
          double crossAxisPadding;
          if (child != null && child is RenderSliverConstrainedCrossAxis) {
            final childMaxExtent =
                (child! as RenderSliverConstrainedCrossAxis).maxExtent;
            crossAxisPadding = childSize - childMaxExtent;
          } else {
            crossAxisPadding = parentSize - childSize;
          }
          horizontalPadding = crossAxisPadding / 2;
          parentData.paintOffset = Offset(horizontalPadding!, 0);
        }
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        // Use the precomputed paintOffset from performLayout
        context.paintChild(child!, offset + parentData.paintOffset);
      }
    }
  }

  // Overriding hitTest to extend the hit area to the right side.
  @override
  bool hitTest(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child == null || horizontalPadding == null) return false;

    // Get the child's width from its constraints.
    final childWidth = child!.constraints.crossAxisExtent;
    // The effective hit area for the child starts at horizontalPadding (child's
    // left offset)
    // and extends for childWidth.
    final effectiveLeft = horizontalPadding!;
    final effectiveRight = effectiveLeft + childWidth;

    // If the hit position is outside the effective horizontal region, return
    // false.
    if (crossAxisPosition < effectiveLeft ||
        crossAxisPosition > effectiveRight) {
      return false;
    }

    // Adjust crossAxisPosition to the child's coordinate space.
    final adjustedCrossAxisPosition = crossAxisPosition - effectiveLeft;
    // Delegate the hit test to the child.
    return child!.hitTest(
      result,
      mainAxisPosition: mainAxisPosition,
      crossAxisPosition: adjustedCrossAxisPosition,
    );
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child == null) return false;
    if (horizontalPadding != null) {
      final adjustedCrossAxisPosition = crossAxisPosition - horizontalPadding!;
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
    if (childParentData is SliverPhysicalParentData) {
      childParentData.applyPaintTransform(transform);
    }
  }
}
