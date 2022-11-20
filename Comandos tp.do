*TP Econometría
clear all 
set more off 

*1) 
*Formateamos variable tiempo 
format tiempo %ym 
tsset tiempo 

*RAÍCES UNITARIAS 
dfuller precios 

*ESTACIONALIDAD 
*genero los días de la semana
gen daynum = dow(day)
reg dlclose i.daynum 
predict estacionalidad 
predict sinestacionalidad, resid 

*para generar mes 
*gen mesnum = month(dofm(mes))

*Generamos las variables en logaritmo y en diferencias 
foreach t in precios {
gen l`t' = ln(`t')
gen dl`t' = D.l`t'
}

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








