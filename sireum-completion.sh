#/usr/bin/env bash
### should work for zsh, sh, bash. Not sure about fish?
### I always thought ./ syntax was short for "source" but doesn't seem to work for completions...


### AUTOCOMPLETE TIPS (source: https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial)


# 1 - source this file on your cli to enable its autocompletion


# 2 - to declare a static wordlist of autocompleteable words use:

### complete -W 'anvil hamr logika parser proyek slang presentasi server tools' sireum


# 3 - use complete -F with a function for programmable autocomplete.

### _dynamic_autocomplete_test() {
###
###   # Dynamic example delegates autocomplete logic to Slang, but jvm startup makes it very slow. We could use transpiled c version.
###   # Interesting use cases: autocomplete valid source paths, slang code, valid hardware functions, etc.
###   echo $(./sireum-completion-helper.cmd $COMP_LINE)
###
###   # Faster dynamic example is a self-contained shell script generated by cligen
### }
###
### complete -F _sireum_dynamic_autocomplete sireum

# 4 - use compgen to filter completion suggestions based on current input, i.e.

### compgen -W 'anvil hamr logika parser proyek slang presentasi server tools' pres


# 5 - use the following variables inside the complete function (note: DIRECT QUOTE)

###
### COMP_WORDS: an array of all the words typed after the name of the program the compspec belongs to
###
### COMP_CWORD: an index of the COMP_WORDS array pointing to the word the current cursor is at
###             in other words, the index of the word the cursor was when the tab key was pressed
###
### COMP_LINE: the current command line


### END OF AUTOCOMPLETE TIPS

# _return_files() {
#     # Return file and directory listings by enabling default mode and sending empty.
#     COMPREPLY=($(compgen -f -- "$cur"))
#     return
# }

# _subcommand_template_holder() {
# case "${COMP_WORDS[2]}" in
#           'compile')
#               case "$prev" in
#                 '--stage')
#                   COMPREPLY=($(compgen -W 'all hls hw sw os' -- "$cur")); return ;;
#                 '--transpiler-args-file')
#                   COMPREPLY=($(compgen -f -- "$cur")); return ;;
#                 '--sandbox-path')
#                    COMPREPLY=($(compgen -f -- "$cur")); return ;;
#                 *)
#                   COMPREPLY=($(compgen -W '--stage --transpiler-args-file --sandbox-path org.example.gen#funList' -- "$cur")); return ;;
#               esac ;;
#           'sandbox')
#               case "$prev" in
#                 '-x' | '--xilinx-unified-path')
#                    # Return file and directory listings by enabling default mode and sending empty.
#                    COMPREPLY=($(compgen -f -- "$cur")); return ;;
#                 '-p' | '--petalinux-installer-path')
#                    # Return file and directory listings by enabling default mode and sending empty.
#                    COMPREPLY=($(compgen -f -- "$cur")); return ;;
#                 '-s' | '--exclude-sireum' | *) # since exclude-sireum is flag, include with subcases
#                   COMPREPLY=($(compgen -W '-x -p -s --xilinx-unified-path --petalinux-installer-path --exclude-sireum' -- "$cur")); return ;;
#               esac ;;
#           *) COMPREPLY=($(compgen -W 'compile sandbox' -- "$cur")); return ;;
#         esac
# }

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