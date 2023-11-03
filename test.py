def f(a=5):
    b =3
    a = a+b
    return a

a=6
b=2
f()
print(a,b)
a =f(3)
print(a,b)

print(list(range(5)))



print("----------------------------------------------------------------")
def multiply(a,b):
    return a*b

def summuate(c, d):
    return c+d

x = multiply(summuate(3,4),5)
print(x)

acc = 0
for accc in range(0, 10):
    acc += accc

print(acc)

print("----------------------------------------------------------------")
