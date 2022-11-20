*TP Econometría
clear all 
set more off 
use "C:\Users\sofi1\OneDrive\Escritorio\Económicas\Segundo Cuatri 2022\Econometría\Segunda parte\TP\BASE DE DATOS.dta"

*1) 
*Formateamos variable tiempo 
rename Indice ipc
rename Fecha fecha
gen t=_n /* mejor para que diga mes y año*/
tsset t 

tsline ipc
gen lipc = ln(ipc)
gen inflacion = D.lipc
tsline inflacion

*RAÍCES UNITARIAS 
dfuller ipc 
dfuller inflacion

*El orden de integración es 1, porque hicimos una diferencia y la serie se vuelve estacionaria. 

*ESTACIONALIDAD 
*genero los días de la semana
gen mesnum = month(dofm(fecha))
reg inflacion i.mesnum

*Como todos los meses son no significativos, no hay evidencia de estacionalidad. 

*TENDENCIA 
*Por el gráfico notamos que la variable podría tener una tendencia exponencial 
gen t2 = t^2
gen t3 = t^3
reg inflacion t t2 t3 
predict trend
predict inflacion1, resid

*sintrend es nuestra variable sin tendencia y sin raíz unitaria (estacionalidad no había)

*2)
*MA. AUTOCORRELACION
ac inflacion1

*AR AUTORRELACION PARCIAL
pac inflacion1

*En base a los gráficos obtenidos, podríamos pensar que el modelo es un ARMA (2,1). 

*ARMA (2,1)
arima inflacion1, arima(2,0,1) // AIC: -1466,137 BIC: -1449,169
estat ic

*AR(2)
arima inflacion1, arima(2,0,0) // AIC: -1464,861  BIC: -1451,286
estat ic

*AR(1)
arima inflacion1, arima(1,0,0) // AIC: -1470,152   BIC: - 1459,971
estat ic

*MA(1)
arima inflacion1, arima(0,0,1) // AIC: -1461,059  BIC:  -1450,878
estat ic


*ARMA(1,1)
arima inflacion1, arima(1,0,1) // AIC: -1468,205   BIC: -1454,63

*Según los criterios de información (tanto AIC como BIC) podemos ver que el modelo es un AR(1)



