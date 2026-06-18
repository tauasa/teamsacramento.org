package org.teamsacramento.web;
;

/**
 * Morse Code Converter - Command Line Application
 *
 * Usage:
 *   java -jar morse.jar encode [--play] <text>
 *   java -jar morse.jar decode [--play] <morse>
 *   java -jar morse.jar gui
 *   java -jar morse.jar --help
 *
 * Morse input uses '.' for dot, '-' for dash, ' ' between letters, '/' between words.
 */
public class Main {

    private static final String HELP =
        """
        ╔══════════════════════════════════════════════════╗
        ║           Team Sacramento Website v2.0           ║
        ╚══════════════════════════════════════════════════╝

        USAGE:
          java -jar teamsacramento.jar <command> [options] <input>

        COMMANDS:
          todo1    Command 1
          todo2    Command 2

        OPTIONS:
          --help    Show this help message

        EXAMPLES:
          java -jar teamsacramento.jar todo1
          java -jar teamsacramento.jar todo2
          """;

    public static void main(String[] args) {
        System.err.println(HELP);
    }

}
