# -*- coding: utf-8 -*-
"""
Created on Mon Jul 06 19:50:56 2020

@author: PRALAY KR CHATTERJEE
@co-author: SOHAM MONDAL
"""
import csv
time_in_femtoseconds = []
tp = []
td = []
Xn = []
Yn = []
Isyn1 = []
WWx = []
Ax = []
Dx = []
RMtrx = []
Prelx = []
Inhx = []



#def posit32_4_dummy(p):
#    print(p)
def posit32_4_to_decimal(p):

    if p == "xxxxxxxx":
        return("xxxxxxxx")
        #pass
    elif p == "00000000":
        return("0")
        pass
    else:
        a=[]
        res = str("{0:08b}".format(int(p, 16)))
        kk = len(res)
        while kk<32:
            a.append('0')
            kk+=1
        a.append (res)
        i = "".join(a)
        es = 4
        sign= float(i[0])
        useed=pow(2, pow(2,es))
        k0 = float(i[1])
        n = 2
        r = 1
        k = 0
        while float(i[n])==k0:
            n+=1
            r+=1
        if k0==0:
            k = -r
        else:
            k = r-1
        e= float(i[n+1])*8+float(i[n+2])*4+float(i[n+3])*2+float(i[n+4])
        f=int(i[n+5:],2)
        a1 = n+5
        a = []
        while n+5<32:
            a.append('1')
            n+=1
        str1 = "".join(a)
        f0 = int(str1,2)
        p = pow((-1), sign) * pow(useed, k) * pow(2, e) * (1+ (f/f0))
        return(p)

if __name__ =="__main__":

			
			



    with open('../Simulation/log_posit.txt','r') as f:
        lines = f.readlines()
        for l in lines:
        #print(l)
            time_in_femtoseconds.append(((l.split(',')[0].strip()).split('-')[1].strip()))
            tp.append((l.split(',')[1].strip()).split('-')[1].strip())
            td.append((l.split(',')[2].strip()).split('-')[1].strip())
            Xn.append(posit32_4_to_decimal((l.split(',')[3].strip()).split('-')[1].strip()))
            Yn.append(posit32_4_to_decimal((l.split(',')[4].strip()).split('-')[1].strip()))
            Isyn1.append(posit32_4_to_decimal((l.split(',')[5].strip()).split('-')[1].strip()))
            WWx.append(posit32_4_to_decimal((l.split(',')[6].strip()).split('-')[1].strip()))
            Ax.append(posit32_4_to_decimal((l.split(',')[7].strip()).split('-')[1].strip()))
            Dx.append(posit32_4_to_decimal((l.split(',')[8].strip()).split('-')[1].strip()))
            RMtrx.append(posit32_4_to_decimal((l.split(',')[9].strip()).split('-')[1].strip()))
            Prelx.append(posit32_4_to_decimal((l.split(',')[10].strip()).split('-')[1].strip()))
            Inhx.append(posit32_4_to_decimal((l.split(',')[11].strip()).split('-')[1].strip()))

    with open ('../Simulation/result_decimal.csv','w',newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(('time_in_femtoseconds','tp','td','Xn','Yn','Isyn1','WWx','Ax','Dx','RMtrx','Prelx','Inhx'))
        rows = zip(time_in_femtoseconds,tp,td,Xn,Yn,Isyn1,WWx,Ax,Dx,RMtrx,Prelx,Inhx)
        for row in rows:
            writer.writerow(row)
    #print(tp)
