import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/layer_widget.dart';
import 'paint_editor/painted_model.dart';

/// Represents a layer with common properties for widgets.
class Layer {
  /// The position offset of the widget.
  late Offset offset;

  /// The rotation, scale, and opacity values of the widget.
  late double rotation, scale, opacity;

  /// Flags to control horizontal and vertical flipping.
  late bool flipX, flipY, isSelected;

  /// A unique identifier for the layer.
  late String id;

  /// Creates a new layer with optional properties.
  ///
  /// The [id] parameter can be used to provide a custom identifier for the layer.
  /// The [offset] parameter determines the position offset of the widget.
  /// The [opacity] parameter sets the opacity of the widget (default is 1).
  /// The [rotation] parameter sets the rotation angle of the widget in degrees (default is 0).
  /// The [scale] parameter sets the scale factor of the widget (default is 1).
  /// The [flipX] parameter controls horizontal flipping (default is false).
  /// The [flipY] parameter controls vertical flipping (default is false).
  Layer({
    String? id,
    Offset? offset,
    double? opacity,
    double? rotation,
    double? scale,
    bool? flipX,
    bool? flipY,
    bool? isSelected,
  }) {
    // Initialize properties with provided values or defaults.
    this.id = id ?? _generateUniqueId();
    this.offset = offset ?? const Offset(64, 64);
    this.opacity = opacity ?? 1;
    this.rotation = rotation ?? 0;
    this.scale = scale ?? 1;
    this.flipX = flipX ?? false;
    this.flipY = flipY ?? false;
    this.isSelected = isSelected ?? false;
  }

  /// Generates a unique ID based on the current time.
  String _generateUniqueId() {
    const String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    final Random random = Random();
    final String timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
        .toRadixString(36)
        .padLeft(8, '0');

    String randomPart = '';
    for (int i = 0; i < 20; i++) {
      randomPart += characters[random.nextInt(characters.length)];
    }

    return '$timestamp$randomPart';
  }
}

/// Represents a text layer with customizable properties.
class TextLayerData extends Layer {
  /// The text content of the layer.
  String text;

  /// The color mode for the text.
  LayerBackgroundColorModeE? colorMode;

  /// The text color.
  Color color;

  /// The background color for the text.
  Color background;

  /// The position of the color picker (if applicable).
  double? colorPickerPosition;

  /// The text alignment within the layer.
  TextAlign align;

  /// The text fontFamily within the layer.
  String fontFamily;

  /// The text fontWeight within the layer.
  FontWeight fontWeight;

  /// Creates a new text layer with customizable properties.
  ///
  /// The [text] parameter specifies the text content of the layer.
  /// The [colorMode] parameter sets the color mode for the text.
  /// The [colorPickerPosition] parameter sets the position of the color picker (if applicable).
  /// The [color] parameter specifies the text color (default is Colors.white).
  /// The [background] parameter defines the background color for the text (default is Colors.transparent).
  /// The [align] parameter determines the text alignment within the layer (default is TextAlign.left).
  /// The other optional parameters such as [offset], [opacity], [rotation], [scale], [id], [flipX], and [flipY]
  /// can be used to customize the position, appearance, and behavior of the text layer.
  TextLayerData({
    required this.text,
    this.colorMode,
    this.colorPickerPosition,
    this.color = Colors.white,
    this.background = Colors.transparent,
    this.align = TextAlign.left,
    this.fontFamily = "",
    this.fontWeight = FontWeight.normal,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
    super.id,
    super.flipX,
    super.flipY,
    super.isSelected,
  });
}

/// A class representing a layer with emoji content.
///
/// EmojiLayerData is a subclass of [Layer] that allows you to display emoji
/// on a canvas. You can specify the emoji to display, along with optional
/// properties like offset, opacity, rotation, scale, and more.
///
/// Example usage:
/// ```dart
/// EmojiLayerData(
///   emoji: '😀',
///   offset: Offset(100.0, 100.0),
///   opacity: 0.8,
///   rotation: 45.0,
///   scale: 2.0,
/// );
/// ```
class EmojiLayerData extends Layer {
  /// The emoji to display on the layer.
  String emoji;

  /// Creates an instance of EmojiLayerData.
  ///
  /// The [emoji] parameter is required, and other properties are optional.
  EmojiLayerData({
    required this.emoji,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
    super.id,
    super.flipX,
    super.flipY,
    super.isSelected,
  });
}

/// A class representing a layer with custom painting content.
///
/// PaintingLayerData is a subclass of [Layer] that allows you to display
/// custom-painted content on a canvas. You can specify the painted item and
/// its raw size, along with optional properties like offset, opacity, rotation,
/// scale, and more.
///
/// Example usage:
/// ```dart
/// PaintingLayerData(
///   item: CustomPaintedItem(),
///   rawSize: Size(200.0, 150.0),
///   offset: Offset(50.0, 50.0),
///   opacity: 0.9,
///   rotation: -30.0,
///   scale: 1.5,
/// );
/// ```
class PaintingLayerData extends Layer {
  /// The custom-painted item to display on the layer.
  final PaintedModel item;

  /// The raw size of the painted item before applying scaling.
  final Size rawSize;

  /// Creates an instance of PaintingLayerData.
  ///
  /// The [item] and [rawSize] parameters are required, and other properties
  /// are optional.
  PaintingLayerData({
    required this.item,
    required this.rawSize,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
    super.id,
    super.flipX,
    super.flipY,
    super.isSelected,
  });

  /// Returns the size of the layer after applying the scaling factor.
  Size get size => Size(rawSize.width * scale, rawSize.height * scale);
}

class StickerLayerData extends Layer {
  /// The sticker to display on the layer.
  Widget sticker;

  /// Creates an instance of StickerLayerData.
  ///
  /// The [sticker] parameter is required, and other properties are optional.
  StickerLayerData({
    required this.sticker,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
    super.id,
    super.flipX,
    super.flipY,
  });
}
