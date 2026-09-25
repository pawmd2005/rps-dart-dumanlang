import 'dart:io';

/// This will get the player's name. If no name is entered, it uses the default name.
String getPlayerName(String defaultName) {
  stdout.write('Enter $defaultName name: ');
  String? userInput = stdin.readLineSync();
  String playerName = userInput?.trim() ?? '';

  if (playerName.isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }
  return playerName;
}

/// Checks if the player entered rock, paper, or scissors.
String? validateMove(String userMove) {
  List<String> validMoves = ['rock', 'paper', 'scissors'];
  String cleanedMove = userMove.trim().toLowerCase();

  if (validMoves.contains(cleanedMove)) {
    return cleanedMove;
  }
  return null;
}

/// This will keep asking until the player enters a valid move.
String getMove(String playerName) {
  while (true) {
    stdout.write('$playerName, enter your move (rock/paper/scissors): ');

    String? moveInput = stdin.readLineSync();
    String? validMove = validateMove(moveInput ?? '');

    if (validMove != null) {
      return validMove;
    }
    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// This will decide who wins the round. Returns null if both players choose the same move.
String? decideWinner(
  String firstMove,
  String secondMove,
  String firstPlayer,
  String secondPlayer,
) {
  if (firstMove == secondMove) {
    return null;
  }
  switch (firstMove) {
    case 'rock':
      return secondMove == 'scissors' ? firstPlayer : secondPlayer;
    case 'paper':
      return secondMove == 'rock' ? firstPlayer : secondPlayer;
    case 'scissors':
      return secondMove == 'paper' ? firstPlayer : secondPlayer;
  }
  return null;
}

/// This is where it starts and runs the Rock, Paper, Scissors game.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String firstPlayer = getPlayerName('Player 1');
  String secondPlayer = getPlayerName('Player 2');

  int firstScore = 0;
  int secondScore = 0;
  int roundNumber = 1;

  String playAgain;

  do {
    print('\n--- Round $roundNumber ---');
    String firstMove = getMove(firstPlayer);

    for (int lineNumber = 0; lineNumber < 30; lineNumber++) {
      print('');
    }

    String secondMove = getMove(secondPlayer);
    print('\n$firstPlayer chose $firstMove. $secondPlayer chose $secondMove.');
    String? roundWinner =
        decideWinner(firstMove, secondMove, firstPlayer, secondPlayer);

    if (roundWinner == firstPlayer) {
      firstScore++;
    } else if (roundWinner == secondPlayer) {
      secondScore++;
    }

    print('Result: ${roundWinner ?? "It\'s a draw!"}');

    if (roundWinner != null) {
      print('$roundWinner wins the round!');
    }

    print(
        'Score -> $firstPlayer: $firstScore | $secondPlayer: $secondScore');
    roundNumber++;

    stdout.write('Play again? (y/n): ');
    String? answerInput = stdin.readLineSync();
    playAgain = (answerInput ?? 'n').trim().toLowerCase();

    while (playAgain != 'y' && playAgain != 'n') {
      stdout.write('Please enter y or n: ');
      answerInput = stdin.readLineSync();
      playAgain = (answerInput ?? 'n').trim().toLowerCase();
    }
  } while (playAgain == 'y');

  print('\n===== FINAL SCORE =====');
  print('$firstPlayer: $firstScore | $secondPlayer: $secondScore');

  if (firstScore > secondScore) {
    print('Overall winner: $firstPlayer');
  } else if (secondScore > firstScore) {
    print('Overall winner: $secondPlayer');
  } else {
    print('Overall result: It\'s a draw!');
  }

  print('Thank you for playing!');
}
