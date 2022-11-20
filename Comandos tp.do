*TP Econometría
clear all 
set more off 
use "C:\Users\sofi1\OneDrive\Escritorio\Económicas\Segundo Cuatri 2022\Econometría\Segunda parte\TP\BASE DE DATOS.dta"

*1) 
*Formateamos variable tiempo 
rename Fecha fecha
rename Indice ipc
tsset fecha
tsline ipc

gen lipc = ln(ipc)
gen inflacion = D.lipc

tsline lipc
tsline dlipc

*RAÍCES UNITARIAS 
dfuller ipc 

*ESTACIONALIDAD 
*genero los días de la semana
gen daynum = dow(day)
reg dlclose i.daynum 
predict estacionalidad 
predict sinestacionalidad, resid 

*para generar mes 
*gen mesnum = month(dofm(mes))



*2) justificar qué modelo usamos en base al que nos da el menor criterio de información (AIC o BIC)
ac precios
pac precio 


*3) Estimamos el modelo 
arima dlnprice, arima(1,0,0) 
estat ic

arima dlnprice, arima(2,0,0) 
estat ic

arima dlnprice, arima(3,0,0) 
estat ic

*no entendí lo de predicción


*4) display (poner los numeritos a mano para cada mes). No sé cómo agregarle la tendencia y la estacionalidad 






