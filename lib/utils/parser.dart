import 'dart:developer';

winRate(wins, losses) {
  int matches = wins + losses;
  double winrate = ((matches - losses) / matches) * 100;
  return winrate.toStringAsFixed(2);
}
