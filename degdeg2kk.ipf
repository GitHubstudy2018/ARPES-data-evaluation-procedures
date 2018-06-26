#pragma rtGlobals=1		// Use modern global access method.

//In the finished kxky-cut, kx corresponds to column dimension,
// ky corresponds to layer dimension 

function degdeg2kk(inwvname, targetE, EF)
string inwvname			//3D wave (binding energy X tilt X polar angle)
variable EF			//Fermi Energy on kinetic energy scale (hv - analyzer work function in eV)
variable targetE		//target energy in E-Ef where FS map should be cut
variable dimst0, dimd0, dimsiz0		//dimension parameters of input wave
variable dimst1, dimd1,dimsiz1
variable dimsiz2, dimd2, dimst2
variable klimpx, klimmx, klimmy, klimpy	//left and right boundaries for kx and ky of output FS map
variable abslen,i,j
//wave temp

string labelkxky

wave inwv = $inwvname
dimst0 = dimoffset(inwv, 0); dimd0 =  dimdelta(inwv, 0); dimsiz0=dimSize(inwv,0)
dimst1 = dimoffset(inwv, 1); dimd1 =  dimdelta(inwv, 1);dimsiz1=dimSize(inwv,1)
dimst2 = dimoffset(inwv, 2); dimd2 =  dimdelta(inwv, 2);dimsiz2=dimSize(inwv,2)
labelkxky ="kk" + num2str(targetE)
if (exists(labelkxky) == 0)
	make/O/N=(dimsiz1, dimsiz2) $labelkxky
endif

//if (exists(newname) == 0)
//	make/O/N=(dimsiz0, dimsiz1) $newname
//endif

make/O/N=(DimSize(inwv,1),DimSize(inwv,2)) temp
SetScale/P x, DimOffset(inwv,1), DimDelta(inwv,1), "y-scale (deg)" temp
SetScale/P y, DimOffset(inwv,2), DimDelta(inwv,2), "polar angle (deg)" temp
temp=inwv(targetE)[p][q]
//NewImage temp

wave outwv = $labelkxky

klimpx =0.512*sqrt(EF)*sin((Pi/180)*dimst1)
klimmx =0.512*sqrt(EF)*sin((Pi/180)*(dimst1+dimsiz1*dimd1))
klimpy =0.512*sqrt(EF)*sin((Pi/180)*dimst2)*cos(Pi/180*dimst1)
klimmy =0.512*sqrt(EF)*sin((Pi/180)*(dimst2+dimsiz2*dimd2))*cos((Pi/180)*(dimst1+dimsiz1*dimd1))

SetScale/I y, klimpy, klimmy,"k\By\M ("+num2char(197)+"\S-1\M)" outwv //scale °-axis to k-axis (
SetScale/I x, klimpx, klimmx,"k\Bx\M ("+num2char(197)+"\S-1\M)" outwv //scale °-axis to k-axis

outwv=temp((180/Pi)*asin(x/(0.512*sqrt(targetE+EF))))((180/Pi)*(y/sqrt(0.512^2*(targetE+EF)-x^2)))
end

