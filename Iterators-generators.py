### Iterators ###
#
# nums = iter([10,20,30,40,50])
#
# for x in nums:
#     print(x)
#     if(x == 30):
#         break
# print(type(nums))
#
# swe= iter([45,50,13])
# for s in swe:
#    print(s)
#    if(s ==50):
#     break
# for s in swe:
#     print(s)
# for s in swe:
#     print(s)





#
# # #del nums
#
# print("second loop => ")
# for x in nums:
#     print(x)
#
# for x in nums:
#     print(x)



### generator #########

#
def test(x,y,z):
    res1 = x + y + z
    yield res1
    res2 = x - y - z
    yield res2
    res3 = x * y * z
    yield res3

op = test(10,5,2)
print(op)

firstres = next(op)
print("first op = " , firstres)

secres = next(op)
print("second op = " , secres)

thirdres = next(op)
print("third op = " , thirdres)










