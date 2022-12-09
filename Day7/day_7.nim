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



var homesub:seq[dir]
var home:dir = dir(size:0, subdirs:homesub)
proc parse(file:string):seq[dir]=
  let input = readFile(file)
  var line = input.split("\n")
  line.delete(line.len)
  var all:seq[dir]
  all.add(home)
  var allnothome:seq[dir]
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
      allnothome.add(nw)
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
  return allnothome

proc calc(all:seq[dir]):int=
  for i in all:
    if i.size <= 100000:
      result += i.size
proc freeSpace(all:seq[dir]):int=
  let difSize = 70000000-home.size
  let remSize = 30000000 - difSize
  result = home.size
  for i in all:
    if i.size > remSize and result > i.size:
      result = i.size


echo freeSpace(parse("day7_input"))
#echo freeSpace(parse("test_input"))
#echo calc(parse("day7_input"))
