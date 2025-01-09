import random 

colors = ["Red", "Green", "Yellow", "Blue", "Orange", "Purple"]

print("Hello! Welcome to Mastermind!")
element1 = random.choice(colors)
element2 = random.choice(colors)
element3 = random.choice(colors)
element4 = random.choice(colors)
solution = [element1 , element2, element3, element4]

counts = {}
for el in colors:
    val = solution.count(el)
    counts.update({el : val})


print("I have come up with an unguessable code!! MUAHAHA")
print("The elements you can guess are (R)ed, (G)reen (Y)ellow (B)lue (O)range (P)urple")
print("enter your first guess as a string of four capital letters")

guess = input()

letter_to_string = {"R": "Red", "G": "Green", "Y" : "Yellow", "B": "Blue", "O" : "Orange", "P": "Purple"}
guess_formated  =  [letter_to_string[char] for char in guess]
right_place_right_color =  0
wrong_place_right_color = 0

for idx, val in enumerate(guess_formated) :
    if val == solution[idx] :
        right_place_right_color += 1

for el in colors:
    count_in_guess = guess.count(el)
    count_in_solution = counts[el]
    num = min(count_in_guess, count_in_solution)
    wrong_place_right_color +=  num

wrong_place_right_color = wrong_place_right_color - right_place_right_color

print(right_place_right_color, wrong_place_right_color)
