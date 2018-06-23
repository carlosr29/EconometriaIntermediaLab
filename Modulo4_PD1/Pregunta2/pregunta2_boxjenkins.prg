for %a 1 2 3 4 5 6 7 8 9 10
	freeze(line_s{%a}) s{%a}.line
next

freeze(line_all) line_s1 line_s2 line_s3 line_s4 line_s5 line_s6 line_s7 line_s8 line_s9 line_s10

d line_s*

'smpl 1984q1 @last

'GRAFICO DE LINEAS
for %a 3
	freeze(line_s{%a}) s{%a}.line
next

'HISTOGRAMA
for %a  3
	freeze(hist_s{%a}) s{%a}.hist
next

'DESESTACIONALIZADAS
'DESESTACIONALIZACION POR X12
for %a 3
	s{%a}.x12(save=" d11") s{%a}
next

for %a 3
	freeze(line_s{%a}_sa) s{%a}_sa.line
next

for %a 3
	freeze(hist_s{%a}_sa) s{%a}_sa.hist
next

'SUAVIZADAS
'SUAVIZAMIENTO CON LOGARITMOS
for %a 3
	series log_s{%a} = log(s{%a})
next

for %a 3
	freeze(line_log_s{%a}) log_s{%a}.line
next

for %a 3
	freeze(hist_log_s{%a}) log_s{%a}.hist
next

'DESESTACIONALIZADAS Y SUAVIZADAS
for %a 3
	series log_s{%a}_sa = log(s{%a}_sa)
next

for %a 3
	freeze(line_log_s{%a}_sa) log_s{%a}_sa.line
next

for %a 3
	freeze(hist_log_s{%a}_sa) log_s{%a}_sa.hist
next

freeze(g_line_all) line_s3 line_s3_sa line_log_s3 line_log_s3_sa
freeze(g_hist_all) hist_s3 hist_s3_sa hist_log_s3 hist_log_s3_sa

d line_* hist_*

'[CONCLUSIONES ANALISIS GRÁFICO]

'TEST DE RAÍZ UNITARIA
for %test adf pp dfgls np ers kpss
	for %serie 3
		freeze(urt_{%test}_s{%serie})s{%serie}.uroot({%test}, const, info=maic)
	next
next

'[CONCLUSIONES DE LOS TEST DE R.U.]


'CORRELOGRAMAS
for %a 3
	freeze(corr_s{%a}) s{%a}.ident(15)
next

for %a 3
	freeze(corr_s{%a}_sa) s{%a}_sa.ident(15)
next

for %a 3
	freeze(corr_log_s{%a}) log_s{%a}.ident(15)
next

for %a 3
	freeze(corr_log_s{%a}_sa) log_s{%a}_sa.ident(15)
next

'[CONCLUSIONES DE LOS CORRELOGRAMAS]
'- AR(1)
'- MA(2) o MA(5)

'-ARMA(1,1)
'-ARMA(1,2)
'-AR(1)
'-MA(2)

'rndseed 1
'series e=nrnd
equation arma1_1.ls s3 c AR(1) MA(1)
equation arma1_2.ls s3 c AR(1) MA(1) MA(2)
equation arma1_0.ls s3 c AR(1)
equation arma2_0.ls s3 c AR(1) AR(2)
equation arma3_0.ls s3 c AR(1) AR(2) AR(3)
equation arma2_1.ls s3 c AR(1) AR(2) MA(1)
equation arma0_1.ls s3 c MA(1)
equation arma0_2.ls s3 c MA(1) MA(2)
equation arma0_3.ls s3 c MA(1) MA(2) MA(3)
equation arma0_4.ls s3 c MA(1) MA(2) MA(3) MA(4)
equation arma2_3.ls s3 c AR(1) AR(2) MA(1) MA(2) MA(3)
equation arma2_4.ls s3 c AR(1) AR(2) MA(1) MA(2) MA(3) MA(4)
equation arma3_3.ls s3 c AR(1) AR(2) AR(3) MA(1) MA(2) MA(3)
equation arma4_3.ls s3 c AR(1) AR(2) AR(3) AR(4) MA(1) MA(2) MA(3)

' Los temas de la PD terminan en este punto, luego de evaluar el modelo ARMA que mejor se ajusta a los datos.
' El paso 4 es opcional, ya que involucra temas de Predicción, que si bien están dentro de la Metodología Box Jenkins, no forman parte de los temas de esta clase.

' PASo 4 : Prediccion

' Hacemos forecast con los mejores modelos ARMA(2,3) y ARMA(2,4)
smpl 2011q1 2011q4
freeze(forecast_arma23) arma2_3.forecast(e) serie3__outsample_arma23

smpl @first @last     
group forecast_arma_23 s3 serie3__outsample_arma23 
freeze(forecast_arma23) forecast_arma_23.line

'  ARMA(2,4)

smpl 2011q1 2011q4
freeze(forecast_arma24) arma2_4.forecast(e) serie3__outsample_arma24

smpl @first @last     
group forecast_arma_24 s3 serie3__outsample_arma24 
freeze(forecast_arma24) forecast_arma_24.line


