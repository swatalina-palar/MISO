import 'dart:io';

void main() {
  final file = File('lib/features/explore/data/mock_explore_repository.dart');
  var lines = file.readAsLinesSync();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('description: ') && lines[i].contains(r'$name')) {
      // look at the line above for the name
      var prevLine = lines[i - 1];
      if (prevLine.contains('name: "')) {
        var start = prevLine.indexOf('name: "') + 7;
        var end = prevLine.indexOf('"', start);
        var dishName = prevLine.substring(start, end);
        lines[i] = lines[i].replaceAll(r'$name', dishName);
      }
    }
  }

  file.writeAsStringSync(lines.join('\n'));
}
