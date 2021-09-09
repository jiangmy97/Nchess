Rules of Nchess
============================================

Rule 0: Nchess is a self-made chess game that integrates chess, Chinese chess and Japanese shogi, invented by Cannon Jiang.

０｜１２３４５６７８９
：｜：：：：：：：：：
１｜ｃｎｍ＋ｇ＋ｍｎｃ
２｜－ａ－－－－－ａ－
３｜ｓ－ｓ－ｓ－ｓ－ｓ
４｜－－－－－－－－－
５｜～～～～～～～～～
６｜－－－－－－－－－
７｜Ｓ－Ｓ－Ｓ－Ｓ－Ｓ
８｜－Ａ－－－－－Ａ－
９｜ＣＮＭ＋Ｇ＋ＭＮＣ

Rule 1: The game board has nine rows and nine columns. The initial arrangement of the pieces is shown above. There are a total of six types plus one type of promotion, and a total of fourteen chess pieces on the board. All chess pieces move in the same way as the way of capturing.

Rule 2: Starting from the upper left corner of the board, there are row and column coordinates [i j] to assist in recording the game and moving the pieces. To move the piece "P" from [i1 j1] to [i2 j2], you need to enter (record) as [P i1 j1 i2 j2].

Rule 3: Two players play in turns. Rows 1 to 3 are called "North", and the player is called "The North". Rows 6 to 9 are called "South", and the player is called "The South".

Rule 4: The fifth row is the River Boundary (abbreviated as "RB", represented by "~"). A certain piece crosses the river boundary in two steps, namely, from one side to the river boundary in the first step, and from the river boundary to the other side in the next step. When the chess pieces move horizontally on the river boundary, they move one square at a time.

Rule 5: There are 4 Prison Squares on the board (Prison Square, abbreviated as "PS", represented by "+"). [1 4] is the north 4th PS, [1 6] is the north 6th PS, [9 4] is the south 4th PS, and [9 6] is the south 6th PS. When one piece "P" has been captured, the player can choose to imprison the piece in 4 or 6 cells. This step is recorded as [P i1 j1 i2 j2 PS].

Rule 6: When a chess piece of one side's piece walks to the opponent's PS, all the pieces prisoned in this PS will be released and placed back on their own side of the chessboard.

Rule 7: General (G, g) can walk one square in an orthogonal direction in one step. This chess piece can only move in the last three rows on its own side.

Rule 8: Archer (A, a) can go orthogonally or diagonally up to three squares in one step. When crossing river boundaries, Rule 4 applies.

Rule 9: Chariot (C, c) can go orthogonally for any distance in one step. When crossing river boundaries, Rule 4 applies.

Rule 10: Knight (N, n) can go in an "L" shape in one step (i.e. two squares in the vertical direction and one in the horizontal direction; or two squares in the horizontal direction and one square in the vertical direction). This chess piece can directly cross the river boundary.

Rule 11: Minister (M, m) can go diagonally for any distance in one step. When crossing river boundaries, Rule 4 applies.

Rule 12: Soldier (S,s) can move one square forward or horizontally in one step.

Rule 13: When Soldier (S,s) moves to the last line, he can be promoted to Officer (O, o). Officer can go one square in the orthogonal direction, like General.

Rule 14: If either side captures the opponent's General, and the game is over.
