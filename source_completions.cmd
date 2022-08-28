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
import org.sireum.project.{Module, Project, Target}
import org.sireum.project.ProjectUtil

def run(proc: ISZ[String]): Os.Proc.Result = {
  val prefix: ISZ[String] = if (Os.kind == Os.Kind.Win) ISZ("cmd", "/c") else ISZ[String]("sh")
  return Os.proc(prefix ++ proc).at(Os.cwd).console.runCheck()
}

def sireum_home: Os.Path = {
  Os.env("SIREUM_HOME").map(Os.path) match {
    case Some(p: Os.Path) => {
      assert(p.exists, st"Expected SIREUM_HOME ($p) to exist.".render)
      assert(p.isDir, st"Expected SIREUM_HOME ($p) to be a directory.".render)
      return p
    }
    case None() => halt("Expected SIREUM_HOME env var to be set.")
  }
}

def sireum_bin: Os.Path = {
  return sireum_home / "bin"
}

def platform: Os.Path = {
  Os.kind match {
    case Os.Kind.Mac      => sireum_bin / "mac"
    case Os.Kind.Linux    => sireum_bin / "linux"
    case Os.Kind.LinuxArm => sireum_bin / "linux" / "arm"
    case Os.Kind.Win      => sireum_bin / "win"
    case os: Os.Kind.Type => halt(st"Expected Os.kind equals Mac|Linux|LinuxArm|Win but found $os".render)
  }
}

def app: String = {
  Os.kind match {
    case Os.Kind.Mac      => "IVE.app"
    case Os.Kind.Linux    => "IVE.sh" // todo idea.sh for servers?
    case Os.Kind.LinuxArm => "IVE.sh"
    case Os.Kind.Win      => "IVE.exe"
    case os: Os.Kind.Type => halt(st"Expected Os.kind equals Mac|Linux|LinuxArm|Win but found $os".render)
  }
}

def idea: Os.Path = {
  def prepend(idea: String): Os.Path            = { platform / idea }
  def hd(paths: ISZ[Os.Path]): Os.Path          = { ops.ISZOps(paths).first }
  def valid(idea: Os.Path): B = {
    def ls(p: Os.Path): ISZ[Os.Path]            = { if (p.exists && p.isDir) p.list else ISZ[Os.Path]() }
    def name(p: Os.Path): String                = { p.abs.canon.name }
    def contains(s: String, xs: ISZ[String]): B = { ops.ISZOps(xs).contains(s) }

    val children = ls(idea)
    val names    = children.map(name)
    contains(app, names)
  }

  hd(
    ISZ("idea",
        "idea-server",
        "idea-ultimate")
    .map(prepend)
    .filter(valid)
  )
}

def ive: Os.Path = {
  return (idea / app).canon.abs
}

def launch(): Os.Proc.Result = {
  Os.kind match {
    case Os.Kind.Mac      => run(ISZ(st"open -na \"$ive\"".render))
    case Os.Kind.Linux    => run(ISZ(st"/bin/bash -c $ive".render))
    case Os.Kind.LinuxArm => run(ISZ(st"/bin/bash -c $ive".render))
    case Os.Kind.Win      => run(ISZ(st"set PATH=%PATH%;${ive}".render, "&&", "cmd", "/c", "IVE.exe"))
    // case Os.Kind.Win      => run(ISZ(st"set PATH=%PATH%;${ive / "bin"}".render, "idea.bat"))
    case platform: Os.Kind.Type => halt(st"Expected Os.kind equals Mac|Linux|LinuxArm|Win but found ${platform}".render)
  }
}

val completions: Os.Path = sireum_bin / "sireum-completions.bash"
val source_completions: Os.Path = sireum_bin / "source-completions.bash"
val skip_cache: B = T

if (skip_cache || !completions.exists) {

    source_completions.writeOver(
st"""
    |#!/bin/bash -e
    |export SCRIPT_HOME=${"$"}( cd "${"$"}( ${"$"}SIREUM_HOME/bin/ )" &> /dev/null && pwd)
    |export SCRIPT_LOC=${"$"}( cd "${"$"}( ${"$"}SIREUM_HOME/bin/${completions.name} )" &> /dev/null && pwd)
    |cd ${"$"}{SCRIPT_HOME}
    |exec ${"$"}SCRIPT_LOC
    |exec ${"$"}(source ${"$"}SCRIPT_LOC)
    |""".render
)

    source_completions.chmod("+x")

    completions.writeOver(
    """
#/usr/bin/env bash

_sireum_completions() {
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case "${COMP_WORDS[1]}" in
      'anvil')
        case "${COMP_WORDS[2]}" in
          'compile')
              case "$prev" in
                '--stage') COMPREPLY=($(compgen -W 'all hls hw sw os' -- "$cur")); return ;;
                '--transpiler-args-file' | '--sandbox-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                *) COMPREPLY=($(compgen -W '--stage --transpiler-args-file --sandbox-path' -- "$cur")); return ;;
              esac ;;
          'sandbox')
              case "$prev" in
                '-x' | '--xilinx-unified-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                '-p' | '--petalinux-installer-path') COMPREPLY=($(compgen -f -- "$cur")); return ;;
                '-s' | '--exclude-sireum' | *) COMPREPLY=($(compgen -W '-x --xilinx-unified-path -p --petalinux-installer-path -s --exclude-sireum' -- "$cur")); return ;;
              esac ;;
          *) COMPREPLY=($(compgen -W 'compile sandbox' -- "$cur")); return ;;
        esac ;;
      'hamr')
          case "${COMP_WORDS[2]}" in
            'codegen') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'phantom') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            *)         COMPREPLY=($(compgen -W 'codegen phantom' -- "$cur")); return ;;
          esac ;;
      'logika')
          case "${COMP_WORDS[2]}" in
            'verifier') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            *)          COMPREPLY=($(compgen -W 'verifier' -- "$cur")); return ;;
          esac ;;
      'parser')
          case "${COMP_WORDS[2]}" in
            'gen') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            *)     COMPREPLY=($(compgen -W 'gen' -- "$cur")); return ;;
          esac ;;
      'proyek')
          case "${COMP_WORDS[2]}" in
            'assemble') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'compile')  COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'ive')      COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'logika')   COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'publish')  COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'run')      COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'stats')    COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'test')     COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            'tipe')     COMPREPLY=($(compgen -W '' -- "$cur")); return ;;   # TODO
            *)        COMPREPLY=($(compgen -W 'assemble compile ive logika publish run stats test tipe' -- "$cur")); return ;;
          esac ;;
      'slang')
          case "${COMP_WORDS[2]}" in
            'run')  COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'tipe') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'transpilers')
              case "${COMP_WORDS[2]}" in
                'c') COMPREPLY=($(compgen -W '' -- "$cur")); return ;;  # TODO
                *) COMPREPLY=($(compgen -W 'c' -- "$cur")); return ;; # TODO
              esac ;;
            *) COMPREPLY=($(compgen -W 'run tipe transpilers' -- "$cur")); return ;;
          esac ;;
      'presentasi')
          case "${COMP_WORDS[2]}" in
            'gen')          COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'text2speech')  COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            *)              COMPREPLY=($(compgen -W 'gen text2speech' -- "$cur")); return ;;
          esac ;;
      'server')
          case "${COMP_WORDS[2]}" in
            *) COMPREPLY=($(compgen -W '' -- "$cur")); return ;; # TODO
          esac ;;
      'tools')
          case "${COMP_WORDS[2]}" in
            'bcgen')      COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'checkstack') COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'cligen')     COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'ivegen')     COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'opgen')      COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'sergen')     COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            'transgen')   COMPREPLY=($(compgen -f -- "$cur")); return ;; # TODO
            *) COMPREPLY=($(compgen -W 'bcgen checkstack cligen ivegen opgen sergen transgen' -- "$cur")); return ;;
          esac ;;
      *) COMPREPLY=($(compgen -W 'anvil hamr logika parser proyek slang presentasi server tools' -- "$cur")); return ;;
    esac

    COMPREPLY=($(compgen -W 'anvil hamr logika parser proyek slang presentasi server tools' -- "$cur"));
    return
}

complete -F _sireum_completions sireum
""")
completions.chmod("+x")
}

source_completions.call(ISZ()).console.runCheck()
// run(ISZ(st"source ${(completions, Os.fileSep)}".render))
