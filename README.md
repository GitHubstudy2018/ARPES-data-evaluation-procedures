# ARPES-data-evaluation-procedures
I'm sharing here a few procedures I programmed in IGOR Pro to evaluate ARPES data obtained by a Scienta SES data acquisition program

Just move the .ipf file of your desire to your IGOR Pro user procedures location to make it work.

See the wiki for additional explanations.

Explanation of the files:

## degdeg2kk.ipf

This procedure turns a Fermi Surface Map that is represented as a 3-dimensional wave (x = Binding Energy, y = tilt angle, z = polar angle) into a 2-dimensional Fermi Surface Map with the common representation of k_x wave vector over k_y wave vector. The function you have to use is 

```
degdeg2kk(inwvname, targetE, EF)
```
whereas *inwvname* is your 3-dimensional input wave, *targetE* is your target energy in units of E-E_f where you want your Fermi surface map to be cut (e.g. if you want to look at the Fermi surface 0.5 eV below the Fermi level, *targetE* should be -0.5 eV), *EF* is the Fermi Energy on the electrons kinetic energy scale (which is photon energy hv minus analyzer work function in electron volts).

The output wave / k_x,k_y-Fermi surface will appear in the same folder as your input wave and will be named as "kk<targetE>"
