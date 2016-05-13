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
extern double     vol=0.1;  //       Volumen inicial
extern double        dgrilla=2;    // (d) grilla inicial
extern int        Dtot=50;    //    (D)  grilla inicial
extern int      slippage=10;               // Deslizamiento maximo permitido.

 

double equity,balance,_bid,_ask,_point ;
uint  barras_m1,barras_m5,barras_m15,barras_m30,barras_h1;
static long opens;
string come;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  //------------------------incia configuracion como marca el diagrama de flujos
   //configIni.setInterface();
   //configIni.setVolumen(volumenes);
   //configIni.setCantidadBuy(buys);
   //configIni.setCantidadSell(sells); 
  //-----------------------inicia operaciones como marca el diagrama de flujos
   operaciones.operacionApertura(_point);
   configIni.setBoton();
  //---------------------- lee posicion actual
  //posicionInicial 
  //-------------------------establece maximo y minimos
  //limites.limiteBuy();
  //limites.limiteSell();
 // limites.limiteMg();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  ObjectDelete(0,"openshort");
  EventKillTimer();                // fin timer
   
  }
//+------------------------------------------------------------------+
//| Expert tick function  funcion  experto                           |
//+------------------------------------------------------------------+

void OnTick()
  {
// ***************************************************************************
//          VARIABLES GLOBALES PARA EL INDICADOR DE GANANCIAS REAL TIME (experimental)
// ===========================================================================
equity = AccountEquity();
balance = AccountBalance();
GlobalVariableSet( "vGrafBalance", balance );
GlobalVariableSet( "vGrafEquity", equity );
// ********************* LLAMA BOTON **********************************
if ( ObjectGetInteger(0,"openshort",OBJPROP_STATE)==1){
   Print("SE ACCIONO EL BOTON");
   operaciones.ArmarGrillaInicial(Dtot,dgrilla,vol,slippage,_point);   
   ObjectSetInteger(0,"openshort",OBJPROP_STATE,false);
}  
   
// ***************************************************************************
//    VARIABLES bid ask
// ===========================================================================
   _bid     = NormalizeDouble(MarketInfo(Symbol(), MODE_BID), Digits); //define a lower price 
   _ask     = NormalizeDouble(MarketInfo(Symbol(), MODE_ASK), Digits); //define an upper price
   


// ***************************************************************************
// ***************************************************************************
// MARCO          M1
// ===========================================================================
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
//    barras de marco temporal                   M1
// ***************************************************************************
if( (iBars(NULL,PERIOD_M1)>2) && (barras_m1!=iBars(NULL,PERIOD_M1))   ){       // Velas de 1 minutito !!!
barras_m1 = iBars(NULL,PERIOD_M1);
//Print("M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1");

controles.resumenOrdenes(balance);

}

//controles.controlVelas(barras_m5,barras_m15,barras_m30,barras_h1);

if( (iBars(NULL,PERIOD_M5)>2) && (barras_m5!=iBars(NULL,PERIOD_M5))   ){       // Velas de 5 minutito !!!
barras_m5 = iBars(NULL,PERIOD_M5);
//Print("M5M5M5M5M5M5M5M5M5M5M5M5");
}

if( (iBars(NULL,PERIOD_M15)>2) && (barras_m15!=iBars(NULL,PERIOD_M15))   ){       // Velas de 15 minutito !!!
barras_m15 = iBars(NULL,PERIOD_M15);
//Print("M15M15M15M15M15");
}

if( (iBars(NULL,PERIOD_M30)>2) && (barras_m30!=iBars(NULL,PERIOD_M30))   ){       // Velas de 30 minutito !!!
barras_m30 = iBars(NULL,PERIOD_M30);
//Print("M30M30M30");
}

if( (iBars(NULL,PERIOD_H1)>2) && (barras_h1!=iBars(NULL,PERIOD_H1))   ){       // Velas de 60 minutito !!!
barras_h1 = iBars(NULL,PERIOD_H1);
//Print("H1");
}




  }
//+------------------------------------------------------------------+
