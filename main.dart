import 'dart:io';

main(List<String> arguments) {
  var path = getAppPath();
  var args = getArgs();

  if (arguments.length < 1) {
    Process.start(path, args);
  } else {
    var pathArgs = getPathArgs(arguments[0]);
    Process.start(path, [...args, ...pathArgs]);
  }
}

String getAppPath() {
  if (Platform.isWindows)
    return Platform.environment['LOCALAPPDATA'] + '\\gitkraken\\Update.exe';
  if (Platform.isMacOS)
    return '/Applications/GitKraken.app/Contents/MacOS/GitKraken';

  print('This os is not currently supported!');
  exit(1);
}

List<String> getArgs() {
  if (Platform.isWindows) return ['--processStart', 'gitkraken.exe'];

  return [];
}

List<String> getPathArgs(String _path) {
  var path = Directory(_path).absolute.path;

  if (Platform.isWindows)
    return ['--process-start-args', '--path "$path"'];

  return [''];
}
