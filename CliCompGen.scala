// #Sireum
/*
 Copyright (c) 2022, Matthew Weis, Kansas State University
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package org.sireum.tools

import org.sireum._
import org.sireum.cli.CliOpt
import org.sireum.cli.CliOpt._

object CliCompGen {

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
}