//accepts 3D wave (Fermi surface maps/manipulator scans/etc.)
//transforms photoemission spectrum's angle-axis to k-axis
// EF= kinetic energy value where Fermi-energy is
// inwvname is input wave where y and z are angular axis with each 0 value corresponding to normal emission,
// x is kinetic energy scale

#pragma rtGlobals=1		// Use modern global access method.

function deg2kvec3d(inwvname, EF)
string inwvname
variable EF
string newname
variable dimst0, dimd0, dimsiz0
variable dimst1, dimd1,dimsiz1
variable dimst2, dimd2,dimsiz2
variable klimpz, klimmz, abslen,i,j, klimmy, klimpy

newname = inwvname + "Ek3d"
wave inwv = $inwvname

dimst0 = dimoffset(inwv, 0); dimd0 =  dimdelta(inwv, 0); dimsiz0=dimSize(inwv,0);
dimst1 = dimoffset(inwv, 1); dimd1 =  dimdelta(inwv, 1);dimsiz1=dimSize(inwv,1);
dimst2 = dimoffset(inwv, 2); dimd2 =  dimdelta(inwv, 2);dimsiz2=dimSize(inwv,2);

abslen = abs(dimst1-dimst1+dimd1*dimsiz1);

if (exists(newname) == 0)
	make/O/N=(dimsiz0, dimsiz1,dimsiz2) $newname
endif

wave outwv = $newname
SetScale/P x dimst0-EF,dimd0,"E-E\BF\M (eV)", outwv	//scale energy axis to binding energy

klimpz =1.1*0.512*sqrt(EF)*sin(Pi/180*dimst1)
klimmz =1.1*0.512*sqrt(EF)*sin(Pi/180*(dimst1+dimsiz1*dimd1))
klimpy =1.1*0.512*sqrt(EF)*sin(Pi/180*dimst2)
klimmy =1.1*0.512*sqrt(EF)*sin(Pi/180*(dimst2+dimsiz2*dimd2))

SetScale/I y klimpz, klimmz,"k-Vector",  outwv //scale °-axis to k-axis
SetScale/I z klimpy, klimmy,"k-Vector",  outwv //scale °-axis to k-axis
For(i=0;i<dimsiz2;i+=1)
outwv[][][i] = ((180/Pi*asin(y/(0.512*sqrt(x+EF))) >= dimst1) && (180/Pi*asin(y/(0.512*sqrt(x+EF))) <= dimst1+dimsiz1*dimd1)) ? inwv(x+EF)(180/Pi*asin(y/(0.512*sqrt(x+EF)))) : NaN 
//outwv=inwv(x+EF)(180/Pi*asin(y/(0.512*sqrt(x+EF))))
endfor
//For(i=0;j<dimsiz1;j+=1)
//outwv[][j][] = ((180/Pi*asin(y/(0.512*sqrt(x+EF))) >= dimst2) && (180/Pi*asin(y/(0.512*sqrt(x+EF))) <= dimst2+dimsiz2*dimd2)) ? inwv(x+EF)(180/Pi*asin(y/(0.512*sqrt(x+EF)))) : NaN
//endfor


end