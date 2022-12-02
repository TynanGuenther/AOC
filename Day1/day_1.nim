import strutils
let input = readFile("day1_input")
type highestArr = array[3, int]
var highest: highestArr = [0,0,0]
let ar = input.split("\n\n")
for i in ar:
  var nums = i.split("\n")
  if nums.contains(""):
    nums.delete(8)
  var tot = 0
  for j in nums:
    let val = parseInt(j)
    tot += val
  var temp = 0
  var temp2 = 0
  if tot > highest[0]:
    temp = highest[0]
    highest[0] = tot
    temp2 = highest[1]
    highest[1] = temp
    highest[2] = temp2
  elif tot > highest[1]:
    temp = highest[1]
    highest[1] = tot
    highest[2] = temp
  elif tot > highest[2]:
    highest[2] = tot
  
var total = 0
for i in highest:
  total += i
echo highest
echo total
