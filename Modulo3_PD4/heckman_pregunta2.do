/*
Maestr�a en Economía PUCP
Econometría Intermedia 
M�dulo 3
PD4 - Sesgo de Selecci�n (Heckman 1979)
JP: Martín Villarán / Carlos Rodriguez
*/
clear

cd  "C:\Users\Carlos_ra\Desktop\Dirigidas Econometria Intermedia - 2018-1\Dirigida1_09Junio"
use mroz, clear 


*1) Estime por MCO los retornos de la educaci�n para aquellas mujeres que trabajaron.

regress lwage educ exper if (hours>0) 

*2) M�todo de dos estapas de Heckman(1979)

* Creamos una variable dummy que toma el valor=1 si la mujer tiene hijos, y es =0 si no tiene.

generate kids = ( kidslt6 + kidsge6 >0) 

* El m�todo de Heckman esta compuesto de los siguientes pasos:
*a)- Generar una Variable Dummy que se usar� como var. dependiente en el modelo Probit (paso 2)
*b)- Correr un modelo Probit
*c)- Calular el Ratio Inverso de Mills
*d)- Regresionar usando el Ratio Inverso de Mills como variable independiente



**********************************************************************
*a) Generar una Variable Dummy
**********************************************************************
generate dwork = 1
replace  dwork = 0 if lwage == .
**********************************************************************
*b) Estimar un modelo Probit
**********************************************************************
probit dwork age educ kids mtr
predict w, xb 

**********************************************************************
*c) Calular el Inverso del Ratio de Mills
**********************************************************************
gen InvMills = normalden(w)/normal(w) 

**********************************************************************
*d) Regresionar usando el Ratio Inverso de Mills como variable independiente en la Ec.de Salario
**********************************************************************
regress lwage educ exper InvMills


* 3) Comparar los resultados obtenidos "manualmente" en la pregunta 2 con los resultados del M�todo de Heckman en 2 etapas


heckman lwage educ exper, select (dwork= age educ kids mtr) twostep 


mfx, predict(psel)

*4) Usar el Estimador de Maxima Verosimilitud 

heckman lwage educ exper, select (dwork= age educ kids mtr)

