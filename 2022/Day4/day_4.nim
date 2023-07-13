import strutils

proc clean_camp(file:string):int=

  let input = readFile(file)
  var pairs = input.split("\n")
  pairs.delete(pairs.len)

  for pair in pairs:
    var secs = pair.split(",")
    var num0 = secs[0].split("-")
    var num1 = secs[1].split("-")
    if parseInt(num0[0]) >= parseInt(num1[0]) and parseInt(num0[0]) <= parseInt(num1[1]):
      result += 1
      continue
    if parseInt(num0[1]) >= parseInt(num1[0]) and parseInt(num0[1]) <= parseInt(num1[1]):
      result += 1
      continue
    if parseInt(num1[0]) >= parseInt(num0[1]) and parseInt(num1[0]) <= parseInt(num0[1]):
      result += 1
      continue
    if parseInt(num1[1]) >= parseInt(num0[0]) and parseInt(num1[1]) <= parseInt(num0[1]):
      result += 1



echo clean_camp("day4_input")
