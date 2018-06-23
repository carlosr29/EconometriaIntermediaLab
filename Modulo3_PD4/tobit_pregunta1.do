/*
Maestría en EconomÃ­a PUCP
EconometrÃ­a Intermedia 
Módulo 3
PD4 - Pregunta 1 (Tobit)
JP: MartÃ­n VillarÃ¡n / Carlos Rodriguez
*/

clear

cd  "C:\Users\Carlos_ra\Desktop\Dirigidas Econometria Intermedia - 2018-1\Dirigida1_09Junio"
use mroz.dta

* 1)	Describa y examine los estadísticos más importantes de las variables.

describe hours educ exper age kidslt6
sum hours educ exper age kidslt6  

* 2)	Analice la variable hours usando un histograma. ¿Qué características presenta? 
histogram hours, frequency title(Horas Trabajadas por las Mujeres Casadas)


* 3) 
sum hours educ exper age kidslt6 if (hours>0) 
sum hours educ exper age kidslt6 if (hours==0) 



* 4) MCO usando toda la muestra
* Usando MCO: El problema es que este modelo no me asegura que las estimaciones se encontrarán en el intervalo de números positivos.

reg hours educ exper age kidslt6

* Usando la sub-muestra de mujeres que trabajan 

reg hours educ exper age kidslt6 if (hours>0)  


* 5) Estimar lo mismo Usando el modelo tobit

tobit hours educ exper age kidslt6, ll(0)   


* 6) Calcule los efectos marginales de cada variable explicativa sobre la probabilidad de que una mujer tenga una cantidad positiva de horas trabajadas

mfx compute, predict(pr(0,.))

* 7) 7)	Calcule el efecto marginal de cada variable explicativa en el esperado de las horas trabajadas condicional a que la mujer se encuentra trabajando en el mercado laboral 

mfx compute, predict(e(0,.))




 