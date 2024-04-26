import re
import numpy as np
f1= open("final_output_from_fft.txt","r")
f2= open("expected_outputs.txt","r")
lines1 = f1.readlines()

x1=[];x2=[]
for line in lines1:   # for fft file 
    line =line.strip()
    arr = re.split("j|\s+",line)
    num1 = float(arr[0])
    #print(num1)
    num2=float(arr[1])
    #print(num2)
    totalnum = (num1*num1 + num2*num2)**0.5
    x1.append(float(totalnum))
   #x2.append(float(num2))
f1.close()

lines2=f2.readlines()
y1=[];y2=[]

for line in lines2:   # for python outputs-
    line =line.strip()
    arr = re.split("j|\s+",line)
    num1 = float(arr[0])
    num2= float(arr[1])
    totalnum = (num1**2 + num2**2)**0.5
    y1.append(float(totalnum))
    #y2.append(float(num2))

f2.close()

x1=np.array(x1); y1=np.array(y1)
error_mag = x1 - y1
percent_error = np.divide(error_mag,x1)*100
#err_imag = np.array(x2) -np.array(y2)

writer=open("compared_val_fft.txt","w")
for i in range(len(x1)):
    print("error: "+ str(error_mag[i])+"    "+ "percentage error: "+ str(percent_error[i])+ "\n")
    #print(str(y1[i])+ "   "+ str(y2[i]))
    writer.write("error: "+ str(error_mag[i])+"    "+ "percentage error: "+ str(percent_error[i])+ "\n")
    #print(y1[i])
writer.close()

