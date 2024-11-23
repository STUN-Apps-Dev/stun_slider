# Stun Slider

The `StunSlider` widget automatically adjusts its height to match the currently displayed page.

It supports the same parameters as the classic `PageView`.

The package includes helper widgets for controlling the slider and displaying pagination.

| Horizontal                                                                                                       | Vertical                                                                                                      |
|------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| <img height="800" src="https://github.com/STUN-Apps-Dev/stun_slider/blob/master/assets/horizontal.gif?raw=true"> | <img  height="800" src="https://github.com/STUN-Apps-Dev/stun_slider/blob/master/assets/vertical.gif?raw=true"> |

## Localization
С документацией на русском языке можно ознакомиться по этой [ссылке](https://github.com/STUN-Apps-Dev/stun_slider/blob/master/README_RU.md).

## Getting Started

Add the following line to the `dependencies` section of your `pubspec.yaml`:

```yaml
dependencies:
  stun_slider: <latest-version>
```

Then run the command:

```shell
flutter pub get
```

Import the library:

```dart
import 'package:stun_slider/stun_slider.dart';
```

## Usage Examples

### Fixed StunSlider

To create a fixed `StunSlider`, pass a list of widgets to the `children` parameter:

```dart
StunSlider(
  children: [
    Container(
      height: 200,
      width: 200,
      color: Colors.green,
    ),
    Container(
      height: 200,
      width: 200,
      color: Colors.green,
    ),
    Container(
      height: 200,
      width: 200,
      color: Colors.green,
    ),
  ],
),
```

### Dynamically Built StunSlider

If you have many pages and want to create them dynamically while scrolling, use the `.builder` constructor, passing the `itemCount` and `itemBuilder` parameters:

```dart
StunSlider.builder(
  itemCount: 3,
  itemBuilder: (context, index) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.green,
    );
  },
),
```

### Controller for Slider Management

The `StunSliderController` provides methods for switching slider pages:

```dart
final _controller = StunSliderController();
```

If you want to define your custom `PageController`, you need to pass its instance in the constructor:

```dart
final pageController = PageController();
final _controller = StunSliderController(pageController);
```

Usage examples:

```dart
_controller.previousPage();
_controller.nextPage();
_controller.jumpToIndex(1);
```

### Additional Components

Additional UI components allow you to create custom control elements for the slider.

To synchronize with the slider, you need to combine all components with a common controller.

#### Buttons for Back/Forward Navigation

**Back**

```dart
StunSliderNavButton.prev(
  itemCount: _items.length,
  controller: _controller,
  child: const Icon(Icons.arrow_back), // Use your own widget
)
```

**Forward**

```dart
StunSliderNavButton.next(
  itemCount: 3,
  controller: _controller,
  child: const Icon(Icons.arrow_forward), // Use your own widget
)
```

#### Pagination Element

`StunSliderPagination` allows you to create a custom pagination element.

```dart
StunSliderPagination(
  controller: _controller,
  itemCount: 3,
  itemBuilder: (context, index, isActive) {
    return Container(
      height: 40,
      width: 40,
      color: isActive ? Colors.amber : Colors.grey,
      child: Center(child: Text('$index')),
    );
  },
),
```

## Example

A full usage example is available in the [example/](https://github.com/STUN-Apps-Dev/stun_slider) directory.