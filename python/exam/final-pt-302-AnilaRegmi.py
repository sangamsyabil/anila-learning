import os
import csv

# ------------------- #
# Part 1              #
# ------------------- #
def readFile(filename="lastname.txt"):
    file = open(filename, 'r')
    names = []
    
    for line in file:
        names.append(line.strip())  
    
    file.close()
    return names

# DO NOT make change to the function
def mystery(lastName, dictName, domain="algonquincollege.com"):
    checkName = "{}@{}".format(lastName[0:6], domain)
    i = 1
    while [checkName] in dictName.values():
        checkName = "{}{}@{}".format(lastName, i, domain)
        i = i + 1
    if lastName in dictName.keys():
        dictName[lastName].append(checkName)
    else:
        dictName[lastName] = [checkName]

    return checkName

# Create an empty dictionary called myDict
myDict = {}

# ------------------- #
# Part 2              #
# ------------------- #
lastName = 'Blow'
for _ in range(2):
    mystery(lastName, myDict)

# ---------------------------------------------------------------------------------- #
# Explanation:
# - The mystery function crafts an email address using the first six characters of a given 
# last name combined with a specified domain. 
# - It checks if this email address already exists within a dictionary of last names and 
# their associated email addresses. If the generated email is already in use, it adds 
# a number to the last name and creates a new unique email. 
# - Finally, it updates the dictionary with this unique email address linked to the 
# respective last name and returns the created/checked email for use. Essentially, it 
# ensures each last name has a distinct email address within the given domain, handling 
# cases where the initial combination is already taken.
# ----------------------------------------------------------------------------------- #

# ------------------- #
# Part 3              #
# ------------------- #
def validate_file():
    while True:
        filename = input("Enter the file name: ")
        
        if os.path.exists(filename):
            return readFile(filename)
        else:
            print("File does not exist. Try again.")

# ------------------- #
# Part 4              #
# ------------------- #
def validate_domain(domain=None):
    while True:
        if domain is None or ('.' in domain and len(domain.split('.')[-1]) in (2, 3)):
            if domain is None:
                domain = input("Please enter a domain name: ")
            return domain
        else:
            domain = input("Please enter a valid domain name: ")

# ------------------- #
# Part 5              #
# ------------------- #
names_list = validate_file()  
domain_name = validate_domain()  

for name in names_list:
    mystery(name, myDict, domain_name)

# ------------------- #
# Part 6              #
# ------------------- #
with open('result.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['Last Name', 'Email'])
    for key, value in myDict.items():
        for email in value:
            writer.writerow([key, email])
