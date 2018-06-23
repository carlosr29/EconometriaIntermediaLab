/*
Maestría en Economía - PUCP
Econometría Intermedia 
Módulo 3
PD4
JP: Martín Villarán / Carlos Rodriguez
*/

clear
// Pregunta 3 (Adicional): 

cd  "C:\Users\Carlos_ra\Desktop\Dirigidas Econometria Intermedia - 2018-1\Dirigida1_09Junio"
use "C:\Users\Carlos_ra\Desktop\Dirigidas Econometria Intermedia - 2018-1\Dirigida1_09Junio\tobacco.dta", clear

*a) Analice la variable share2. ¿Qué características presenta?
codebook share2
summ share2
kdensity share2

*b.	Estime el modelo (1) por  MCO. ¿Qué problema potencial enfrentan los coeficientes estimados? 
reg share2 age nadults nkids nkids2 lnx agelnx nadlnx

*c.	Estime el modelo reemplazando los  ceros con missing. ¿Qué problema potencial enfrentan los coeficientes estimados?
reg share2 age nadults nkids nkids2 lnx agelnx nadlnx if (share2>0)
*O
preserve  // para no dañar la base permanentemente 
replace share2=. if share2==0
reg share2 age nadults nkids nkids2 lnx agelnx nadlnx if (share2>0)
restore // la regresamos al estado previo a "preserve"

*d.	Ahora utilice un Tobit para estimar el mismo modelo. Compare los resultados con los de MCO.
tobit share2 age nadults nkids nkids2 lnx agelnx nadlnx, ll

* esta etimando todo en un logaritmo de maximo verosimilitud y reconoce que hay una fracción de la distribución que tiene observaciones bien comportadas,
* aparece cuantas obaservaciones han sido censuradas




/*e Utilizando el modelo Tobit estimado, halle y compare los valores ajustados de la variable dependiente para los siguientes casos:
	E[y* |x] : valor esperado de la variable latente 
	E[y|x,y>0] : valor esperado de la variable truncada 
	E[y|x] : valor esperado de la variable censurada 
	Pr[y*>0] : probabilidad de no censura  en y^*
*/

*	E[y* |x] : valor esperado de la variable latente 
predict yh1 if e(sample), xb
twoway kdensity yh1
*	E[y|x,y>0] : valor esperado de la variable truncada 
predict yh2 if e(sample), e(0,.)
*	E[y|x] : valor esperado de la variable censurada 
predict yh3 if e(sample), ystar(0,.)
twoway (kdensity yh1) (kdensity yh2) (kdensity yh3)

*	Pr[y*>0] : probabilidad de no censura  en y*
predict yh4 if e(sample), pr(0,.)
* La prob. de ser mayor a 0 (no ser truncado) esta posit. correlac. con
* el valor predicho. A mÃ¡s alto, menos chance de estar truncado.
scatter yh4 yh1
scatter yh4 yh2
scatter yh4 yh3



/* 	f. Estime los siguientes efectos marginales y comparelos con los de MCO:
	delta_E[y*|x]/delta_x_k : Efecto sobre la variable latente
	delta_E[y|x,y>0]/delta_x_k : Efecto sobre el valor esperado de la variable truncada
	delta_E[y|x] : Efecto sobre el valor esperado de la variable censurada
	delta_Pr[y*>0] : Efecto sobre la probabilidad de no censura  de y^*
*/
	
*sobre E(y*|x)

tobit share2 age nadults nkids nkids2 lnx agelnx nadlnx, ll
outreg2 using tobit1, excel replace
*sobre E(y|x, y>0)

tobit share2 age nadults nkids nkids2 lnx agelnx nadlnx, ll
margins, dydx(*) predict (e(0,.)) post
outreg2 using tobit1, excel append

*sobre E(y|x>0)
* La siguiente tabla  muestra  los  efectos  marginales  sobre  la  variable  latente,  
* aquella que  no  observamos  su  distribución  completa. 
tobit share2 age nadults nkids nkids2 lnx agelnx nadlnx , ll
margins, dydx(*) predict (ystar(0,.)) post
outreg2 using tobit1, excel append


*sobre Pr[y*>0]
tobit share2 age nadults nkids nkids2 lnx agelnx nadlnx , ll
margins, dydx(*) predict (pr(0,.)) post


outreg2 using tobit1, excel append

* Regresion
reg share2 age nadults nkids nkids2 lnx agelnx nadlnx
outreg2 using tobit1, excel append

* Regresion sin censurados
reg share2 age nadults nkids nkids2 lnx agelnx nadlnx if (share2>0)
outreg2 using tobit1, excel append


