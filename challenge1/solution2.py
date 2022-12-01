def importData(path):
  with open(path) as f:
      read_data = f.read()
      read_data_array = read_data.splitlines()
      return read_data_array

def findMaxValue(array):
  maxValues = []
  currentElfValue = 0
  for value in array:
    if value == "":
      maxValues.append(currentElfValue)
      currentElfValue = 0
    else:
      currentElfValue += int(value)

  maxValues.sort(reverse=True)
  return maxValues[0] + maxValues[1] + maxValues[2]

def main():
  print(findMaxValue(importData("./input.txt")))

main()