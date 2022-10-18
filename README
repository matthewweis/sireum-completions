# Sireum Completions
## Generated Shell Completions for Sireum
![](docs/demo.gif)
### Input
```scala
// #Sireum

import org.sireum._
import org.sireum.cli.CliOpt._
import org.sireum.hamr.codegen
import org.sireum.hamr.phantom
import org.sireum.lang
import org.sireum.transpilers
import org.sireum.proyek
import org.sireum.tools

val hamr = Group(
  name = "hamr",
  description = "HAMR tools",
  header =
    st"""HAMR: High Assurance Model-based Rapid-engineering tools for embedded systems""".render,
  unlisted = F,
  subs = ISZ(codegen.hamrCodeGenCli.codeGenTool, phantom.cli.phantomTool)
)

val x = Group(
  name = "x",
  description = "Experimental",
  header = "Sireum eXperimental",
  unlisted = T,
  subs = ISZ()
)

val text2speechTool: Tool = Tool(
  name = "text2speech",
  command = "text2speech",
  description = "Text-to-speech tool",
  header = "Sireum Presentasi Text-to-Speech Tool",
  usage = "<option>* <file.txt>",
  usageDescOpt = None(),
  opts = ISZ(
    Opt(name = "force", longKey = "force", shortKey = None(),
      tpe = Type.Flag(F),
      description = "Overwrite output file(s)"),
    Opt(name = "lang", longKey = "lang", shortKey = Some('l'),
      tpe = Type.Str(sep = None(), default = Some("en-US")), description = "Speech language (for AWS or Azure)"),
    Opt(name = "output", longKey = "output", shortKey = Some('o'),
      tpe = Type.Path(F, None()),
      description = "Output filename (defaults to <line>.<ext>)"),
    Opt(name = "outputFormat", longKey = "output-format", shortKey = Some('f'),
      tpe = Type.Choice(name = "OutputFormat", sep = None(), elements = ISZ(
        "mp3", "webm", "ogg", "wav")),
      description = "Audio output format (for AWS or Azure)"),
    Opt(name = "service", longKey = "service", shortKey = Some('s'),
      tpe = Type.Choice(name = "service", sep = None(), elements = ISZ("mary", "aws", "azure")),
      description = "Text-to-speech service"),
    Opt(name = "voice", longKey = "voice", shortKey = Some('v'),
      tpe = Type.Str(sep = None(), default = None()),
      description = "Voice (defaults to \"dfki-spike-hsmm\" for MaryTTS, \"Amy\" for AWS, \"en-GB-RyanNeural\" for Azure)"),
  ),
  groups = ISZ(
    OptGroup(
      name = "AWS", opts = ISZ(
        Opt(name = "awsPath", longKey = "aws-path", shortKey = Some('a'),
          tpe = Type.Path(F, Some("aws")),
          description = "Path to AWS command-line interface (CLI)"),
        Opt(name = "engine", longKey = "engine", shortKey = Some('e'),
          tpe = Type.Choice(name = "engine", sep = None(), elements = ISZ("neural", "standard")),
          description = "Voice engine"),
      ),
    ),
    OptGroup(
      name = "Azure", opts = ISZ(
        Opt(name = "gender", longKey = "gender", shortKey = Some('g'),
          tpe = Type.Str(sep = None(), default = Some("Male")), description = "Voice gender"),
        Opt(name = "key", longKey = "key", shortKey = Some('k'),
          tpe = Type.Str(sep = None(), default = None()), description = "Azure subscription key"),
        Opt(name = "region", longKey = "region", shortKey = Some('r'),
          tpe = Type.Str(sep = None(), default = Some("centralus")), description = "Azure region"),
        Opt(name = "voiceLang", longKey = "voice-lang", shortKey = Some('d'),
          tpe = Type.Str(sep = None(), default = Some("en-GB")), description = "Voice language"),
      )
    )
  )
)


val pgenTool: Tool = Tool(
  name = "gen",
  command = "gen",
  description = "Presentation generator",
  header = "Sireum Presentasi Generator",
  usage = "<option>* <path> <arg>*",
  usageDescOpt = None(),
  opts = (text2speechTool.opts - text2speechTool.opts(2))(2 ~>
    Opt(name = "outputFormat", longKey = "output-format", shortKey = Some('f'),
      tpe = Type.Choice(name = "OutputFormat", sep = None(), elements = ISZ(
        "mp3", "wav")),
      description = "Audio output format (for AWS or Azure)")),
  groups = text2speechTool.groups
)


val presentasiGroup = Group(
  name = "presentasi",
  description = "Presentation tools",
  header =
    st"""Sireum Presentasi""".render,
  unlisted = F,
  subs = ISZ(pgenTool, text2speechTool)
)

val main = Group(
  name = "sireum",
  description = "",
  header =
    st"""Sireum: A High Assurance System Engineering Platform
        |(c) SAnToS Laboratory, Kansas State University
        |Build $${SireumApi.version}""".render,
  unlisted = F,
  subs = ISZ(
    anvil.cli.group,
    hamr,
    logika.cli.group,
    parser.cli.group,
    proyek.cli.group,
    lang.cli.group(subs = lang.cli.group.subs :+ transpilers.cli.group),
    presentasiGroup,
    server.cli.serverTool,
    tools.cli.group,
    x
  )
)
```

### Output
```shell
#!/usr/bin/env sh

sireum_completions() {
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD - 1]}
    case "${COMP_WORDS[1]}" in
      'anvil')
      case "${COMP_WORDS[2]}" in
          'compile')
          case "$prev" in
              '--stage') COMPREPLY=($(compgen -W 'all hls hw sw os' -- "$cur")); return ;;
              '--transpiler-args-file') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--sandbox-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--stage --transpiler-args-file --sandbox-path' -- "$cur")); return ;;
            esac ;;
          'sandbox')
          case "$prev" in
              '-s' | '--exclude-sireum') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-x' | '--xilinx-unified-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--petalinux-installer-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-s --exclude-sireum -x --xilinx-unified-path -p --petalinux-installer-path' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'compile sandbox' -- "$cur")); return ;;
        esac ;;
      'hamr')
      case "${COMP_WORDS[2]}" in
          'codegen')
          case "$prev" in
              '--msgpack') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--platform') COMPREPLY=($(compgen -W 'JVM Linux Cygwin MacOS seL4 seL4_Only seL4_TB' -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--package-name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-proyek-ive') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-embed-art') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--devices-as-thread') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sbt-mill') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--aux-code-dirs') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--output-c-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-e' | '--exclude-component-impl') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-b' | '--bit-width') COMPREPLY=($(compgen -W '64 32 16 8' -- "$cur")); return ;;
              '-s' | '--max-string-size') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-a' | '--max-array-size') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-t' | '--run-transpiler') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--camkes-output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--camkes-aux-code-dirs') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-r' | '--aadl-root-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-x' | '--experimental-options') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--msgpack -v --verbose -p --platform -o --output-dir -n --package-name --no-proyek-ive --no-embed-art --devices-as-thread --sbt-mill --aux-code-dirs --output-c-dir -e --exclude-component-impl -b --bit-width -s --max-string-size -a --max-array-size -t --run-transpiler --camkes-output-dir --camkes-aux-code-dirs -r --aadl-root-dir -x --experimental-options' -- "$cur")); return ;;
            esac ;;
          'phantom')
          case "$prev" in
              '-s' | '--sys-impl') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-a' | '--main-package') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-m' | '--mode') COMPREPLY=($(compgen -W 'json json_compact msgpack' -- "$cur")); return ;;
              '-f' | '--output-file') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--projects') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-v' | '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--verbose+') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--osate') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-u' | '--update') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--features') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--version') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-s --sys-impl -a --main-package -m --mode -f --output-file -p --projects -v --verbose --verbose+ -o --osate -u --update --features -v --version' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'codegen phantom' -- "$cur")); return ;;
        esac ;;
      'logika')
      case "${COMP_WORDS[2]}" in
          'verifier')
          case "$prev" in
              '-r' | '--no-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-s' | '--sourcepath') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--c-bitwidth') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--fp-rounding') COMPREPLY=($(compgen -W 'NearestTiesToEven NearestTiesToAway TowardPositive TowardNegative TowardZero' -- "$cur")); return ;;
              '--use-real') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--z-bitwidth') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--line') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sat') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-methods') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-types') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--unroll') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-pc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-pc-lines') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-raw-pc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-vc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-vc-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--par-branch-mode') COMPREPLY=($(compgen -W 'all returns disabled' -- "$cur")); return ;;
              '--par-branch') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--dont-split-pfq') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-all') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-contract') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-if') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-match') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--rlimit') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--smt2-seq') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--simplify') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--solver-sat') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--solver-valid') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-t' | '--timeout') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-r --no-runtime -s --sourcepath --c-bitwidth --fp-rounding --use-real --z-bitwidth --line --sat --skip-methods --skip-types --unroll --log-pc --log-pc-lines --log-raw-pc --log-vc --log-vc-dir -p --par --par-branch-mode --par-branch --dont-split-pfq --split-all --split-contract --split-if --split-match --rlimit --smt2-seq --simplify --solver-sat --solver-valid -t --timeout' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'verifier' -- "$cur")); return ;;
        esac ;;
      'parser')
      case "${COMP_WORDS[2]}" in
          'gen')
          case "$prev" in
              '-z' | '--memoize') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-m' | '--mode') COMPREPLY=($(compgen -W 'slang antlr3' -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-backtracking') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--non-predictive') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-z --memoize -m --mode -n --name --no-backtracking --non-predictive -l --license -o --output-dir -p --package' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'gen' -- "$cur")); return ;;
        esac ;;
      'proyek')
      case "${COMP_WORDS[2]}" in
          'assemble')
          case "$prev" in
              '-j' | '--jar') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-m' | '--main') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--native') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--uber') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--fresh') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--recompile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sha3') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-compile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-j --jar -m --main --native --uber --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions --javac -f --fresh -p --par --recompile --scalac --sha3 --skip-compile -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'compile')
          case "$prev" in
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--fresh') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--recompile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sha3') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--js') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--javac -f --fresh -p --par --recompile --scalac --sha3 --js --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'ive')
          case "$prev" in
              '--empty') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-e' | '--edition') COMPREPLY=($(compgen -W 'community ultimate server' -- "$cur")); return ;;
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--empty -f --force -e --edition --javac --scalac --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'logika')
          case "$prev" in
              '--all') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--strict-aliasing') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--c-bitwidth') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--fp-rounding') COMPREPLY=($(compgen -W 'NearestTiesToEven NearestTiesToAway TowardPositive TowardNegative TowardZero' -- "$cur")); return ;;
              '--use-real') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--z-bitwidth') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--line') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sat') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-methods') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-types') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--unroll') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-pc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-pc-lines') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-raw-pc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-vc') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--log-vc-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--par-branch-mode') COMPREPLY=($(compgen -W 'all returns disabled' -- "$cur")); return ;;
              '--par-branch') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--dont-split-pfq') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-all') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-contract') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-if') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--split-match') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--rlimit') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--smt2-seq') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--simplify') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--solver-sat') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--solver-valid') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-t' | '--timeout') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--all --strict-aliasing --verbose --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions -c --cache --no-docs --no-sources -r --repositories --c-bitwidth --fp-rounding --use-real --z-bitwidth --line --sat --skip-methods --skip-types --unroll --log-pc --log-pc-lines --log-raw-pc --log-vc --log-vc-dir -p --par --par-branch-mode --par-branch --dont-split-pfq --split-all --split-contract --split-if --split-match --rlimit --smt2-seq --simplify --solver-sat --solver-valid -t --timeout' -- "$cur")); return ;;
            esac ;;
          'publish')
          case "$prev" in
              '--m2') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--target') COMPREPLY=($(compgen -W 'all jvm js' -- "$cur")); return ;;
              '--version') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--fresh') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--recompile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sha3') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-compile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--m2 --target --version --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions --javac -f --fresh -p --par --recompile --scalac --sha3 --skip-compile -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'run')
          case "$prev" in
              '-d' | '--dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--java') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--fresh') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--recompile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sha3') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-compile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-d --dir --java --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions --javac -f --fresh -p --par --recompile --scalac --sha3 --skip-compile -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'stats')
          case "$prev" in
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'test')
          case "$prev" in
              '--classes') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--java') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--packages') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--suffixes') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--javac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--fresh') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--recompile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--scalac') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--sha3') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--skip-compile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--classes --java --packages --suffixes --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions --javac -f --fresh -p --par --recompile --scalac --sha3 --skip-compile -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          'tipe')
          case "$prev" in
              '-p' | '--par') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--strict-aliasing') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--ignore-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--json') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--out') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--project') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--slice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--symlink') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-v' | '--versions') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-c' | '--cache') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--no-docs') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--no-sources') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--repositories') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-p --par --strict-aliasing --verbose --ignore-runtime --json -n --name -o --out --project --slice --symlink -v --versions -c --cache --no-docs --no-sources -r --repositories' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'assemble compile ive logika publish run stats test tipe' -- "$cur")); return ;;
        esac ;;
      'slang')
      case "${COMP_WORDS[2]}" in
          'run')
          case "$prev" in
              '-i' | '--input') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-o' | '--output') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-t' | '--transformed') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-n' | '--native') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-i --input -o --output -t --transformed -n --native' -- "$cur")); return ;;
            esac ;;
          'tipe')
          case "$prev" in
              '-x' | '--exclude') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--no-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--outline') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-s' | '--sourcepath') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--strict-aliasing') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--save') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--load') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-z' | '--no-gzip') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-x --exclude -f --force -r --no-runtime -o --outline -s --sourcepath --strict-aliasing --verbose --save --load -z --no-gzip' -- "$cur")); return ;;
            esac ;;
          'transpilers')
          case "${COMP_WORDS[3]}" in
              'c')
              case "$prev" in
                  '-s' | '--sourcepath') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '--strict-aliasing') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-a' | '--apps') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-b' | '--bits') COMPREPLY=($(compgen -W '64 32 16 8' -- "$cur")); return ;;
                  '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-z' | '--stack-size') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-q' | '--sequence') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '--sequence-size') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '--string-size') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '--cmake-includes') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '-e' | '--exts') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '-l' | '--lib-only') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-x' | '--exclude-build') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-p' | '--plugins') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-f' | '--fingerprint') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-i' | '--stable-type-id') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-u' | '--unroll') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '--save') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '--load') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                  '-c' | '--constants') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  '-w' | '--forward') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
                  *) COMPREPLY=($(compgen -W '-s --sourcepath --strict-aliasing -o --output-dir --verbose -a --apps -b --bits -n --name -z --stack-size -q --sequence --sequence-size --string-size --cmake-includes -e --exts -l --lib-only -x --exclude-build -p --plugins -f --fingerprint -i --stable-type-id -u --unroll --save --load -c --constants -w --forward' -- "$cur")); return ;;
                esac ;;
              *) COMPREPLY=($(compgen -W 'c' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'run tipe transpilers' -- "$cur")); return ;;
        esac ;;
      'presentasi')
      case "${COMP_WORDS[2]}" in
          'gen')
          case "$prev" in
              '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--lang') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--output-format') COMPREPLY=($(compgen -W 'mp3 wav' -- "$cur")); return ;;
              '-s' | '--service') COMPREPLY=($(compgen -W 'mary aws azure' -- "$cur")); return ;;
              '-v' | '--voice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-a' | '--aws-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-e' | '--engine') COMPREPLY=($(compgen -W 'neural standard' -- "$cur")); return ;;
              '-g' | '--gender') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-k' | '--key') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--region') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-d' | '--voice-lang') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--force -l --lang -f --output-format -s --service -v --voice -a --aws-path -e --engine -g --gender -k --key -r --region -d --voice-lang' -- "$cur")); return ;;
            esac ;;
          'text2speech')
          case "$prev" in
              '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--lang') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--output') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-f' | '--output-format') COMPREPLY=($(compgen -W 'mp3 webm ogg wav' -- "$cur")); return ;;
              '-s' | '--service') COMPREPLY=($(compgen -W 'mary aws azure' -- "$cur")); return ;;
              '-v' | '--voice') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-a' | '--aws-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-e' | '--engine') COMPREPLY=($(compgen -W 'neural standard' -- "$cur")); return ;;
              '-g' | '--gender') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-k' | '--key') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--region') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-d' | '--voice-lang') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '--force -l --lang -o --output -f --output-format -s --service -v --voice -a --aws-path -e --engine -g --gender -k --key -r --region -d --voice-lang' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'gen text2speech' -- "$cur")); return ;;
        esac ;;
      'server')
      case "$prev" in
          '-m' | '--message') COMPREPLY=($(compgen -W 'msgpack json' -- "$cur")); return ;;
          '-l' | '--log') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
          '-i' | '--no-input-cache') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
          '-t' | '--no-type-cache') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
          '-v' | '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
          '-w' | '--workers') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
          *) COMPREPLY=($(compgen -W '-m --message -l --log -i --no-input-cache -t --no-type-cache -v --verbose -w --workers' -- "$cur")); return ;;
        esac ;;
      'tools')
      case "${COMP_WORDS[2]}" in
          'bcgen')
          case "$prev" in
              '-m' | '--mode') COMPREPLY=($(compgen -W 'program script json dot' -- "$cur")); return ;;
              '--little') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--mutable') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-t' | '--traits') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-m --mode --little --mutable -p --package -n --name -l --license -o --output-dir -t --traits' -- "$cur")); return ;;
            esac ;;
          'checkstack')
          case "$prev" in
              '-m' | '--mode') COMPREPLY=($(compgen -W 'dotsu bin' -- "$cur")); return ;;
              '-o' | '--objdump') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-a' | '--arch') COMPREPLY=($(compgen -W 'amd64 x86 aarch64 arm powerpc openrisc mips mips64 m68k ia64 nios2 parisc s390x sh64 sparc' -- "$cur")); return ;;
              '-f' | '--format') COMPREPLY=($(compgen -W 'plain csv html md rst' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-m --mode -o --objdump -a --arch -f --format' -- "$cur")); return ;;
            esac ;;
          'cligen')
          case "$prev" in
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-s' | '--script') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-w' | '--width') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-l --license -n --name -o --output-dir -p --package -s --script -w --width' -- "$cur")); return ;;
            esac ;;
          'ivegen')
          case "$prev" in
              '-j' | '--jdk') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-m' | '--mode') COMPREPLY=($(compgen -W 'idea mill' -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--module') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--app') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--mill-path') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-c' | '--no-compile') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-j --jdk -m --mode -n --name --module -p --package --app --mill-path -f --force -c --no-compile' -- "$cur")); return ;;
            esac ;;
          'opgen')
          case "$prev" in
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-x' | '--exclude') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-f' | '--force') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-r' | '--no-runtime') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-s' | '--sourcepath') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--strict-aliasing') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--verbose') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '--save') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '--load') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-z' | '--no-gzip') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-l --license -n --name -o --output-dir -p --package -x --exclude -f --force -r --no-runtime -s --sourcepath --strict-aliasing --verbose --save --load -z --no-gzip' -- "$cur")); return ;;
            esac ;;
          'sergen')
          case "$prev" in
              '-m' | '--modes') COMPREPLY=($(compgen -W 'json msgpack' -- "$cur")); return ;;
              '-p' | '--package') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-m --modes -p --package -n --name -l --license -o --output-dir' -- "$cur")); return ;;
            esac ;;
          'transgen')
          case "$prev" in
              '-e' | '--exclude') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-m' | '--modes') COMPREPLY=($(compgen -W 'immutable mutable' -- "$cur")); return ;;
              '-n' | '--name') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
              '-l' | '--license') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              '-o' | '--output-dir') COMPREPLY=($(compgen -f -- "$cur")); return ;;
              *) COMPREPLY=($(compgen -W '-e --exclude -m --modes -n --name -l --license -o --output-dir' -- "$cur")); return ;;
            esac ;;
          *) COMPREPLY=($(compgen -W 'bcgen checkstack cligen ivegen opgen sergen transgen' -- "$cur")); return ;;
        esac ;;
      'x')
      case "${COMP_WORDS[2]}" in
          *) COMPREPLY=($(compgen -W '' -- "$cur")); return ;;
        esac ;;
      *) COMPREPLY=($(compgen -W 'anvil hamr logika parser proyek slang presentasi server tools x' -- "$cur")); return ;;
    esac
    return
}
complete -F sireum_completions sireum
```
