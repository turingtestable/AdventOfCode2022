def importData(path):
  with open(path) as f:
      read_data = f.read()
      read_data_array = read_data.splitlines()
      return read_data_array

def findMaxValue(array):
  maxValue = 0
  currentElfValue = 0
  for value in array:
    if value == "":
      maxValue = max(maxValue, currentElfValue)
      currentElfValue = 0
    else:
      currentElfValue += int(value)
  return maxValue

def main():
  print(findMaxValue(importData("./input.txt")))

main()