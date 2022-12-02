def importData(path):
  with open(path) as f:
      return f.read().splitlines()

stratValues = {
  "A X": 3,
  "A Y": 4,
  "A Z": 8,
  "B X": 1,
  "B Y": 5,
  "B Z": 9,
  "C X": 2,
  "C Y": 6,
  "C Z": 7
}

def calculateTotal(data):
  totalValue = 0
  for strategy in data:
    totalValue += stratValues[strategy]
  return totalValue

print(calculateTotal(importData("./input.txt")))

