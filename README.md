# SliverCenter
<p align="center">
  <a href="https://pub.dev/packages/sliver_center"><img src="https://img.shields.io/pub/v/sliver_center" alt="pub"></a>
  <a href="https://app.codecov.io/github/DemienIlnutskiy/flutter_sliver_center"><img src="https://img.shields.io/codecov/c/github/DemienIlnutskiy/flutter_sliver_center" alt="pub"></a>
</p>

A Flutter widget that centers its sliver child within the available space along the cross axis.  This is particularly useful when you want to ensure a sliver, such as a `SliverList` or `SliverGrid`, is positioned in the center of its parent, regardless of the parent's size.

## Usage

Wrap your sliver child with `SliverCenter` to center it.  `SliverCenter` works within the context of a `CustomScrollView` and its sliver layout system.

## Preview

<img src="https://raw.githubusercontent.com//DemienIlnutskiy/flutter_sliver_center/main/assets/read_me/sliver_center_preview.gif">

|          Pverview           |            Pverview           |
| --------------------------- | ----------------------------- |
| ![](big_screen_preview.png) | ![](small_screen_preview.png) |

## Code

```dart
SliverCenter(
  sliver: SliverList( // Or any other sliver
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.blue,
        );
      },
      childCount: 10,
    ),
  ),
)
```
