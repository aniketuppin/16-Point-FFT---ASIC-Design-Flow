import re
def fp2int(mantissa,expo_valid):
    #print(len(mantissa))
    if(expo_valid):
        sum=1
        for i in range(10):
            sum += int(mantissa[i])/(2**(i+1))
            #print(i)
    else:
        sum=0
    return sum
    
fp=open("o_data.txt","r")
writer=open("final_output_from_fft.txt","w")
lines=fp.readlines()
j=0
for line in lines:
    line=line.strip()
    arr = re.split('\+|i|\*|;', line)
    num1=arr[0]
    num2=arr[3]
    sign1= 1 if ( num1[0]== '0' ) else -1       
    expo1=num1[1:6]
    mant1=num1[6:]

    sign2= 1 if (num2[0]=='0') else -1
    expo2=num2[1:6]
    mant2=num2[6:]
    #print(num1," ",num2)
    print(str(sign1 * fp2int(mant1,(int(expo1)!=0))*2**(int(expo1,2)-15)) + " + " + str(sign2 * fp2int(mant2,(int(expo2)!=0))*2**(int(expo2,2)-15)) +"i")
    #print(j)
    j+=1
    if (sign2 == -1):
        writer.write( str(sign1* fp2int(mant1,(int(expo1)!=0))*2**(int(expo1,2)-15))  + " " + str(sign2* fp2int(mant2,(int(expo2)!=0))*2**(int(expo2,2)-15)) +"j" + "\n")
    else:
        writer.write( str(sign1* fp2int(mant1,(int(expo1)!=0))*2**(int(expo1,2)-15)) + " +" + str(sign2* fp2int(mant2,(int(expo2)!=0))*2**(int(expo2,2)-15)) +"j" + "\n")
fp.close()
writer.close()
