::#! 2> /dev/null                                   #
@ 2>/dev/null # 2>nul & echo off & goto BOF         #
if [ -z ${SIREUM_HOME} ]; then                      #
  echo "Please set SIREUM_HOME env var"             #
  exit -1                                           #
fi                                                  #
exec ${SIREUM_HOME}/bin/sireum slang run "$0" "$@"  #
:BOF
setlocal
if not defined SIREUM_HOME (
  echo Please set SIREUM_HOME env var
  exit /B -1
)
%SIREUM_HOME%\bin\sireum.bat slang run "%0" %*
exit /B %errorlevel%
::!#

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

def compGen(config: org.sireum.cli.CliOpt): ST = {

  def choiceResult(choices: ISZ[ST]): ST = {
    return st"""COMPREPLY=($$(compgen -W '${(choices, " ")}' -- "$$cur")); return"""
  }

  def emptyResult(): ST = {
    return st"""COMPREPLY=($$(compgen -W '' -- "$$cur")); return"""
  }

  def fileResult(): ST = {
    return st"""COMPREPLY=($$(compgen -f -- "$$cur")); return"""
  }

  def recTool(c: Tool): ST = {
    // return a ST of shortKey (if it exists) and longKey. Keys are wrapped by 'wrap' and separated by 'sep'
    def optKeys(opt: Opt, wrap: String, sep: String): ST = {
      val longKey = st"${opt.longKey}"
      opt.shortKey match {
        case Some(shortKey) => return st"""$wrap-$shortKey$wrap$sep$wrap--$longKey$wrap"""
        case None() => return st"""$wrap--$longKey$wrap"""
      }
    }

    def tpe(opt: Opt): ST = {
      opt.tpe match {
        case t: Type.Choice => choiceResult(t.elements.map((s: String) => st"$s"))
        case _: Type.Flag => emptyResult()
        case _: Type.Num => emptyResult()
        case _: Type.NumFlag => emptyResult()
        case t: Type.NumChoice => choiceResult(t.choices.map((z: Z) => st"$z"))
        case _: Type.Path => fileResult()
        case _: Type.Str => emptyResult()
      }
    }

    // combine opts and group's opts
    val opts = c.opts ++ c.groups.flatMap((g: OptGroup) => g.opts)
    // case for each opt
    val cases = opts.map((o: Opt) => st"${optKeys(o, "'", " | ")}) ${tpe(o)} ;;")
    // summary of all flags
    val flags = opts.map((o: Opt) => st"${optKeys(o, "", " ")}")

    return st"""case "$$prev" in
               |  ${(cases, "\n")}
               |  *) ${choiceResult(flags)} ;;
               |esac"""
  }

  def recGroup(depth: Z, g: Group): ST = {
    // recurse the group's tools and subgroups
    def rec(sub: org.sireum.cli.CliOpt): ST = {
      sub match {
        case sub: Group => recGroup(depth.increase, sub)
        case sub: Tool => recTool(sub)
      }
    }

    return st"""case "$${COMP_WORDS[$depth]}" in
               |  ${(for (sub <- g.subs) yield st"'${sub.command}')\n${rec(sub)} ;;", "\n")}
               |  *) ${choiceResult(for (sub <- g.subs) yield st"${sub.command}")} ;;
               |esac"""
  }

  val body: ST = config match {
    case config: Group => recGroup(z"1", config)
    case config: Tool => recTool(config)
  }

  return st"""#!/usr/bin/env sh
             |
             |sireum_completions() {
             |    COMPREPLY=()
             |    cur=$${COMP_WORDS[COMP_CWORD]}
             |    prev=$${COMP_WORDS[COMP_CWORD - 1]}
             |    $body
             |    return
             |}
             |complete -F sireum_completions sireum
             |"""
}

println(compGen(main).render)
