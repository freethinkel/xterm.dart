import 'dart:ui';
import 'package:flutter/painting.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xterm/src/ui/custom_glyphs.dart';
import 'package:xterm/src/ui/palette_builder.dart';
import 'package:xterm/src/ui/paragraph_cache.dart';
import 'package:xterm/xterm.dart';

/// Encapsulates the logic for painting various terminal elements.
class TerminalPainter {
  TerminalPainter({
    required TerminalTheme theme,
    required TerminalStyle textStyle,
    required TextScaler textScaler,
  })  : _textStyle = textStyle,
        _theme = theme,
        _textScaler = textScaler;

  /// A lookup table from terminal colors to Flutter colors.
  late var _colorPalette = PaletteBuilder(_theme).build();

  /// Size of each character in the terminal.
  late var _cellSize = _measureCharSize();

  /// The cached for cells in the terminal. Should be cleared when the same
  /// cell no longer produces the same visual output. For example, when
  /// [_textStyle] is changed, or when the system font changes.
  final _paragraphCache = ParagraphCache(10240);
  final _customGlyphsPainter = CustomGlyphPainter();

  TerminalStyle get textStyle => _textStyle;
  TerminalStyle _textStyle;
  set textStyle(TerminalStyle value) {
    if (value == _textStyle) return;
    _textStyle = value;
    _cellSize = _measureCharSize();
    _paragraphCache.clear();
  }

  TextScaler get textScaler => _textScaler;
  TextScaler _textScaler = TextScaler.linear(1.0);
  set textScaler(TextScaler value) {
    if (value == _textScaler) return;
    _textScaler = value;
    _cellSize = _measureCharSize();
    _paragraphCache.clear();
  }

  TerminalTheme get theme => _theme;
  TerminalTheme _theme;
  set theme(TerminalTheme value) {
    if (value == _theme) return;
    _theme = value;
    _colorPalette = PaletteBuilder(value).build();
    _paragraphCache.clear();
  }

  Size _measureCharSize() {
    const test = 'mmmmmmmmmm';

    final textStyle = _textStyle.toTextStyle();
    final builder = ParagraphBuilder(textStyle.getParagraphStyle());
    builder.pushStyle(
      textStyle.getTextStyle(textScaler: _textScaler),
    );
    builder.addText(test);

    final paragraph = builder.build();
    paragraph.layout(ParagraphConstraints(width: double.infinity));

    final result = Size(
      paragraph.maxIntrinsicWidth / test.length,
      paragraph.height,
    );

    paragraph.dispose();
    return result;
  }

  /// The size of each character in the terminal.
  Size get cellSize => _cellSize;

  /// When the set of font available to the system changes, call this method to
  /// clear cached state related to font rendering.
  void clearFontCache() {
    _cellSize = _measureCharSize();
    _paragraphCache.clear();
  }

  /// Paints the cursor based on the current cursor type.
  void paintCursor(
    Canvas canvas,
    Offset offset, {
    required TerminalCursorType cursorType,
    bool hasFocus = true,
  }) {
    final paint = Paint()
      ..color = _theme.cursor
      ..strokeWidth = 1;

    switch (cursorType) {
      case TerminalCursorType.block:
        paint.style = !hasFocus ? PaintingStyle.stroke : PaintingStyle.fill;
        canvas.drawRect(offset & _cellSize, paint);
        return;
      case TerminalCursorType.underline:
        return canvas.drawLine(
          Offset(offset.dx, offset.dy + _cellSize.height - 1),
          Offset(offset.dx + _cellSize.width, offset.dy + _cellSize.height - 1),
          paint,
        );
      case TerminalCursorType.verticalBar:
        return canvas.drawLine(
          offset,
          Offset(offset.dx, offset.dy + _cellSize.height),
          paint,
        );
    }
  }

  @pragma('vm:prefer-inline')
  void paintHighlight(Canvas canvas, Offset offset, int length, Color color) {
    final endOffset =
        offset.translate(length * _cellSize.width, _cellSize.height);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    canvas.drawRect(
      Rect.fromPoints(offset, endOffset),
      paint,
    );
  }

  /// Paints [line] to [canvas] at [offset]. The x offset of [offset] is usually
  /// 0, and the y offset is the top of the line.
  void paintLine(
    Canvas canvas,
    Offset offset,
    BufferLine line,
    bool customGlyphs,
    double verticalLineOffset, {
    required double cellBackgroundOpacity,
    required bool transparentBackgroundCells,
  }) {
    final cellData = CellData.empty();
    final cellWidth = _cellSize.width;

    for (var i = 0; i < line.length; i++) {
      line.getCellData(i, cellData);

      final charWidth = cellData.content >> CellContent.widthShift;
      final cellOffset = offset.translate(i * cellWidth, 0);

      paintCellBackground(
        canvas,
        cellOffset,
        cellData,
        cellBackgroundOpacity: cellBackgroundOpacity,
        transparentBackgroundCells: transparentBackgroundCells,
      );

      if (charWidth == 2) {
        i++;
      }
    }
    for (var i = 0; i < line.length; i++) {
      line.getCellData(i, cellData);

      final charWidth = cellData.content >> CellContent.widthShift;
      final cellOffset = offset.translate(i * cellWidth, 0);

      paintCellForeground(
        canvas,
        cellOffset,
        cellData,
        customGlyphs,
        verticalLineOffset,
      );

      if (charWidth == 2) {
        i++;
      }
    }
  }

  //
  // void paintLine(
  //   Canvas canvas,
  //   Offset offset,
  //   BufferLine line,
  // ) {
  //   final cellData = CellData.empty();
  //   final cellWidth = _cellSize.width;

  //   // TODO: refactor and optimize render
  //   for (var i = 0; i < line.length; i++) {
  //     line.getCellData(i, cellData);

  //     final charWidth = cellData.content >> CellContent.widthShift;
  //     final cellOffset = offset.translate(i * cellWidth, 0);

  //     paintCellBackground(canvas, cellOffset, cellData);

  //     if (charWidth == 2) {
  //       i++;
  //     }
  //   }

  //   final builder =
  //       ParagraphBuilder(_textStyle.toTextStyle().getParagraphStyle());

  //   // final paragraph = builder.build();
  //   // paragraph.layout(ParagraphConstraints(width: double.infinity));

  //   // _cache[key] = paragraph;
  //   // return paragraph;
  //   for (var i = 0; i < line.length; i++) {
  //     line.getCellData(i, cellData);

  //     final charWidth = cellData.content >> CellContent.widthShift;
  //     // var _offset = offset.translate(i * cellWidth, 0);

  //     // paintCellForeground(canvas, cellOffset, cellData);

  //     final charCode = cellData.content & CellContent.codepointMask;
  //     if (charCode == 0) {
  //       builder.addText(" ");
  //       continue;
  //     }

  //     // final cacheKey = cellData.getHash() ^ _textScaleFactor.hashCode;
  //     // var paragraph = _paragraphCache.getLayoutFromCache(cacheKey);

  //     // if (paragraph == null) {
  //     final cellFlags = cellData.flags;

  //     var color = cellFlags & CellFlags.inverse == 0
  //         ? resolveForegroundColor(cellData.foreground)
  //         : resolveBackgroundColor(cellData.background);

  //     if (cellData.flags & CellFlags.faint != 0) {
  //       color = color.withOpacity(0.5);
  //     }

  //     final style = _textStyle.toTextStyle(
  //       color: color,
  //       bold: cellFlags & CellFlags.bold != 0,
  //       italic: cellFlags & CellFlags.italic != 0,
  //       underline: cellFlags & CellFlags.underline != 0,
  //     );

  //     builder.pushStyle(style.getTextStyle(textScaleFactor: textScaleFactor));

  //     // Flutter does not draw an underline below a space which is not between
  //     // other regular characters. As only single characters are drawn, this
  //     // will never produce an underline below a space in the terminal. As a
  //     // workaround the regular space CodePoint 0x20 is replaced with
  //     // the CodePoint 0xA0. This is a non breaking space and a underline can be
  //     // drawn below it.
  //     var char = String.fromCharCode(charCode);
  //     if (cellFlags & CellFlags.underline != 0 && charCode == 0x20) {
  //       char = String.fromCharCode(0xA0);
  //     }

  //     builder.addText(char);

  //     if (charWidth == 2) {
  //       i++;
  //     }
  //   }

  //   var paragraph = builder.build();
  //   paragraph.layout(ParagraphConstraints(width: double.infinity));

  //   canvas.drawParagraph(paragraph, offset);
  // }

  @pragma('vm:prefer-inline')
  void paintCell(
    Canvas canvas,
    Offset offset,
    CellData cellData,
    bool customGlyphs,
    double verticalLineOffset, {
    required double cellBackgroundOpacity,
    required bool transparentBackgroundCells,
  }) {
    paintCellBackground(
      canvas,
      offset,
      cellData,
      cellBackgroundOpacity: cellBackgroundOpacity,
      transparentBackgroundCells: transparentBackgroundCells,
    );
    paintCellForeground(
      canvas,
      offset,
      cellData,
      customGlyphs,
      verticalLineOffset,
    );
  }

  /// Paints the character in the cell represented by [cellData] to [canvas] at
  /// [offset].
  @pragma('vm:prefer-inline')
  void paintCellForeground(
    Canvas canvas,
    Offset offset,
    CellData cellData,
    bool customGlyphs,
    double verticalLineOffset,
  ) {
    final charCode = cellData.content & CellContent.codepointMask;
    if (charCode == 0) return;

    final cacheKey = cellData.getHash() ^ _textScaler.hashCode;
    var paragraph = _paragraphCache.getLayoutFromCache(cacheKey);

    if (cellData.flags & CellFlags.underline != 0) {
      var color = cellData.flags & CellFlags.inverse == 0
          ? resolveForegroundColor(cellData.foreground)
          : resolveBackgroundColor(cellData.background);
      final doubleWidth = cellData.content >> CellContent.widthShift == 2;
      final widthScale = doubleWidth ? 2 : 1;
      final size = Size(_cellSize.width * widthScale, _cellSize.height);
      final yOffset = size.height - (size.height * 0.1);
      canvas.drawLine(
        offset.translate(0, yOffset),
        offset.translate(size.width, yOffset),
        Paint()..color = color,
      );
    }

    if (paragraph == null) {
      final cellFlags = cellData.flags;

      var color = cellFlags & CellFlags.inverse == 0
          ? resolveForegroundColor(cellData.foreground)
          : resolveBackgroundColor(cellData.background);

      if (cellData.flags & CellFlags.faint != 0) {
        color = color.withOpacity(0.5);
      }

      final style = _textStyle
          .toTextStyle(
            color: color,
            bold: cellFlags & CellFlags.bold != 0,
            italic: cellFlags & CellFlags.italic != 0,
            // underline: cellFlags & CellFlags.underline != 0,
          )
          .copyWith(
            height: _textStyle.height - verticalLineOffset,
          );

      // Flutter does not draw an underline below a space which is not between
      // other regular characters. As only single characters are drawn, this
      // will never produce an underline below a space in the terminal. As a
      // workaround the regular space CodePoint 0x20 is replaced with
      // the CodePoint 0xA0. This is a non breaking space and a underline can be
      // drawn below it.
      var char = String.fromCharCode(charCode);
      if (cellFlags & CellFlags.underline != 0 && charCode == 0x20) {
        char = String.fromCharCode(0xA0);
      }

      if (customGlyphs) {
        final isDrew = _customGlyphsPainter.tryDrawCustomChar(
          canvas: canvas,
          char: char,
          offset: offset,
          cellSize: _cellSize,
          devicePixelRatio: _textScaler.textScaleFactor,
          color: color,
          fontSize: style.fontSize ?? 10,
        );

        if (isDrew) {
          return;
        }
      }

      paragraph = _paragraphCache.performAndCacheLayout(
        char,
        style,
        _textScaler,
        cacheKey,
      );
    }

    canvas.drawParagraph(paragraph, offset);
  }

  /// Paints the background of a cell represented by [cellData] to [canvas] at
  /// [offset].
  @pragma('vm:prefer-inline')
  void paintCellBackground(
    Canvas canvas,
    Offset offset,
    CellData cellData, {
    required double cellBackgroundOpacity,
    required bool transparentBackgroundCells,
  }) {
    late Color color;
    final colorType = cellData.background & CellColor.typeMask;

    if (cellData.flags & CellFlags.inverse != 0) {
      color = resolveForegroundColor(cellData.foreground);
    } else if (colorType == CellColor.normal) {
      return;
    } else {
      color = resolveBackgroundColor(cellData.background);

      if (transparentBackgroundCells && color == _theme.background) {
        color = color.withOpacity(0);
      } else {
        color = color.withOpacity(cellBackgroundOpacity.clamp(0, 1));
      }
    }

    final paint = Paint()..color = color;
    final doubleWidth = cellData.content >> CellContent.widthShift == 2;
    final widthScale = doubleWidth ? 2 : 1;
    final size = Size(_cellSize.width * widthScale, _cellSize.height);
    canvas.drawRect(offset & size, paint);
  }

  /// Get the effective foreground color for a cell from information encoded in
  /// [cellColor].
  @pragma('vm:prefer-inline')
  Color resolveForegroundColor(int cellColor) {
    final colorType = cellColor & CellColor.typeMask;
    final colorValue = cellColor & CellColor.valueMask;

    switch (colorType) {
      case CellColor.normal:
        return _theme.foreground;
      case CellColor.named:
      case CellColor.palette:
        return _colorPalette[colorValue];
      case CellColor.rgb:
      default:
        return Color(colorValue | 0xFF000000);
    }
  }

  /// Get the effective background color for a cell from information encoded in
  /// [cellColor].
  @pragma('vm:prefer-inline')
  Color resolveBackgroundColor(int cellColor) {
    final colorType = cellColor & CellColor.typeMask;
    final colorValue = cellColor & CellColor.valueMask;

    switch (colorType) {
      case CellColor.normal:
        return _theme.background;
      case CellColor.named:
      case CellColor.palette:
        return _colorPalette[colorValue];
      case CellColor.rgb:
      default:
        return Color(colorValue | 0xFF000000);
    }
  }
}
