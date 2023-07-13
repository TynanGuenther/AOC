import strutils, re, stacks


#[proc parse_stack(stackFile:string)=
  let stackInput = readFile(stackFile)
  
  var rows = stackInput.split("\n")
  var f:seq[Stack[string]]
  for row in 0..rows.len-3:
    var p = rows[row].split(re"^.{3}\w")
    for i in 0..p[0].len-1:
      var stack = Stack[string]()
      f.add(stack)
      echo p
    for j in 0..p.len-1:
      echo j
      var k = p[j].split(re"..\w")
      echo k
      #[for j,v in k:
        f[j].push(v)]#
  #return f]#

proc cheat_parse(stackFile:string):seq[Stack[string]]=
  let input = readFile(stackFile)
  var rows = input.split("\n")
  var stacks:seq[Stack[string]]

  for i,row in rows:
    var stack = Stack[string]()
    stacks.add(stack)
    var items = row.split(" ")
    for item in items:
      stacks[i].push(item)
      

  return stacks

proc parse_input(file:string):seq[seq[string]]=
  let input = readFile(file)

  var line = input.split("\n")
  line.delete(line.len)
  var f = @[@[""]]
  for row in line:
    var p = row.split(re" ")
    p.delete(0)
    p.delete(1)
    p.delete(2)
    f.add(p)
  f.delete(0)
  return f

proc crate_stack(stackFile:string, input:seq[seq[string]])=
  let inputs = readFile(stackFile)
  var rows = inputs.split("\n")
  var stacks:seq[Stack[string]]

  for i,row in rows:
    var stack = Stack[string]()
    stacks.add(stack)
    var items = row.split(" ")
    for item in items:
      stacks[i].push(item)
  stacks.delete(stacks.len)


  for sets in input:
    var many = 0
    var fro = 0
    var to = 0
    for i,num in sets:
      case i:
        of 0:
          many = parseInt(num)
        of 1:
          fro = parseInt(num)
        of 2:
          to = parseInt(num)
        else:
          continue
    var tempstack:Stack[string] = Stack[string]()
    for i in 0..many-1:
      var tm = stacks[fro-1].pop()
      #echo "pop",tm
      tempstack.push(tm)
    for i in 0..many-1:
      var td = tempstack.pop()
      #echo "push",td
      stacks[to-1].push(td)


  for i in stacks:
    echo i.peek()

crate_stack("stack_input", parse_input("day5_input"))
  







  
