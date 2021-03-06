
' 1) Series de tiempo estacionarias. Genere las siguientes series de tiempo (en un program en Eviews) de tal manera que todas sean estacionarias. Obtenga los gr�ficos, funciones de autocorrelaci�n y funciones de autocorrelaci�n parcial de cada serie de tiempo. Comente si estas funciones se asemejan a las funciones te�ricas (las vistas en clase te�rica).

' Definimos el tama�o y seteamos una raiz de pseudo n�meros aleatorios para que los resultados sean replicables

create u 1 1000
rndseed 1

'1a) "ruido blanco" con constante
smpl @all
genr rb_c=10+nrnd
freeze(rb_c_correl) rb_c.correl(24)
freeze(rb_c_histog) rb_c.hist

'1b) AR(3) con coeficientes positivos
smpl @first @first+2
series ar3_a=0
smpl @first+3 @last
series ar3_a=0.20*ar3_a(-1)+0.20*ar3_a(-2)+0.20*ar3_a(-3)+nrnd
freeze(ar3_a_correl) ar3_a.correl(24)
freeze(ar3_a_histog) ar3_a.hist

'       AR(3) con coeficientes negativos
smpl @first @first+2
series ar3_b=0
smpl @first+3 @last
series ar3_b=-0.2*ar3_b(-1)-0.2*ar3_b(-2)-0.2*ar3_b(-3)+nrnd
freeze(ar3_b_correl) ar3_b.correl(24)
freeze(ar3_b_histog) ar3_b.hist


'1c) MA(3) con coeficientes positivos
smpl @all
series rb1=nrnd
series ma3_a=0
smpl @first+3 @last
series ma3_a=rb1+0.2*rb1(-1)+0.2*rb1(-2)+0.2*rb1(-3)
freeze(ma3_a_correl) ma3_a.correl(24)
freeze(ma3_a_histog) ma3_a.hist

'       MA(3) con coeficientes negativos
smpl @all
series rb1=nrnd
series ma3_b=0
smpl @first+3 @last
series ma3_b=rb1-0.2*rb1(-1)-0.2*rb1(-2)-0.2*rb1(-3)
freeze(ma3_b_correl) ma3_b.correl(24)
freeze(ma3_b_histog) ma3_b.hist


'1d) ARMA(2,1)
smpl @all
series rb2=nrnd
series ma1=0
smpl @first+1 @last
series ma1=rb2+0.20*rb2(-1)
smpl @first @first+1
series arma21=rnd
smpl @first+2 @last
series arma21=0.2*arma21(-1)+0.2*arma21(-2)+ma1
freeze(arma21_correl) arma21.correl(24)
freeze(arma21_histog) arma21.hist


