########################################################
# This function returns the number of entries
# number of entries will be the number of Tests and
# the number of Assignments (see lines 65 and 66)
########################################################
def getNumberOfEntries(entry):
    return entry

######################################################################
# Question 1: (5 marks)
# Modify the function getNumberOfEntries so that it restricts the number
# of entries to a positive number and so that it keeps prompting for
# the number of entries if the user entry is invalid ie: not an int
######################################################################
def getNumberOfEntries(entry):
    while True:
        try:
            numEntries = int(input("Enter the number of {}: ".format(entry)))
            if numEntries > 0:
                return numEntries
            else:
                print("Please enter a positive number.")
        except ValueError:
            print("Invalid input. Please enter a valid integer.")

######################################################################
# Question 2:(10 marks)
# Write the function getGradeOfFinal that prompts the user for the final
# practical grade.
# The function keeps asking the user until the grade is a valid float
# number between 0 and 100
######################################################################
def getGradeOfFinal():
    while True:
        try:
            grade = float(input("Enter the final practical grade: "))
            if 0 <= grade <= 100:
                return grade
            else:
                print("Grade not in the range [0, 100]. Please enter a valid grade between 0 and 100.")
        except ValueError:
            print("Invalid input. Please enter a valid float number.")

# The function getListOfTests  prompts the user for the list of n Test Grades.
# The function keeps asking the user until the grade is a valid float number
# between 0 and 100

def getListOfTests(n):
    done = False
    listOfTests = []
    i = 0
    while not done:
        try:
            grade = float(input("Enter grade for Test {} > ".format(i+1)))
            if 0 <= grade <= 100:
                listOfTests.append(grade)
                i = i + 1
            else:
                print("Grade not in range [0,100]")
                continue
            if i == n:
                done = True

        except ValueError:
            print("Invalid value for test")

    return listOfTests


###################################################################
# Question 3: (5 marks)
# Write the function getListOfAssignments that prompts the user for
# the list of Assignment Grades.
# The function keeps asking the user until the grade is a valid float A
# number between 0 and 100
###################################################################
def getListOfAssignments(n):
    listOfAssignments = []
    for i in range(n):
        done = False
        while not done:
            try:
                grade = float(input("Enter grade for Assignment {} > ".format(i + 1)))
                if 0 <= grade <= 100:
                    listOfAssignments.append(grade)
                    done = True
                else:
                    print("Grade not in the range [0, 100]. Please enter a valid grade between 0 and 100.")
            except ValueError:
                print("Invalid input. Please enter a valid float number.")
    return listOfAssignments

nAssignments = getNumberOfEntries("Assignments")
nTests = getNumberOfEntries("Tests")

# The following two lists contain the grades of tests and the grades of labs/assignemnts
listTests = getListOfTests(nTests)
listAssignments = getListOfAssignments(nAssignments)

################################################################
# Question 4: (5 marks)
# Using listTests, calculate the average of test grades
################################################################
avgTests = 0
if len(listTests) > 0:
    avgTests = sum(listTests) / len(listTests)
    print("Average Test Grade:", avgTests)
else:
    print("No test grades available to calculate the average.")

################################################################
# Question 5: (5 marks)
# Using listAssignments, Calculate the average of assignment grades
################################################################
avgAssignments = 0
if len(listAssignments) > 0:
    avgAssignments = sum(listAssignments) / len(listAssignments)
    print("Average Assignment Grade:", avgAssignments)
else:
    print("No assignment grades available to calculate the average.")

# Get the grade of the Final practical
gFinal = getGradeOfFinal()

# Percentages as specified by the course outline
weightAssignments = 0.4
weightTests = 0.35
weightFinal = 0.25

################################################################
# Question 6: (5 marks)
# Calculate the final numberical grade given the previous
# percentages
################################################################
finalGrade = 0
finalGrade = (avgAssignments * weightAssignments) + (avgTests * weightTests) + (gFinal * weightFinal)
print("Final Grade:", finalGrade)

###################################################################
# Question 7: (10 marks)
# Calculate the final letter grade according to the course outline
###################################################################
grading_scale = {
    (90, 100): 'A+',
    (85, 89): 'A',
    (80, 84): 'A-',
    (75, 79): 'B+',
    (70, 74): 'B',
    (65, 69): 'B-',
    (60, 64): 'C+',
    (55, 59): 'C',
    (50, 54): 'C-',
    (45, 49): 'D+',
    (40, 44): 'D',
    (0, 39): 'F'
}
letterGrade = ''
for (lower, upper), grade in grading_scale.items():
    if lower <= finalGrade <= upper:
        letterGrade = grade
        break

print(f"Your final grade is {finalGrade} which is {letterGrade}")
print("Thank you")