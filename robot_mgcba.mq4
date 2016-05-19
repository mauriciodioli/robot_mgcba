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
#include "Boton.mqh"
#include "Linea.mqh"
#include "Sonido.mqh"
ConfiguracionInicial configIni;
Limites limites;
Controles controles;
Operaciones operaciones;
Linea ObjLinea;
Sonido sonido;
 
//*********************************************************************
//--------------------------Configuracion de parametros-----------
//*********************************************************************
extern double   vol=0.1;  //       Volumen inicial
extern double   dgrilla=2;    // (d) grilla inicial
extern int      Dtot=50;    //    (D)  grilla inicial
extern int      slippage=10;               // Deslizamiento maximo permitido.
//+------------------------------------------------------------------------------------+
//| Sonidos Se declara un obj sonido el cual tiene los distintos metodos para sonidos  |
//+------------------------------------------------------------------------------------+
string sonidoIinicio="ini.wav";
string sonidoFin="stops.wav";
//+------------------------------------------------------------------------------------+
//| Constructor de botones (nombre del Boton, Descripcion,X,Y,Color,X tama�o,Y tama�o) |
//+------------------------------------------------------------------------------------+
string Boton1="Boton1";
string descripcion="_INICIO_";
color colorBoton1=clrGreen;

string Boton2="Boton2";
string descripcion2="_APAGADO_";
color colorBoton2=clrRed;

string Boton3="Boton3";
string descripcion3="_AVANCE_";
color colorBoton3=clrBlue;

Boton boton1(Boton1,descripcion,100,50,colorBoton1);//boton 1
Boton boton2(Boton2,descripcion2,100,50,colorBoton2);
Boton boton3(Boton3,descripcion3,100,150,colorBoton3,100,50);

//+------------------------------------------------------------------------------------------------------------------------------+
//| Constructor de lineas (nombre del Boton, Color,precio,tiempo,bandera true si es linea vertical false si es linea horizontal) |
//+------------------------------------------------------------------------------------------------------------------------------+
string lineaV="lineav";
string linea1="linea1";
string linea2="linea2";

 datetime time=TimeCurrent();
 Linea lineaV1(lineaV,clrWhite,Ask,time,true);
 Linea lineaH(linea1,clrBlue,Ask,TimeCurrent(),false);
 Linea lineaH2(linea2,clrGreen,Bid,TimeCurrent(),false);

double equity,balance,_bid,_ask,_point ;
uint  barras_m1,barras_m5,barras_m15,barras_m30,barras_h1;
static long opens;
string come;
 //datetime time=D'2014.03.05 15:46:58';
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  //-----------------------inicia operaciones como marca el diagrama de flujos
 //  operaciones.operacionApertura(_point);
   int x=100;
   int y=100;
   boton1.setPosicion(x,y);
   //se configura el timer con 1 o mas segundos
    EventSetTimer(1); 
   
   //int colorC=4;
   //boton1.setColor(nombreBoton2,colorC);
  // boton1.getBoton();
   
  
  
 

    
   return(INIT_SUCCEEDED);
   
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  ObjectDelete(0,Boton1);
  ObjectDelete(0,Boton2);
  ObjectDelete(0,Boton3);
  ObjectDelete(0,linea1);
  ObjectDelete(0,linea2);
  ObjectDelete(0,lineaV);
 
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
bool ban;
boton1.getAccion(ban);
if (ban==1){
   Print("SE ACCIONO EL BOTON");
   sonido.setSonido(sonidoIinicio);
   operaciones.ArmarGrillaInicial(Dtot,dgrilla,vol,slippage,_point);  

}
boton2.getAccion(ban);
if(ban==1){
 operaciones.operacionEnvio();
}
boton3.getAccion(ban);
if(ban==1){
  sonido.setSonido(sonidoFin);
}



ObjLinea.HLineMove(linea1,Bid);
ObjLinea.HLineMove(linea2,Ask);
// ***************************************************************************
//    VARIABLES bid ask
// ===========================================================================
  // _bid     = NormalizeDouble(MarketInfo(Symbol(), MODE_BID), Digits); //define a lower price 
   //_ask     = NormalizeDouble(MarketInfo(Symbol(), MODE_ASK), Digits); //define an upper price
   


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
//if( (iBars(NULL,PERIOD_M1)>2) && (barras_m1!=iBars(NULL,PERIOD_M1))   ){       // Velas de 1 minutito !!!
//barras_m1 = iBars(NULL,PERIOD_M1);
//Print("M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1");

//controles.resumenOrdenes(balance);

//}

//controles.controlVelas(barras_m5,barras_m15,barras_m30,barras_h1);




  }
//+------------------------------------------------------------------+
void OnTimer()
{
 
   Print("TIMEEEEERRR");
 
}  