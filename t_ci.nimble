# Package

version       = "0.1.0"
author        = "litlighilit"
description   = "A demo to test github CI"
license       = "MIT"
srcDir        = "src"

const projName = "t_ci"

# Dependencies
requires "nim >= 2.0.0"

import std/os

func getArgs(taskName: string): seq[string] =
  ## cmdargs: 1 2 3 4 5 -> 1 4 3 2 5
  var rargs: seq[string]
  let argn = paramCount()
  for i in countdown(argn, 0):
    let arg = paramStr i
    if arg == taskName:
      break
    rargs.add arg
  if rargs.len > 1:
    swap rargs[^1], rargs[0] # the file must be the last, others' order don't matter
  return rargs



func handledArgs(args: var seq[string], def_arg: string) =
  ## makes args: @[option..., arg/"ALL"]
  if args.len == 0:
    args.add def_arg
    return
  let lastArg = args[^1]
  if lastArg[0] == '-': args.add def_arg
  elif lastArg == "ALL": args[^1] = def_arg
  # else, the last shall be a nim file

func getHandledArg(taskName: string, def_arg: string): string =
  ## the last param can be an arg, if given,
  ##
  ## def_arg is set as the last element when the last is not arg or is "ALL",
  ## if no arg, then sets def_arg as the only.
  var args = getArgs taskName
  args.handledArgs def_arg
  result = quoteShellCommand args

task testDoc, "cmdargs: if the last is arg: " & 
    "ALL: gen for all(default); else: a nim file":
  let def_arg = srcDir / projName
  let sargs = getHandledArg("testDoc", def_arg)
  selfExec "doc --project --outdir:docs " & sargs

task testLibDoc, "":
  discard

