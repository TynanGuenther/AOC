import sequtils

proc connect_packet(file:string):int=
  let input = readFile(file)
  
  for i in 0..input.len-1:
    var arr = input[i..i+3]
    var s:seq[char]
    for j in arr:
      s.add(j)
    var sd = s.deduplicate()
    if s == sd:
      return i+4

proc connect_message(file:string):int=
  let input = readFile(file)
  
  for i in 0..input.len-1:
    var arr = input[i..i+13]
    var s:seq[char]
    for j in arr:
      s.add(j)
    var sd = s.deduplicate()
    if s == sd:
      return i+14



echo connect_message("day6_input")
    

