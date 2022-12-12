import strutils

type
  tree = object
    v_left, v_right, v_top, v_bottom:bool
    val, d_left, d_right, d_up, d_down:int



proc bush(file:string):seq[seq[tree]]=
  let input = readFile(file)
  var linez = input.split("\n")
  linez.delete(linez.len)
  var trees:seq[seq[tree]]
  for line in linez:
    var row:seq[tree]
    for height in line:
      var tre = tree()
      tre.val = int(height)-48
      row.add(tre)
    trees.add(row)
  return trees

var forest = bush("day8_input")
proc tree_house()=
   
  for i in 1..forest.len-2:
    for j in 1..forest[i].len-2:
#up
      var u = i-1
      while u >= 0:
        if forest[u][j].val < forest[i][j].val or u == i:
          forest[i][j].d_up += 1
          if forest[u][j].v_top:
            if u > 0:
              forest[i][j].d_up += forest[u][j].d_up
            forest[i][j].v_top = true
            break
        else:
          forest[i][j].d_up += 1
          break
        u -= 1

#down
      var d = i + 1
      while d < forest.len:
        if forest[d][j].val < forest[i][j].val:
          forest[i][j].d_down += 1
          if forest[d][j].v_bottom:
            if d < forest.len - 1:
              forest[i][j].d_down += forest[d][j].d_down
            forest[i][j].v_top = true
            break
        else:
          forest[i][j].d_down += 1
          break
        d += 1
#left      
      var l = j - 1
      while l >= 0:
        if forest[i][l].val < forest[i][j].val:
          forest[i][j].d_left += 1
          if forest[i][l].v_left:
            if l > 0:
              forest[i][j].d_left += forest[i][l].d_left
            forest[i][j].v_left = true
            break
        else:
          forest[i][j].d_left += 1
          break
        l -= 1
#right
      var r = j + 1
      while r < forest[i].len:
        if forest[i][r].val < forest[i][j].val:
          forest[i][j].d_right += 1
          if forest[i][r].v_right:
            if r < forest[i].len - 1:
              forest[i][j].d_right += forest[i][r].d_right
            forest[i][j].v_right = true
            break
        else:
          forest[i][j].d_right += 1
          break
        r += 1
  

proc edge()=
  var count = 0
  for r,row in forest:
    if count != 0 and count != forest.len - 1:
      forest[r][0].v_left = true
      forest[r][forest[r].len-1].v_right = true
    else:
      if count == 0:
        for t,tre in row:
          forest[r][t].v_top = true
      else:
        for t,tre in row:
          forest[r][t].v_bottom = true

    count += 1




proc visible():int=
  for row in forest:
    for tre in row:
      if tre.v_left or tre.v_right or tre.v_top or tre.v_bottom:
 #       echo tre.val
        result += 1

proc tallest():int=
  var highest = 0
  for row in forest:
    for tre in row:
      var cur = tre.d_up * tre.d_down * tre.d_left * tre.d_right
      if cur > highest:
        highest = cur
  return highest



edge()
tree_house()
echo tallest()

