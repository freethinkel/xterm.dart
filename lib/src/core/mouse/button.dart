enum TerminalMouseButton {
  left(id: 0),

  middle(id: 1),

  right(id: 2),

  wheelUp(id: 60 + 4, isWheel: true),

  wheelDown(id: 60 + 5, isWheel: true),

  wheelLeft(id: 60 + 6, isWheel: true),

  wheelRight(id: 60 + 7, isWheel: true),

  drag(id: 32, isWheel: false),
  ;

  /// The id that is used to report a button press or release to the terminal.
  ///
  /// Mouse wheel up / down use button IDs 4 = 0100 (binary) and 5 = 0101 (binary).
  /// The bits three and four of the button are transposed by 64 and 128
  /// respectively, when reporting the id of the button and have have to be
  /// adjusted correspondingly.
  final int id;

  /// Whether this button is a mouse wheel button.
  final bool isWheel;

  const TerminalMouseButton({required this.id, this.isWheel = false});
}
