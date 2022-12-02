def importData(path):
  with open(path) as f:
      return f.read().splitlines()

values = {
  "A X": 4,
  "A Y": 8,
  "A Z": 3,
  "B X": 1,
  "B Y": 5,
  "B Z": 9,
  "C X": 7,
  "C Y": 2,
  "C Z": 6
}

def calculateTotal(data):
  totalValue = 0
  for strategy in data:
    totalValue += values[strategy]
  return totalValue

print(calculateTotal(importData("./input.txt")))

