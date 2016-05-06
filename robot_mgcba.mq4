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
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   configIni.setDistancia(dist);
   configIni.setVolumen(volumenes);
   configIni.setCantidadBuy(buys);
   configIni.setCantidadSell(sells); 
     
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
