"""Handle command line options.
"""

import argparse

def get_args_parser():
    """Return option parser for command line options and arguments.

    Returns:
        ArgParser
    """

    usage = """
eval $(bbs_build_env.py [options] [command]

set  : set environment variables (default)
unset: unset environment variables

list : list available toolchains in the following order:
    1. Toolchains found in the user configuration file ($HOME/.bdecompilerconfig)
    2. Toolchains found in the system configuration file ($BDE_ROOT/etc/bdecompilerconfig)
    3. gcc and clang compilers detected on $PATH
"""

    parser = argparse.ArgumentParser(usage=usage)

    arguments = [
        (
            ("p", "profile"),
            {
                "type": str,
                "default": "0",
                "help": "toolchain"
            }
        ),
        (
            ("i", "install-dir"),
            {
                "type": str,
                "default": None,
                "help": "install directory"
            }
        ),
        (
            ("b", "build-dir"),
            {
                "type": str,
                "default": None,
                "help": "build directory"
            }
        ),
        (
            ("u", "ufid"),
            {
                "type": str,
                "default": "dbg",
                "help": "the Unified Platform ID (UFID) identifying the build "
                "configuration (default: %(default)s). "
            }
        ),
    ]

    for arg in arguments:
        arg_strings = ["-" + a if len(a) == 1 else "--" + a for a in arg[0]]
        parser.add_argument(*arg_strings, **arg[1])

    parser.add_argument("command",
                        nargs = "?",
                        choices = ["set", "unset", "list"],
                        default = "set")
    return parser
