# Package

version       = "0.1.0"
author        = "litlighilit"
description   = "A demo to test github CI"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.0.0"
task testDoc, "":
  selfExec "doc --index:on " & srcDir & "/t_ci"

task testLibDoc, "":
  discard

