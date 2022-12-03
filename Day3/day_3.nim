import strutils,map,tables

proc item_sort(file:string):int =
  let input = readFile(file)
  var rucks = input.split('\n')
  rucks.delete(rucks.len)
  
  var total = 0
  for ruck in rucks:
    let comp1 = ruck[0..(ruck.len div 2)-1]
    let comp2 = ruck[(ruck.len div 2)..ruck.len-1]
    for i in comp1:
      if comp2.contains(i):
        total += map[i]
        break
  return total

proc groups(file:string):int =
  let input = readFile(file)
  var rucks = input.split('\n')
  rucks.delete(rucks.len)

  var i = 0
  for v in countUp(0, (rucks.len div 3)-1):
    let elf1 = rucks[i]
    let elf2 = rucks[i+1]
    let elf3 = rucks[i+2]
    

    for j in elf1:
      if elf2.contains(j) and elf3.contains(j):
        result += map[j]
        break
      
    i += 3

echo item_sort("day3_input")
echo groups("day3_input")
