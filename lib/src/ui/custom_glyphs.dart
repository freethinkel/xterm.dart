// ignore_for_file: constant_identifier_names, slash_for_doc_comments

import 'dart:ui';

class Box {
  Box({
    required this.h,
    required this.w,
    required this.x,
    required this.y,
  });

  double x;
  double y;
  double h;
  double w;
}

class Shapes {
  /** │ */ static const TOP_TO_BOTTOM = 'M.5,0 L.5,1';
  /** ─ */ static const LEFT_TO_RIGHT = 'M0,.5 L1,.5';

  /** └ */ static const TOP_TO_RIGHT = 'M.5,0 L.5,.5 L1,.5';
  /** ┘ */ static const TOP_TO_LEFT = 'M.5,0 L.5,.5 L0,.5';
  /** ┐ */ static const LEFT_TO_BOTTOM = 'M0,.5 L.5,.5 L.5,1';
  /** ┌ */ static const RIGHT_TO_BOTTOM = 'M0.5,1 L.5,.5 L1,.5';

  /** ╵ */ static const MIDDLE_TO_TOP = 'M.5,.5 L.5,0';
  /** ╴ */ static const MIDDLE_TO_LEFT = 'M.5,.5 L0,.5';
  /** ╶ */ static const MIDDLE_TO_RIGHT = 'M.5,.5 L1,.5';
  /** ╷ */ static const MIDDLE_TO_BOTTOM = 'M.5,.5 L.5,1';

  /** ┴ */ static const T_TOP = 'M0,.5 L1,.5 M.5,.5 L.5,0';
  /** ┤ */ static const T_LEFT = 'M.5,0 L.5,1 M.5,.5 L0,.5';
  /** ├ */ static const T_RIGHT = 'M.5,0 L.5,1 M.5,.5 L1,.5';
  /** ┬ */ static const T_BOTTOM = 'M0,.5 L1,.5 M.5,.5 L.5,1';

  /** ┼ */ static const CROSS = 'M0,.5 L1,.5 M.5,0 L.5,1';

  /** ╌ */ static const TWO_DASHES_HORIZONTAL =
      'M.1,.5 L.4,.5 M.6,.5 L.9,.5'; // .2 empty, .3 filled
  /** ┄ */ static const THREE_DASHES_HORIZONTAL =
      'M.0667,.5 L.2667,.5 M.4,.5 L.6,.5 M.7333,.5 L.9333,.5'; // .1333 empty, .2 filled
  /** ┉ */ static const FOUR_DASHES_HORIZONTAL =
      'M.05,.5 L.2,.5 M.3,.5 L.45,.5 M.55,.5 L.7,.5 M.8,.5 L.95,.5'; // .1 empty, .15 filled
  /** ╎ */ static const TWO_DASHES_VERTICAL = 'M.5,.1 L.5,.4 M.5,.6 L.5,.9';
  /** ┆ */ static const THREE_DASHES_VERTICAL =
      'M.5,.0667 L.5,.2667 M.5,.4 L.5,.6 M.5,.7333 L.5,.9333';
  /** ┊ */ static const FOUR_DASHES_VERTICAL =
      'M.5,.05 L.5,.2 M.5,.3 L.5,.45 L.5,.55 M.5,.7 L.5,.95';
}

class Style {
  static const NORMAL = 1.0;
  static const BOLD = 3.0;
}

class CustomGlyphPainter {
  final blockElementDefinitions = {
    // Block elements (0x2580-0x2590)
    '▀': [
      Box(x: 0, y: 0, w: 8, h: 4),
    ], // UPPER HALF BLOCK
    '▁': [
      Box(x: 0, y: 7, w: 8, h: 1),
    ], // LOWER ONE EIGHTH BLOCK
    '▂': [
      Box(x: 0, y: 6, w: 8, h: 2),
    ], // LOWER ONE QUARTER BLOCK
    '▃': [
      Box(x: 0, y: 5, w: 8, h: 3),
    ], // LOWER THREE EIGHTHS BLOCK
    '▄': [
      Box(x: 0, y: 4, w: 8, h: 4),
    ], // LOWER HALF BLOCK
    '▅': [
      Box(x: 0, y: 3, w: 8, h: 5),
    ], // LOWER FIVE EIGHTHS BLOCK
    '▆': [
      Box(x: 0, y: 2, w: 8, h: 6),
    ], // LOWER THREE QUARTERS BLOCK
    '▇': [
      Box(x: 0, y: 1, w: 8, h: 7),
    ], // LOWER SEVEN EIGHTHS BLOCK
    '█': [
      Box(x: 0, y: 0, w: 8, h: 8),
    ], // FULL BLOCK
    '▉': [
      Box(x: 0, y: 0, w: 7, h: 8),
    ], // LEFT SEVEN EIGHTHS BLOCK
    '▊': [
      Box(x: 0, y: 0, w: 6, h: 8),
    ], // LEFT THREE QUARTERS BLOCK
    '▋': [
      Box(x: 0, y: 0, w: 5, h: 8),
    ], // LEFT FIVE EIGHTHS BLOCK
    '▌': [
      Box(x: 0, y: 0, w: 4, h: 8),
    ], // LEFT HALF BLOCK
    '▍': [
      Box(x: 0, y: 0, w: 3, h: 8),
    ], // LEFT THREE EIGHTHS BLOCK
    '▎': [
      Box(x: 0, y: 0, w: 2, h: 8),
    ], // LEFT ONE QUARTER BLOCK
    '▏': [
      Box(x: 0, y: 0, w: 1, h: 8),
    ], // LEFT ONE EIGHTH BLOCK
    '▐': [
      Box(x: 4, y: 0, w: 4, h: 8),
    ], // RIGHT HALF BLOCK

    // Block elements (0x2594-0x2595)
    '▔': [
      Box(x: 0, y: 0, w: 8, h: 1),
    ], // UPPER ONE EIGHTH BLOCK
    '▕': [
      Box(x: 7, y: 0, w: 1, h: 8),
    ], // RIGHT ONE EIGHTH BLOCK

    // Terminal graphic characters (0x2596-0x259F)
    '▖': [
      Box(x: 0, y: 4, w: 4, h: 4),
    ], // QUADRANT LOWER LEFT
    '▗': [
      Box(x: 4, y: 4, w: 4, h: 4),
    ], // QUADRANT LOWER RIGHT
    '▘': [
      Box(x: 0, y: 0, w: 4, h: 4),
    ], // QUADRANT UPPER LEFT
    '▙': [
      Box(x: 0, y: 0, w: 4, h: 8),
      Box(x: 0, y: 4, w: 8, h: 4),
    ], // QUADRANT UPPER LEFT AND LOWER LEFT AND LOWER RIGHT
    '▚': [
      Box(x: 0, y: 0, w: 4, h: 4),
      Box(x: 4, y: 4, w: 4, h: 4),
    ], // QUADRANT UPPER LEFT AND LOWER RIGHT
    '▛': [
      Box(x: 0, y: 0, w: 4, h: 8),
      Box(x: 4, y: 0, w: 4, h: 4),
    ], // QUADRANT UPPER LEFT AND UPPER RIGHT AND LOWER LEFT
    '▜': [
      Box(x: 0, y: 0, w: 8, h: 4),
      Box(x: 4, y: 0, w: 4, h: 8),
    ], // QUADRANT UPPER LEFT AND UPPER RIGHT AND LOWER RIGHT
    '▝': [
      Box(x: 4, y: 0, w: 4, h: 4),
    ], // QUADRANT UPPER RIGHT
    '▞': [
      Box(x: 4, y: 0, w: 4, h: 4),
      Box(x: 0, y: 4, w: 4, h: 4),
    ], // QUADRANT UPPER RIGHT AND LOWER LEFT
    '▟': [
      Box(x: 4, y: 0, w: 4, h: 8),
      Box(x: 0, y: 4, w: 8, h: 4),
    ], // QUADRANT UPPER RIGHT AND LOWER LEFT AND LOWER RIGHT

    // VERTICAL ONE EIGHTH BLOCK-2 through VERTICAL ONE EIGHTH BLOCK-7
    '\u{1FB70}': [
      Box(x: 1, y: 0, w: 1, h: 8),
    ],
    '\u{1FB71}': [
      Box(x: 2, y: 0, w: 1, h: 8),
    ],
    '\u{1FB72}': [
      Box(x: 3, y: 0, w: 1, h: 8),
    ],
    '\u{1FB73}': [
      Box(x: 4, y: 0, w: 1, h: 8),
    ],
    '\u{1FB74}': [
      Box(x: 5, y: 0, w: 1, h: 8),
    ],
    '\u{1FB75}': [
      Box(x: 6, y: 0, w: 1, h: 8),
    ],

    // HORIZONTAL ONE EIGHTH BLOCK-2 through HORIZONTAL ONE EIGHTH BLOCK-7
    '\u{1FB76}': [
      Box(x: 0, y: 1, w: 8, h: 1),
    ],
    '\u{1FB77}': [
      Box(x: 0, y: 2, w: 8, h: 1),
    ],
    '\u{1FB78}': [
      Box(x: 0, y: 3, w: 8, h: 1),
    ],
    '\u{1FB79}': [
      Box(x: 0, y: 4, w: 8, h: 1),
    ],
    '\u{1FB7A}': [
      Box(x: 0, y: 5, w: 8, h: 1),
    ],
    '\u{1FB7B}': [
      Box(x: 0, y: 6, w: 8, h: 1),
    ],

    // LEFT AND LOWER ONE EIGHTH BLOCK
    '\u{1FB7C}': [
      Box(x: 0, y: 0, w: 1, h: 8),
      Box(x: 0, y: 7, w: 8, h: 1),
    ],
    // LEFT AND UPPER ONE EIGHTH BLOCK
    '\u{1FB7D}': [
      Box(x: 0, y: 0, w: 1, h: 8),
      Box(x: 0, y: 0, w: 8, h: 1),
    ],
    // RIGHT AND UPPER ONE EIGHTH BLOCK
    '\u{1FB7E}': [
      Box(x: 7, y: 0, w: 1, h: 8),
      Box(x: 0, y: 0, w: 8, h: 1),
    ],
    // RIGHT AND LOWER ONE EIGHTH BLOCK
    '\u{1FB7F}': [
      Box(x: 7, y: 0, w: 1, h: 8),
      Box(x: 0, y: 7, w: 8, h: 1),
    ],
    // UPPER AND LOWER ONE EIGHTH BLOCK
    '\u{1FB80}': [
      Box(x: 0, y: 0, w: 8, h: 1),
      Box(x: 0, y: 7, w: 8, h: 1),
    ],
    // HORIZONTAL ONE EIGHTH BLOCK-1358
    '\u{1FB81}': [
      Box(x: 0, y: 0, w: 8, h: 1),
      Box(x: 0, y: 2, w: 8, h: 1),
      Box(x: 0, y: 4, w: 8, h: 1),
      Box(x: 0, y: 7, w: 8, h: 1),
    ],

    // UPPER ONE QUARTER BLOCK
    '\u{1FB82}': [
      Box(x: 0, y: 0, w: 8, h: 2),
    ],
    // UPPER THREE EIGHTHS BLOCK
    '\u{1FB83}': [
      Box(x: 0, y: 0, w: 8, h: 3),
    ],
    // UPPER FIVE EIGHTHS BLOCK
    '\u{1FB84}': [
      Box(x: 0, y: 0, w: 8, h: 5),
    ],
    // UPPER THREE QUARTERS BLOCK
    '\u{1FB85}': [
      Box(x: 0, y: 0, w: 8, h: 6),
    ],
    // UPPER SEVEN EIGHTHS BLOCK
    '\u{1FB86}': [
      Box(x: 0, y: 0, w: 8, h: 7),
    ],

    // RIGHT ONE QUARTER BLOCK
    '\u{1FB87}': [
      Box(x: 6, y: 0, w: 2, h: 8),
    ],
    // RIGHT THREE EIGHTHS B0OCK
    '\u{1FB88}': [
      Box(x: 5, y: 0, w: 3, h: 8),
    ],
    // RIGHT FIVE EIGHTHS BL0CK
    '\u{1FB89}': [
      Box(x: 3, y: 0, w: 5, h: 8),
    ],
    // RIGHT THREE QUARTERS 0LOCK
    '\u{1FB8A}': [
      Box(x: 2, y: 0, w: 6, h: 8),
    ],
    // RIGHT SEVEN EIGHTHS B0OCK
    '\u{1FB8B}': [
      Box(x: 1, y: 0, w: 7, h: 8),
    ],

    // CHECKER BOARD FILL
    '\u{1FB95}': [
      Box(x: 0, y: 0, w: 2, h: 2),
      Box(x: 4, y: 0, w: 2, h: 2),
      Box(x: 2, y: 2, w: 2, h: 2),
      Box(x: 6, y: 2, w: 2, h: 2),
      Box(x: 0, y: 4, w: 2, h: 2),
      Box(x: 4, y: 4, w: 2, h: 2),
      Box(x: 2, y: 6, w: 2, h: 2),
      Box(x: 6, y: 6, w: 2, h: 2),
    ],
    // INVERSE CHECKER BOARD FILL
    '\u{1FB96}': [
      Box(x: 2, y: 0, w: 2, h: 2),
      Box(x: 6, y: 0, w: 2, h: 2),
      Box(x: 0, y: 2, w: 2, h: 2),
      Box(x: 4, y: 2, w: 2, h: 2),
      Box(x: 2, y: 4, w: 2, h: 2),
      Box(x: 6, y: 4, w: 2, h: 2),
      Box(x: 0, y: 6, w: 2, h: 2),
      Box(x: 4, y: 6, w: 2, h: 2),
    ],
    // HEAVY HORIZONTAL FILL (upper middle and lower one quarter block)
    '\u{1FB97}': [
      Box(x: 0, y: 2, w: 8, h: 2),
      Box(x: 0, y: 6, w: 8, h: 2),
    ],
  };
  final Map<String, dynamic> boxDrawingDefinitions = {
    // Uniform normal and bold
    '─': {Style.NORMAL: Shapes.LEFT_TO_RIGHT},
    '━': {Style.BOLD: Shapes.LEFT_TO_RIGHT},
    '│': {Style.NORMAL: Shapes.TOP_TO_BOTTOM},
    '┃': {Style.BOLD: Shapes.TOP_TO_BOTTOM},
    '┌': {Style.NORMAL: Shapes.RIGHT_TO_BOTTOM},
    '┏': {Style.BOLD: Shapes.RIGHT_TO_BOTTOM},
    '┐': {Style.NORMAL: Shapes.LEFT_TO_BOTTOM},
    '┓': {Style.BOLD: Shapes.LEFT_TO_BOTTOM},
    '└': {Style.NORMAL: Shapes.TOP_TO_RIGHT},
    '┗': {Style.BOLD: Shapes.TOP_TO_RIGHT},
    '┘': {Style.NORMAL: Shapes.TOP_TO_LEFT},
    '┛': {Style.BOLD: Shapes.TOP_TO_LEFT},
    '├': {Style.NORMAL: Shapes.T_RIGHT},
    '┣': {Style.BOLD: Shapes.T_RIGHT},
    '┤': {Style.NORMAL: Shapes.T_LEFT},
    '┫': {Style.BOLD: Shapes.T_LEFT},
    '┬': {Style.NORMAL: Shapes.T_BOTTOM},
    '┳': {Style.BOLD: Shapes.T_BOTTOM},
    '┴': {Style.NORMAL: Shapes.T_TOP},
    '┻': {Style.BOLD: Shapes.T_TOP},
    '┼': {Style.NORMAL: Shapes.CROSS},
    '╋': {Style.BOLD: Shapes.CROSS},
    '╴': {Style.NORMAL: Shapes.MIDDLE_TO_LEFT},
    '╸': {Style.BOLD: Shapes.MIDDLE_TO_LEFT},
    '╵': {Style.NORMAL: Shapes.MIDDLE_TO_TOP},
    '╹': {Style.BOLD: Shapes.MIDDLE_TO_TOP},
    '╶': {Style.NORMAL: Shapes.MIDDLE_TO_RIGHT},
    '╺': {Style.BOLD: Shapes.MIDDLE_TO_RIGHT},
    '╷': {Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM},
    '╻': {Style.BOLD: Shapes.MIDDLE_TO_BOTTOM},

    // Double border
    '═': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 - yp} L1,${.5 - yp} M0,${.5 + yp} L1,${.5 + yp}',
    },
    '║': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 - xp},0 L${.5 - xp},1 M${.5 + xp},0 L${.5 + xp},1',
    },
    '╒': {
      Style.NORMAL: (xp, yp) =>
          'M.5,1 L.5,${.5 - yp} L1,${.5 - yp} M.5,${.5 + yp} L1,${.5 + yp}',
    },
    '╓': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 - xp},1 L${.5 - xp},.5 L1,.5 M${.5 + xp},.5 L${.5 + xp},1',
    },
    '╔': {
      Style.NORMAL: (xp, yp) =>
          'M1,${.5 - yp} L${.5 - xp},${.5 - yp} L${.5 - xp},1 M1,${.5 + yp} L${.5 + xp},${.5 + yp} L${.5 + xp},1',
    },
    '╕': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 - yp} L.5,${.5 - yp} L.5,1 M0,${.5 + yp} L.5,${.5 + yp}',
    },
    '╖': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 + xp},1 L${.5 + xp},.5 L0,.5 M${.5 - xp},.5 L${.5 - xp},1',
    },
    '╗': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 + yp} L${.5 - xp},${.5 + yp} L${.5 - xp},1 M0,${.5 - yp} L${.5 + xp},${.5 - yp} L${.5 + xp},1',
    },
    '╘': {
      Style.NORMAL: (xp, yp) =>
          'M.5,0 L.5,${.5 + yp} L1,${.5 + yp} M.5,${.5 - yp} L1,${.5 - yp}',
    },
    '╙': {
      Style.NORMAL: (xp, yp) =>
          'M1,.5 L${.5 - xp},.5 L${.5 - xp},0 M${.5 + xp},.5 L${.5 + xp},0',
    },
    '╚': {
      Style.NORMAL: (xp, yp) =>
          'M1,${.5 - yp} L${.5 + xp},${.5 - yp} L${.5 + xp},0 M1,${.5 + yp} L${.5 - xp},${.5 + yp} L${.5 - xp},0',
    },
    '╛': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 + yp} L.5,${.5 + yp} L.5,0 M0,${.5 - yp} L.5,${.5 - yp}',
    },
    '╜': {
      Style.NORMAL: (xp, yp) =>
          'M0,.5 L${.5 + xp},.5 L${.5 + xp},0 M${.5 - xp},.5 L${.5 - xp},0',
    },
    '╝': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 - yp} L${.5 - xp},${.5 - yp} L${.5 - xp},0 M0,${.5 + yp} L${.5 + xp},${.5 + yp} L${.5 + xp},0',
    },
    '╞': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.TOP_TO_BOTTOM} M.5,${.5 - yp} L1,${.5 - yp} M.5,${.5 + yp} L1,${.5 + yp}',
    },
    '╟': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 - xp},0 L${.5 - xp},1 M${.5 + xp},0 L${.5 + xp},1 M${.5 + xp},.5 L1,.5',
    },
    '╠': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 - xp},0 L${.5 - xp},1 M1,${.5 + yp} L${.5 + xp},${.5 + yp} L${.5 + xp},1 M1,${.5 - yp} L${.5 + xp},${.5 - yp} L${.5 + xp},0',
    },
    '╡': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.TOP_TO_BOTTOM} M0,${.5 - yp} L.5,${.5 - yp} M0,${.5 + yp} L.5,${.5 + yp}',
    },
    '╢': {
      Style.NORMAL: (xp, yp) =>
          'M0,.5 L${.5 - xp},.5 M${.5 - xp},0 L${.5 - xp},1 M${.5 + xp},0 L${.5 + xp},1',
    },
    '╣': {
      Style.NORMAL: (xp, yp) =>
          'M${.5 + xp},0 L${.5 + xp},1 M0,${.5 + yp} L${.5 - xp},${.5 + yp} L${.5 - xp},1 M0,${.5 - yp} L${.5 - xp},${.5 - yp} L${.5 - xp},0',
    },
    '╤': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 - yp} L1,${.5 - yp} M0,${.5 + yp} L1,${.5 + yp} M.5,${.5 + yp} L.5,1',
    },
    '╥': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.LEFT_TO_RIGHT} M${.5 - xp},.5 L${.5 - xp},1 M${.5 + xp},.5 L${.5 + xp},1',
    },
    '╦': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 - yp} L1,${.5 - yp} M0,${.5 + yp} L${.5 - xp},${.5 + yp} L${.5 - xp},1 M1,${.5 + yp} L${.5 + xp},${.5 + yp} L${.5 + xp},1',
    },
    '╧': {
      Style.NORMAL: (xp, yp) =>
          'M.5,0 L.5,${.5 - yp} M0,${.5 - yp} L1,${.5 - yp} M0,${.5 + yp} L1,${.5 + yp}',
    },
    '╨': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.LEFT_TO_RIGHT} M${.5 - xp},.5 L${.5 - xp},0 M${.5 + xp},.5 L${.5 + xp},0',
    },
    '╩': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 + yp} L1,${.5 + yp} M0,${.5 - yp} L${.5 - xp},${.5 - yp} L${.5 - xp},0 M1,${.5 - yp} L${.5 + xp},${.5 - yp} L${.5 + xp},0',
    },
    '╪': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.TOP_TO_BOTTOM} M0,${.5 - yp} L1,${.5 - yp} M0,${.5 + yp} L1,${.5 + yp}',
    },
    '╫': {
      Style.NORMAL: (xp, yp) =>
          '${Shapes.LEFT_TO_RIGHT} M${.5 - xp},0 L${.5 - xp},1 M${.5 + xp},0 L${.5 + xp},1',
    },
    '╬': {
      Style.NORMAL: (xp, yp) =>
          'M0,${.5 + yp} L${.5 - xp},${.5 + yp} L${.5 - xp},1 M1,${.5 + yp} L${.5 + xp},${.5 + yp} L${.5 + xp},1 M0,${.5 - yp} L${.5 - xp},${.5 - yp} L${.5 - xp},0 M1,${.5 - yp} L${.5 + xp},${.5 - yp} L${.5 + xp},0',
    },

    // Diagonal
    '╱': {Style.NORMAL: 'M1,0 L0,1'},
    '╲': {Style.NORMAL: 'M0,0 L1,1'},
    '╳': {Style.NORMAL: 'M1,0 L0,1 M0,0 L1,1'},

    // Mixed weight
    '╼': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '╽': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '╾': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '╿': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '┍': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '┎': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '┑': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '┒': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '┕': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '┖': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '┙': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '┚': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '┝': {
      Style.NORMAL: Shapes.TOP_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '┞': {
      Style.NORMAL: Shapes.RIGHT_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '┟': {
      Style.NORMAL: Shapes.TOP_TO_RIGHT,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '┠': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: Shapes.TOP_TO_BOTTOM,
    },
    '┡': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.TOP_TO_RIGHT,
    },
    '┢': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: Shapes.RIGHT_TO_BOTTOM,
    },
    '┥': {
      Style.NORMAL: Shapes.TOP_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '┦': {
      Style.NORMAL: Shapes.LEFT_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '┧': {
      Style.NORMAL: Shapes.TOP_TO_LEFT,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '┨': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: Shapes.TOP_TO_BOTTOM,
    },
    '┩': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.TOP_TO_LEFT,
    },
    '┪': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: Shapes.LEFT_TO_BOTTOM,
    },
    '┭': {
      Style.NORMAL: Shapes.RIGHT_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '┮': {
      Style.NORMAL: Shapes.LEFT_TO_BOTTOM,
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '┯': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: Shapes.LEFT_TO_RIGHT,
    },
    '┰': {
      Style.NORMAL: Shapes.LEFT_TO_RIGHT,
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '┱': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: Shapes.LEFT_TO_BOTTOM,
    },
    '┲': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: Shapes.RIGHT_TO_BOTTOM,
    },
    '┵': {Style.NORMAL: Shapes.TOP_TO_RIGHT, Style.BOLD: Shapes.MIDDLE_TO_LEFT},
    '┶': {Style.NORMAL: Shapes.TOP_TO_LEFT, Style.BOLD: Shapes.MIDDLE_TO_RIGHT},
    '┷': {Style.NORMAL: Shapes.MIDDLE_TO_TOP, Style.BOLD: Shapes.LEFT_TO_RIGHT},
    '┸': {Style.NORMAL: Shapes.LEFT_TO_RIGHT, Style.BOLD: Shapes.MIDDLE_TO_TOP},
    '┹': {Style.NORMAL: Shapes.MIDDLE_TO_RIGHT, Style.BOLD: Shapes.TOP_TO_LEFT},
    '┺': {Style.NORMAL: Shapes.MIDDLE_TO_LEFT, Style.BOLD: Shapes.TOP_TO_RIGHT},
    '┽': {
      Style.NORMAL: '${Shapes.TOP_TO_BOTTOM} ${Shapes.MIDDLE_TO_RIGHT}',
      Style.BOLD: Shapes.MIDDLE_TO_LEFT,
    },
    '┾': {
      Style.NORMAL: '${Shapes.TOP_TO_BOTTOM} ${Shapes.MIDDLE_TO_LEFT}',
      Style.BOLD: Shapes.MIDDLE_TO_RIGHT,
    },
    '┿': {Style.NORMAL: Shapes.TOP_TO_BOTTOM, Style.BOLD: Shapes.LEFT_TO_RIGHT},
    '╀': {
      Style.NORMAL: '${Shapes.LEFT_TO_RIGHT} ${Shapes.MIDDLE_TO_BOTTOM}',
      Style.BOLD: Shapes.MIDDLE_TO_TOP,
    },
    '╁': {
      Style.NORMAL: '${Shapes.MIDDLE_TO_TOP} ${Shapes.LEFT_TO_RIGHT}',
      Style.BOLD: Shapes.MIDDLE_TO_BOTTOM,
    },
    '╂': {Style.NORMAL: Shapes.LEFT_TO_RIGHT, Style.BOLD: Shapes.TOP_TO_BOTTOM},
    '╃': {Style.NORMAL: Shapes.RIGHT_TO_BOTTOM, Style.BOLD: Shapes.TOP_TO_LEFT},
    '╄': {Style.NORMAL: Shapes.LEFT_TO_BOTTOM, Style.BOLD: Shapes.TOP_TO_RIGHT},
    '╅': {Style.NORMAL: Shapes.TOP_TO_RIGHT, Style.BOLD: Shapes.LEFT_TO_BOTTOM},
    '╆': {Style.NORMAL: Shapes.TOP_TO_LEFT, Style.BOLD: Shapes.RIGHT_TO_BOTTOM},
    '╇': {
      Style.NORMAL: Shapes.MIDDLE_TO_BOTTOM,
      Style.BOLD: '${Shapes.MIDDLE_TO_TOP} ${Shapes.LEFT_TO_RIGHT}',
    },
    '╈': {
      Style.NORMAL: Shapes.MIDDLE_TO_TOP,
      Style.BOLD: '${Shapes.LEFT_TO_RIGHT} ${Shapes.MIDDLE_TO_BOTTOM}',
    },
    '╉': {
      Style.NORMAL: Shapes.MIDDLE_TO_RIGHT,
      Style.BOLD: '${Shapes.TOP_TO_BOTTOM} ${Shapes.MIDDLE_TO_LEFT}',
    },
    '╊': {
      Style.NORMAL: Shapes.MIDDLE_TO_LEFT,
      Style.BOLD: '${Shapes.TOP_TO_BOTTOM} ${Shapes.MIDDLE_TO_RIGHT}',
    },

    // Dashed
    '╌': {Style.NORMAL: Shapes.TWO_DASHES_HORIZONTAL},
    '╍': {Style.BOLD: Shapes.TWO_DASHES_HORIZONTAL},
    '┄': {Style.NORMAL: Shapes.THREE_DASHES_HORIZONTAL},
    '┅': {Style.BOLD: Shapes.THREE_DASHES_HORIZONTAL},
    '┈': {Style.NORMAL: Shapes.FOUR_DASHES_HORIZONTAL},
    '┉': {Style.BOLD: Shapes.FOUR_DASHES_HORIZONTAL},
    '╎': {Style.NORMAL: Shapes.TWO_DASHES_VERTICAL},
    '╏': {Style.BOLD: Shapes.TWO_DASHES_VERTICAL},
    '┆': {Style.NORMAL: Shapes.THREE_DASHES_VERTICAL},
    '┇': {Style.BOLD: Shapes.THREE_DASHES_VERTICAL},
    '┊': {Style.NORMAL: Shapes.FOUR_DASHES_VERTICAL},
    '┋': {Style.BOLD: Shapes.FOUR_DASHES_VERTICAL},

    // Curved
    '╭': {
      Style.NORMAL: (double xp, double yp) =>
          'M.5,1 L.5,${.5 + (yp / .15 * .5)} C.5,${.5 + (yp / .15 * .5)},.5,.5,1,.5',
    },
    '╮': {
      Style.NORMAL: (double xp, double yp) =>
          'M.5,1 L.5,${.5 + (yp / .15 * .5)} C.5,${.5 + (yp / .15 * .5)},.5,.5,0,.5',
    },
    '╯': {
      Style.NORMAL: (double xp, double yp) =>
          'M.5,0 L.5,${.5 - (yp / .15 * .5)} C.5,${.5 - (yp / .15 * .5)},.5,.5,0,.5',
    },
    '╰': {
      Style.NORMAL: (double xp, double yp) =>
          'M.5,0 L.5,${.5 - (yp / .15 * .5)} C.5,${.5 - (yp / .15 * .5)},.5,.5,1,.5',
    },
  };

  Map<String, void Function(Path, List<double>)> svgToCanvasInstructionMap = {
    'C': (Path ctx, List<double> args) => ctx.cubicTo(
          args[0],
          args[1],
          args[2],
          args[3],
          args[4],
          args[5],
        ),
    'L': (Path ctx, List<double> args) => ctx.lineTo(args[0], args[1]),
    'M': (Path ctx, List<double> args) => ctx.moveTo(args[0], args[1]),
  };

  List<double> translateArgs(
    List<String> args,
    double cellWidth,
    double cellHeight,
    double xOffset,
    double yOffset,
    bool doClamp,
    double devicePixelRatio,
    double leftPadding,
    double rightPadding,
  ) {
    final result = args.map((e) => double.parse(e)).toList();

    if (result.length < 2) {
      throw Exception('Too few arguments for instruction');
    }

    for (var x = 0; x < result.length; x += 2) {
      // Translate from 0-1 to 0-cellWidth
      result[x] *= cellWidth -
          (leftPadding * devicePixelRatio) -
          (rightPadding * devicePixelRatio);
      // Ensure coordinate doesn't escape cell bounds and round to the nearest 0.5 to ensure a crisp
      // line at 100% devicePixelRatio
      if (doClamp && result[x] != 0) {
        result[x] = ((result[x] + 0.5).round() - 0.5).clamp(0, cellWidth);
        // result[x] = math.clamp(math.round(result[x] + 0.5) - 0.5, cellWidth, 0);
      }
      // Apply the cell's offset (ie. x*cellWidth)
      result[x] += xOffset + (leftPadding * devicePixelRatio);
    }

    for (var y = 1; y < result.length; y += 2) {
      // Translate from 0-1 to 0-cellHeight
      result[y] *= cellHeight;
      // Ensure coordinate doesn't escape cell bounds and round to the nearest 0.5 to ensure a crisp
      // line at 100% devicePixelRatio
      if (doClamp && result[y] != 0) {
        try {
          result[y] = ((result[y] + 0.5).round() - 0.5).clamp(0, cellHeight);
        } catch (err) {
          print("$err ::: ${result[y]} $cellHeight");
        }
        // result[y] = clamp(Math.round(result[y] + 0.5) - 0.5, cellHeight, 0);
      }
      // Apply the cell's offset (ie. x*cellHeight)
      result[y] += yOffset;
    }

    return result;
  }

  bool _drawBlockElementChar({
    required Canvas canvas,
    required String char,
    required Offset offset,
    required Size cellSize,
    required Color color,
  }) {
    var charDefinition = blockElementDefinitions[char];
    if (charDefinition == null) {
      return false;
    }

    final path = Path();
    final paint = Paint();
    paint.color = color;

    for (var i = 0; i < charDefinition.length; i++) {
      var box = charDefinition[i];
      var xEighth = cellSize.width / 8;
      var yEighth = cellSize.height / 8;

      path.addRect(
        Rect.fromLTWH(
          offset.dx + box.x * xEighth,
          offset.dy + box.y * yEighth,
          box.w * xEighth,
          box.h * yEighth,
        ),
      );
    }
    canvas.drawPath(path, paint);
    return true;
  }

  void _drawBoxDrawingChar({
    required Canvas canvas,
    required dynamic charDefinition,
    required Offset offset,
    required Size cellSize,
    required double devicePixelRatio,
    required Color color,
  }) {
    for (final entry in charDefinition.entries) {
      final paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.color = color;

      final path = Path();
      final fontWeight = entry.key;
      final instructions = entry.value;
      paint.strokeWidth = fontWeight;

      String actualInstructions;
      if (instructions is Function) {
        final xp = .15;
        final yp = .15 / cellSize.height * cellSize.width;
        actualInstructions = instructions(xp, yp);
      } else {
        actualInstructions = instructions;
      }

      for (final instruction in actualInstructions.split(' ')) {
        final type = instruction[0];
        final f = svgToCanvasInstructionMap[type];
        if (f == null) {
          print('Could not find drawing instructions for "$type"');
          continue;
        }
        final args = instruction.substring(1).split(',');
        if (args.isEmpty || args[0].isEmpty || args[1].isEmpty) {
          continue;
        }

        f!(
          path,
          translateArgs(
            args,
            cellSize.width,
            cellSize.height,
            offset.dx,
            offset.dy,
            true,
            devicePixelRatio,
            0,
            0,
          ),
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  bool tryDrawCustomChar({
    required Canvas canvas,
    required String char,
    required Offset offset,
    required Size cellSize,
    required double devicePixelRatio,
    required Color color,
  }) {
    final blockElementDefinition = blockElementDefinitions[char];
    if (blockElementDefinition != null) {
      _drawBlockElementChar(
        canvas: canvas,
        char: char,
        offset: offset,
        cellSize: cellSize,
        color: color,
      );
      return true;
    }

    final boxDrawingDefinition = boxDrawingDefinitions[char];
    if (boxDrawingDefinition != null) {
      _drawBoxDrawingChar(
        canvas: canvas,
        charDefinition: boxDrawingDefinition,
        offset: offset,
        cellSize: cellSize,
        devicePixelRatio: devicePixelRatio,
        color: color,
      );
      return true;
    }
    return false;
  }
}
