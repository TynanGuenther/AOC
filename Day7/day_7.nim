import strutils, re, options

type
  dir = ref object
    size: int
    subdirs: seq[dir]
    parent: dir

proc mkdir(parent:var dir):dir=
  var direct:dir
  var sub:seq[dir]
  direct = dir(
      size:0,
      subdirs:nil,
      parent: parent
  )
  return direct


proc parse(file:string)=
  let input = readFile(file)
  #[var all:seq[dir]
  var cd:dir
  var home:dir = dir(size:0, subdirs:all, parent:cd)
  cd = home]#

  var highest = 0
  var cd = 0
  var dirs = seq[int]
  var prev = 0
  for i in input:
    case i:
      of re"^'$ cd ..'":
        cd = prev
      of re"^'$ cd '":
        var dr = i.split(" ")
        var nw = mkdir(cd,dr[dr.len-1])
        all.add(nw)
        cd += 1
      of re"^'dir'":
        cd = mkdir(cd,i)
        cd.subdirs.add(i)
      of re"^[1-9]":
        cd.size += fileSize(i)
      else:
        continue
