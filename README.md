# SliverCenter
<p align="center">
  <a href="https://pub.dev/packages/sliver_center"><img src="https://img.shields.io/pub/v/sliver_center" alt="pub"></a>
  <a href="https://app.codecov.io/github/DemienIlnutskiy/flutter_sliver_center"><img src="https://img.shields.io/codecov/c/github/DemienIlnutskiy/flutter_sliver_center" alt="pub"></a>
  <a href="https://github.com/DemienIlnutskiy/flutter_sliver_center/actions/workflows/generate_code_coverate.yaml"><img src="https://img.shields.io/github/actions/workflow/status/DemienIlnutskiy/flutter_sliver_center/generate_code_coverate.yaml?event=push&branch=main&label=tests&logo=github" alt="tests"></a>
  <a href="https://github.com/DemienIlnutskiy/flutter_sliver_center/actions/workflows/ci.yaml">
    <img src="https://img.shields.io/github/actions/workflow/status/DemienIlnutskiy/flutter_sliver_center/ci.yaml?event=pull_request&label=Code%20Analysis%20%26%20Formatting&logo=github" 
        alt="Code Analysis & Formatting">
  </a>
</p>

A Flutter widget that centers its sliver child within the available space along the cross axis.  This is particularly useful when you want to ensure a sliver, such as a `SliverList` or `SliverGrid`, is positioned in the center of its parent, regardless of the parent's size.

## Preview

<a href="https://github.com/DemienIlnutskiy/flutter_sliver_center/blob/main/assets/read_me/sliver_center_preview.gif">
  <img src="https://raw.githubusercontent.com/DemienIlnutskiy/flutter_sliver_center/main/assets/read_me/sliver_center_preview.gif" alt="gif_preview">
</a>

<p align="center">
  <a href="https://github.com/DemienIlnutskiy/flutter_sliver_center/blob/main/assets/read_me/big_screen_preview.png">
    <img src="https://raw.githubusercontent.com/DemienIlnutskiy/flutter_sliver_center/main/assets/read_me/big_screen_preview.png" alt="big_screen_preview">
  </a>
</p>

<p align="center">
  <a href="https://github.com/DemienIlnutskiy/flutter_sliver_center/blob/main/assets/read_me/small_screen_preview.png">
    <img src="https://raw.githubusercontent.com/DemienIlnutskiy/flutter_sliver_center/main/assets/read_me/small_screen_preview.png" alt="small_screen_preview">
  </a>
</p>

## Usage

Wrap your sliver child with `SliverCenter` to center it.  `SliverCenter` works within the context of a `CustomScrollView` and its sliver layout system.


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
