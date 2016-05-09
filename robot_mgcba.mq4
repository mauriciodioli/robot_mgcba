//+------------------------------------------------------------------+
//|                                                       prueba.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, LPAHFT"
#property link      "http://www.mql4.com"
#property version   "1.0"
#property strict
#include "ConfiguracionInicial.mqh"
#include "Limites.mqh"
#include "Controles.mqh"
#include "Operaciones.mqh"
ConfiguracionInicial configIni;
Limites limites;
Controles controles;
Operaciones operaciones;

//*********************************************************************
//--------------------------Configuracion de parametros-----------
//*********************************************************************

extern  int d_reticulado_pip = 2;   // distancia entre ordenes del reticulado.
extern  int H_reticulado=  1;     // atr1
extern  int atr5p  =  7;     // atr5 para detectar la vela muy grande
extern  int periodofgdi = 51 ;
 int dist; 
 int volumenes;
 int buys;
 int sells;
 float posicionInicial;
//--------------------------FIN Configuracion de parametros-----------
//--------------------------------------------------------------------

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  //------------------------incia configuracion como marca el diagrama de flujos
   //configIni.setDistancia(dist);
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
   //printf("configuraciones: %d %d %d %d",dist,volumenes,buys, sells);
   
   
  }
//+------------------------------------------------------------------+
