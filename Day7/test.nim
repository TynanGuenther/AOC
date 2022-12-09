import strutils, oop_utils/standard_class,re



if match("$ ls ..", re"([cd ](?:\w+))", start=2):
  echo "fuck"

  

