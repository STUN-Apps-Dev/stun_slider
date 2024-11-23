# Stun slider

Виджет `StunSlider`, который автоматически подстраивает свою высоту под текущую отображаемую страницу.

Поддерживает те же параметры, что и классический `PageView`.

В пакет входят вспомогательные виджеты для управления слайдером и отображения пагинации.

| Horizontal                                                                                           | Vertical                                                                                                      |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| <img height="800" src="https://github.com/STUN-Apps-Dev/stun_slider/blob/main/assets/horizontal.gif?raw=true"> | <img  height="800" src="https://github.com/STUN-Apps-Dev/stun_slider/blob/main/assets/vertical.gif?raw=true"> |

## Локализация
Please refer to the documentation in English at this link: [https://github.com/STUN-Apps-Dev/stun_slider/blob/master/README.md].

## Начало работы

Добавьте следующую строку в секцию `dependencies` вашего `pubspec.yaml`:
```yaml
dependencies:
  stun_slider: <latest-version>
```
После этого выполните команду:
```shell
flutter pub get
```

Импортируйте библиотеку:
```dart
import 'package:stun_slider/stun_slider.dart';
```

## Примеры использования

### Фиксированный StunSlider
Для создания фиксированного `StunSlider` передайте список виджетов в параметр `children`:
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

### Динамически создаваемый StunSlider
Если у вас много страниц, и вы хотите создавать их динамически при прокрутке, 
используйте конструктор `.builder`, передав параметры `itemCount` и `itemBuilder`:
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

### Контроллер для управления слайдером

`StunSliderController` предоставляет методы для переключения страниц слайдера:
```dart
final _controller = StunSliderController();
```

Если вы хотите определить свой кастомный `PageController`,
то необходимо передать в конструкторе его экземпляр:
```dart
final pageController = PageController();
final _controller = StunSliderController(pageController);
```

Примеры использования
```dart
_controller.previousPage();
_controller.nextPage();
_controller.jumpToIndex(1);
```

### Дополнительные компоненты

Дополнительные компоненты UI позволяют создавать кастомные элементы управления для слайдера.

Для работы в связке со слайдером необходимо объединить все компоненты общим контроллером

#### Кнопк для навигации назад/вперед

Назад
```dart
StunSliderNavButton.prev(
    itemCount: _items.length,
    controller: _controller,
    child: const Icon(Icons.arrow_back), // Используйте свой виджет
)
```

Вперед
```dart
StunSliderNavButton.next(
    itemCount: 3,
    controller: _controller,
    child: const Icon(Icons.arrow_back), // Используйте свой виджет
)
```

#### Элемент пагинации
`StunSliderPagination` позволяет делать кастомный элемент пагинации

```dart
StunSliderPagination(
    controller: _controller,
    itemBuilder: (context, index, isActive) {
          return Container(
              height: 40,
              width: 40,
              color: isActive ? Colors.amber : Colors.grey,
              child: Center(child: Text('$index')),
          );
      },
    itemCount: _items.length,
),
```

## Пример
Полный пример использования доступен в папке [example/](https://github.com/STUN-Apps-Dev/stun_slider)).