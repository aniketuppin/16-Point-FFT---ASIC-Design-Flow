def int2fp(fp_num):
    num=float(fp_num)
    
    if(num>=0):
        sign='0'
    else:
        sign='1'
    num = abs(num)
    
    
    int_num= num//1
    float_num = num - int_num
    
    man_list=[]
    
    while(int_num > 1 and len(man_list) <10):
        man_list.insert(0,int(int_num%2))
        int_num//=2
    #print(len(man_list))
    
    exp= int(len(man_list) + 15)
    
    #if(num == 0.0):
    #    exp=0
    
    
    while(len(man_list)< 10 and float_num!=0.0):
        float_num*=2
        if(float_num >=1):
            man_list.append(1)
            float_num -=1
        else:
            man_list.append(0)
            
            
           
    if(int_num < 1 and len(man_list)!=0 and num!=0):
        while(man_list[0]==0):
            exp -=1
            man_list.pop(0)
        exp-=1
        man_list.pop(0)
    
    
    while(len(man_list) < 10):
        man_list.append(0)
        
    if(num == 0.0):
        exp=0 
        
    exp_list=[]
    for i in range(5):
        exp_list.insert(0,int(exp%2))
        exp/=2
    floating_num= str(sign)  + (''.join(str(e) for e in exp_list)) + (''.join(str(e) for e in man_list)) 
    return floating_num
        
'''        
fp2=open("inputs.txt","r")
writer2=open("data_in.txt","w")
lines2=fp2.readlines()
for line in lines2:
    in1=line.strip()
    #in1=line.split(" ");
    #imag=imag[0:-1]
    print(in1)
    
    #print("fp_num {0:s}: -> ".format(line),int2fp(line))
    writer2.write(int2fp(in1) + "0000000000000000" + "\n")
fp2.close()
writer2.close()
'''


fp=open("inputs.txt","r")
writer2=open("data_in.txt","w")
#readlines = [line.rstrip("\n") for line in fp.readlines()]
lines=fp.readlines()
for line in lines:
    line=line.strip()
    arr=line.split(" ")
    #print(arr)
    num1= arr[0]
    num2= arr[1].rstrip("j")
    #imag=imag[0:-1]
    print(num1, num2)
    
    #print("fp_num {0:s}: -> ".format(line),int2fp(line))
    writer2.write(int2fp(num1) + int2fp(num2) + "\n")
fp.close()
writer2.close()
