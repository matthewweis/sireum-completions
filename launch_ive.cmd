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
  val prefix: ISZ[String] = if (Os.kind == Os.Kind.Win) ISZ("cmd", "/c") else ISZ[String]()
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

def bin: Os.Path = {
  return sireum_home / "bin"
}

def platform: Os.Path = {
  Os.kind match {
    case Os.Kind.Mac      => bin / "mac"
    case Os.Kind.Linux    => bin / "linux"
    case Os.Kind.LinuxArm => bin / "linux" / "arm"
    case Os.Kind.Win      => bin / "win"
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

println(st"found ${ive}".render)
println(launch())
