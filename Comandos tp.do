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
reg inflacion t 
predict trend
predict sintrend, resid

*sintren es nuestra variable sin tendencia y sin raíz unitaria (estacionalidad no había)

*2)
ac sintrend
pac sintrend 


*3) Estimamos el modelo 
arima dlnprice, arima(1,0,0) 
estat ic

arima dlnprice, arima(2,0,0) 
estat ic

arima dlnprice, arima(3,0,0) 
estat ic

*no entendí lo de predicción


*4) display (poner los numeritos a mano para cada mes). No sé cómo agregarle la tendencia y la estacionalidad 


