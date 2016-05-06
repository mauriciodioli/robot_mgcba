//+------------------------------------------------------------------+
//|                                                       prueba.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
#include "ConfiguracionInicial.mqh"
#include "Limites.mqh"
#include "Controles.mqh"
#include "Operaciones.mqh"
ConfiguracionInicial configIni;
Limites limites;
Controles controles;
Operaciones operaciones;
//--------------------------Configuracion de parametros-----------
 int dist; 
 int volumenes;
 int buys;
 int sells;
 float posicionInicial;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  //------------------------incia configuracion como marca el diagrama de flujos
   configIni.setDistancia(dist);
   configIni.setVolumen(volumenes);
   configIni.setCantidadBuy(buys);
   configIni.setCantidadSell(sells); 
  //-----------------------inicia operaciones como marca el diagrama de flujos
   operaciones.operacionApertura();
  //---------------------- lee posicion actual
  //posicionInicial 
  //-------------------------establece maximo y minimos
  limites.limiteBuy();
  limites.limiteSell();
  limites.limiteMg();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   printf("configuraciones: %d %d %d %d",dist,volumenes,buys, sells);
   
   
  }
//+------------------------------------------------------------------+
