import 'dart:io';

import 'functions.dart';
import 'vars.dart';
import 'dependencies.dart';
import 'usage.dart';

void main(List<String> arguments) async {
  exitCode = 0;
  final mode = arguments.isNotEmpty ? arguments[0] : 'create';
  if ("dependencies".startsWith(mode)) {
    await dependencies(arguments.sublist(1));
  } else if ("help".startsWith(mode)) {
    usage(null);
  } else if ("create".startsWith(mode)) {
    stdout.write("\nchecking for debian 📦 in root project...");
    try {
      final flutterToDebian = await Vars.parseDebianYaml();

      stdout.writeln("  ✅\n");
      stdout.writeln("start building debian package... ♻️  ♻️  ♻️\n");
      try {
        final String execPath = await flutterToDebian.build(arguments);

        stdout.writeln("🔥🔥🔥 (debian 📦) build done successfully  ✅\n");
        stdout.writeln("😎 find your .deb at\n$execPath");
      } catch (e) {
        exitCode = 2;
        rethrow;
      }
    } catch (e) {
      exitCode = 2;
      rethrow;
    }
  } else {
    usage('unknown mode: $mode');
  }
}
