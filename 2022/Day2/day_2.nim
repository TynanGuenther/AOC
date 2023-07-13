import strutils, tables

let input = readFile("day2_input")

var games = input.split("\n")

var myScore = 0
var oppScore = 0
var map = {
  "A" : 1,
  "B" : 2,
  "C" : 3,
  "X" : 1,
  "Y" : 2,
  "Z" : 3,
}.toTable
let wMap = {
      "A" : "Y",
      "B" : "Z",
      "C" : "X"
    }.toTable
let lMap = {
      "A" : "Z",
      "B" : "X",
      "C" : "Y"
    }.toTable
let tMap = {
      "A" : "X",
      "B" : "Y",
      "C" : "Z"
}.toTable
games.delete(games.len)
proc rps_normal()=
  for game in games:
    var turn = game.split(" ")
    var opp = turn[0]
    var umm = turn[turn.len-1]
    var my = ""
    case umm:
      of "X":
        my = lMap[opp]
      of "Y":
        my = tMap[opp]
      of "Z":
        my = wMap[opp]
      else:
        continue

    if (map[opp] - map[my]) < 0 and (map[opp] - map[my]) > -2 or (map[opp] - map[my]) == 2:
      myScore += 6
      echo "win ", opp, " ", my
    elif map[opp] == map[my]:
      oppScore +=  3
      myScore +=  3
      echo "tie ", opp, " ", my
    else:
      echo "loss ", opp, " ", my
      oppScore += 6

    myScore += map[my]
    oppScore += map[my]


  echo myScore

rps_normal()
