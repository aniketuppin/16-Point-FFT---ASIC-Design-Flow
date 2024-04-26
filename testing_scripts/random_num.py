import random
import sys
random.seed(20)
def random_number():
    
    num =""
    
    num1=random.random()*20
    #num2=random.random()*50
    num = str(num1) 
    
    return num

#length=int(sys.argv[1])
fh1= open("inputs.txt","w")
#fh2=open("expected_output.txt","w")
for i in range(16):
    random_num= random_number()
    if(i< 15):
        
        fh1.write(random_num + "\n")
        print(random_num)
        #fh2.write(str(num1*num2) +"\n")
    else:
        fh1.write(random_num)
        print(random_num)
        #fh2.write(str(num1*num2))
fh1.close()
#fh2.close()

    
