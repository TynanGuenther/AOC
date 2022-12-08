import strutils, classes



class tree:

  var before:tree
  var val:int
  var chidren:seq[tree]

  method addVal(val:int)=
    this.val += val

  method addChild(child:node)=
    this.children.add(child)
 

  

var jeff:seq[node]
var l:node

for i in 0..10:
  var cd:node
  if i < 1 or (i > 5 and i < 7):
    var f:seq[node]

    var nw = node(val: 0,  before: nod, children: f).init()
    cd = nw
    cd.addChild(nw)

  if i == 3:
    cd = cd.before


  if i < 5:
    cd.addVal(i)

echo nod.children[0].val
