{ writeShellApplication }: writeShellApplication {
  name = "norshfetch";

  text = builtins.readFile ./norshfetch;
}
