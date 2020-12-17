
#include <iostream> 
#include <fstream> 
#include <limits.h>
#include <iostream>
#include <math.h>
#include <bitset>

using namespace std; 
 
// Convert the 32-bit binary encoding into hexadecimal
int Binary2Hex( std::string Binary )
{
    std::bitset<32> set(Binary);      
    int hex = set.to_ulong();
     
    return hex;
}
 
// Convert the 32-bit binary into the decimal
double Getdouble32( std::string Binary )
{
    int HexNumber = Binary2Hex( Binary );
 
    bool negative  = !!(HexNumber & 0x80000000);
    int  exponent  =   (HexNumber & 0x7f800000) >> 23;    
    int sign = negative ? -1 : 1;
 
    // Subtract 127 from the exponent
    exponent -= 127;
 
    // Convert the mantissa into decimal using the
    // last 23 bits
    int power = -1;
    double total = 0.0;
    for ( int i = 0; i < 23; i++ )
    {
        int c = Binary[ i + 9 ] - '0';
        total += (double) c * (double) pow( 2.0, power );
        power--;
    }
    total += 1.0;
 
    double value = sign * (double) pow( 2.0, exponent ) * total;
 
    return value;
}
 
// Get 32-bit IEEE 754 format of the decimal value
std::string GetBinary32( double value )
{
    union
    {
         double input;   // assumes sizeof(double) == sizeof(int)
         int   output;
    }    data;
 
    data.input = value;
 
    std::bitset<sizeof(double) * CHAR_BIT>   bits(data.output);
 
    std::string mystring = bits.to_string<char, 
                                          std::char_traits<char>,
                                          std::allocator<char> >();
 
    return mystring;
}


int main() 
{ 
	ifstream fin;
	fin.open("../Simulation/log_ieee32.txt");
	
	ofstream fout; 
	fout.open("../Simulation/result.txt");
	
	string A;
	double f ;	
	int x=8;
	
	while(fin)
	{
		fin>>A;
	
		for(int i=0;i<x;i++)
		{
		
		fin>>A;
		f=Getdouble32(A);
		fout<<f<<" ";
		}
		fin>>A;
		fout<<A;
		fout<<"\n";
	}
	
	
	fin.close();

	return 0; 
} 

