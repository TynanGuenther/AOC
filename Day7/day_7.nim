import strutils, re

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
      parent: parent,
      subdirs: sub
  )
  return direct

proc fileSize(size:string):int=
  var parts = size.split(" ")
  return parseInt(parts[0])

proc parse(file:string):seq[dir]=
  let input = readFile(file)
  var line = input.split("\n")
  line.delete(line.len)
  var all:seq[dir]
  var home:dir = dir(size:0, subdirs:all)
  var cd = home

  for j,i in line:
    
    if i == "$ cd /":
      cd = home
    elif match(i, re"ls", start=2) or match(i, re"[dir ]((?:\w+))"):
      continue
    elif match(i, re"\.\.$", start=5):
      cd = cd.parent
    elif match(i, re"([cd ](?:\w+))", start=2):
      var nw = mkdir(cd)
      cd.subdirs.add(nw)
      cd = nw
      all.add(nw)
    elif match(i, re"^[1-9]"):
      var size = fileSize(i)
      cd.size += size
      if cd.parent != nil:
        var c = cd
        while cd.parent != nil:
          cd.parent.size += size
          cd = cd.parent
        cd = c
    else:
      continue
  return all

proc calc(all:seq[dir]):int=
  for i in all:
    if i.size <= 100000:
      result += i.size

echo calc(parse("day7_input"))
