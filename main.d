import std;

bool validatePaths(string emacsDir, string repoDir) {
  if (!std.file.isDir(emacsDir)) {
    "It looks like the path to .emacs.d is not correct.".writeln;
    return false;
  }
  if (!std.file.isDir(repoDir)) {
    "It looks like the path to your repository is not correct.".writeln;
    return false;
  }
  return true;
}

Tuple!(string, string) initializeConfigFile(string path) {
    "It looks like there is no configuration file for ExodimacsSync.".writeln;
    "What is the path to your .emacs.d directory?".writeln;
    string emacsDir = readln();
    "What is the path to your exodimacs folder in your dotfiles repository?".writeln;
    string repoDir = readln();
    auto f = "./config.txt";
    std.file.write(f, emacsDir);
    std.file.append(f, repoDir);
    
    return tuple(emacsDir, repoDir);
}

Tuple!(string, string) loadConfig(string path) {
  string[] f = path.readText.splitLines;
  string emacsDir = f[0];
  string repoDir = f[1];
  return tuple(emacsDir, repoDir);
}

void main(string[] args) {
  string configPath = "./.exodimacssyncconfig.txt";
  if (args.length > 1) {
    ("Config file path set to: " ~ args[1]).writeln;
    configPath = args[1];
  }
  
  string emacsDir;
  string repoDir;
  if (!configPath.exists) {
    auto paths = initializeConfigFile(configPath);
    emacsDir = paths[0];
    repoDir = paths[1];
  } else {
    auto paths = loadConfig(configPath);
    emacsDir = paths[0];
    repoDir = paths[1];
  }
  if(!validatePaths(emacsDir, repoDir)) {
    return;
  }

  string exodimacsDir = emacsDir ~ "exodimacs/";
  if (std.file.exists(repoDir ~ "init.el")) { std.file.remove(repoDir ~ "init.el"); }
  try {
    std.file.rmdirRecurse(repoDir ~ "exodimacs/");
    std.file.mkdir(repoDir ~ "exodimacs/");
  } catch (FileException e) {
    "exodimacs directory missing. Creating directory.".writeln;
    std.file.mkdir(repoDir ~ "exodimacs/");
  }
  
  std.file.copy(emacsDir ~ "init.el", repoDir ~ "init.el");
  
  foreach (e; std.file.dirEntries(exodimacsDir, SpanMode.shallow)) {
    string target = e.to!string.split("/").array[$-1];
    std.file.copy(e, repoDir ~ "exodimacs/" ~ target);
  }
}
