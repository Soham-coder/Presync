# -*- coding: utf-8 -*-
"""
Created on Mon Jul 28 19:50:56 2020

@author: Soham Mondal
"""
import csv
import binascii
import struct

from struct import unpack


list1 = []
list2 = []
list3 = []
list4 = []
list5 = []
list6 = []
list7 = []
list8 = []
list9 = []
list10 = []


def float_64_decimal_converter(number_in_float64_list):
    decimal = []
    for value in number_in_float64_list:
        try:
            decimal.append(str((struct.unpack('>d', binascii.unhexlify(value)))).lstrip('(').rstrip(',)'))
        except:
            decimal.append("XXXXXXXX")
    return(decimal)

if __name__ == "__main__":
    with open('../Simulation/log_ieee64.txt','r') as f:
        lines = f.readlines()
        for l in lines[1:]:
            list = (l.split(','))
            #print(list)
            res0 = [ list[0] ]
            #print(res0)
            res1 = [ list[1] ]
            res2 = [ list[2] ]
            res3 = [ list[3] ]
            res4 = [ list[4] ]
            res5 = [ list[5] ]
            res6 = [ list[6] ]
            res7 = [ list[7] ]
            res8 = [ list[8] ]
            res9 = [ list[9].strip() ]
            #print(str(float_64_decimal_converter(res0)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list1.append(str(float_64_decimal_converter(res0)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list2.append(str(float_64_decimal_converter(res1)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list3.append(str(float_64_decimal_converter(res2)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list4.append(str(float_64_decimal_converter(res3)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list5.append(str(float_64_decimal_converter(res4)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list6.append(str(float_64_decimal_converter(res5)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list7.append(str(float_64_decimal_converter(res6)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list8.append(str(float_64_decimal_converter(res7)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list9.append(str(float_64_decimal_converter(res8)).lstrip('[').rstrip(',]').lstrip("'").rstrip("'"))
            list10.append(l.split(',')[9].strip())

    with open('../Simulation/res_64_dec.csv','w',newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(('Xn','Yn','Isyn1','WWx','Ax','Dx','RMtrx','Prelx','Inhx','time'))
        #writer.writerow(('Xn','Yn','Isyn1','Inhx','Prelx','Prel1','Prel2','Prel3','Prel4','time'))
        #writer.writerow(('Xn','Isyn1','WWx','Ax','Dx','Pxy','anq','Prelx','Inhx','time'))
        rows = zip(list1,list2,list3,list4,list5,list6,list7,list8,list9,list10)
        for row in rows:
            writer.writerow(row)



