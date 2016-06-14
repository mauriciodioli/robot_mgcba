//+------------------------------------------------------------------+
//|                                                       prueba.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, LPAHFT"
#property link      "http://www.mql4.com"
#property version   "1.0"
#property strict
#include <WinUser32.mqh>  
#include "ConfiguracionInicial.mqh"
#include "Limites.mqh"
#include "Controles.mqh"
#include "Operaciones.mqh"
#include "Boton.mqh"
#include "Linea.mqh"
#include "Sonido.mqh" 
#include "Orden.mqh"
#include "Grilla.mqh"
#include "Mg.mqh"
ConfiguracionInicial configIni;
Limites limites;
Controles controles;
Operaciones operaciones;
Linea ObjLinea;
Sonido sonido;
Orden orden;
Mg mg1;
Grilla vector[];
//extern double   vol=0.1;  //       Volumen inicial
//extern double   dgrilla=2;    // (d) grilla inicial
//extern int      Dtot=50;    //    (D)  grilla inicial
//extern int      slippage=10;               // Deslizamiento maximo permitido.
//static int magicoini=MagicN;
//+------------------------------------------------------------------------------------+
//| Se crea una grilla                                                                 |
//+------------------------------------------------------------------------------------+

//+------------------------------------------------------------------------------------+
//| Sonidos Se declara un obj sonido el cual tiene los distintos metodos para sonidos  |
//+------------------------------------------------------------------------------------+
string sonidoIinicio="ini.wav";
string sonidoFin="stops.wav";
//+------------------------------------------------------------------------------------+
//| Constructor de botones (nombre del Boton, Descripcion,X,Y,Color,X tamaño,Y tamaño) |
//+------------------------------------------------------------------------------------+
string Boton1="Boton1";
string descripcion="_INICIO_";
color colorBoton1=clrGreen;

string Boton2="Boton2";
string descripcion2="_APAGADO_";
color colorBoton2=clrRed;

string Boton3="Boton3";
string descripcion3="_AUTO_";
color colorBoton3=clrBlue;

string Boton4="Boton4";
string descripcion4="I/O";
color colorBoton4=clrMaroon;

Boton boton1(Boton1,descripcion,10,50,colorBoton1);//boton 1
Boton boton2(Boton2,descripcion2,10,50,colorBoton2);
Boton boton3(Boton3,descripcion3,10,150,colorBoton3,100,50);
Boton boton4(Boton4,descripcion4,10,200,colorBoton4,100,50);

//+------------------------------------------------------------------------------------------------------------------------------+
//| Constructor de lineas (nombre del Boton, Color,precio,tiempo,bandera true si es linea vertical false si es linea horizontal) |
//+------------------------------------------------------------------------------------------------------------------------------+
string linea0="linea0";
string linea1="linea1";
string linea2="linea2";
int numeroLienas=2;

 datetime time=TimeCurrent();
 Linea lineaV1(linea0,clrWhite,Ask,time,true);
 Linea lineaH(linea1,clrBlue,Ask,TimeCurrent(),false);
 Linea lineaH2(linea2,clrLawnGreen,Bid,TimeCurrent(),false);

double equity,balance;
uint  barras_m1,barras_m5,barras_m15,barras_m30,barras_h1;
static long opens;
bool banderaIniciaDeNuevo=false,automatico=false;
int CanalActivoflag[10],contadorGrilla=0;   // 10 flags de si un canal esta activo
string come;
string email="madioli26@hotmail.com";

 //datetime time=D'2014.03.05 15:46:58';
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  //-----------------------inicia operaciones como marca el diagrama de flujos
   int x=10;   int y=100;
   boton1.setPosicion(x,y); 
   operaciones.operacionE(email);
   ArrayResize(vector,1000);
   //se configura el timer con 1 o mas segundos
   EventSetTimer(1);
  
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
  ObjectDelete(0,Boton4);
  ObjLinea.delet(numeroLienas);
 
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
//       H,d,Vo,desliz, magicoinicial. 
//       Los limites los hace con magico+1. 
//       DEVUELVE: el magico actual, y el valor en CanalActivo[n]=1
  Print("SE ACCIONO EL BOTON INICIO");
  if(banderaIniciaDeNuevo){
    boton1.setDescripcion(Boton2,"_APAGADO_");
    banderaIniciaDeNuevo=false;
    colorBoton1=clrLightSlateGray;
    boton1.setColor(Boton1,colorBoton1);
    boton1.setDescripcion(Boton1,":)");
    sonido.setSonido(sonidoIinicio);    
    time=TimeCurrent();
    numeroLienas++;
    string nom="linea"+IntegerToString(numeroLienas);
    Linea line(nom,clrYellow,Ask,time,true);
   }
                               
}

boton2.getAccion(ban);
if(ban==1){
 boton2.setDescripcion(Boton2,":(");
 operaciones.cerrar_Ordenes();
 banderaIniciaDeNuevo=true;
 boton1.setDescripcion(Boton1,"_INICIO_");
 colorBoton1=clrGreen;
 boton1.setColor(Boton1,colorBoton1);
}

boton3.getAccion(ban);
if(ban==1){
   //sonido.setSonido(sonidoIinicio);
  if(automatico){
      automatico=false;
      boton3.setDescripcion(Boton3,"_AUTO_");
    
   }else{
         automatico=true;
         banderaIniciaDeNuevo=false;
         boton3.setDescripcion(Boton3,":)");
         boton1.setDescripcion(Boton1,":)");
         colorBoton1=clrLightSlateGray;
         boton1.setColor(Boton1,colorBoton1);
        }
}

boton4.getAccion(ban);
if(ban==1){
 Print("SE ACCIONO EL BOTON I/O");
  vector[contadorGrilla].setIdGrilla(contadorGrilla);
  vector[contadorGrilla].setPoint();
  vector[contadorGrilla].ArmarGrillaInicial(mg1,operaciones);
  contadorGrilla++;
}
//---------------------Mueve lineas-------------------------------------------
ObjLinea.HLineMove(linea1,Bid);
ObjLinea.HLineMove(linea2,Ask);
//----------------------------------------------------------------------------
for(int i=0;i<contadorGrilla;i++){
 // Monitoreo del piso y techo del canal. (depues seran adaptativos)
   controles.canalesPisoTecho(vector[i]);
// Adapta la grilla
   controles.adaptarGrilla(orden,vector[0]);
// Limites alcanzados
   controles.limitesAlcanzados(operaciones,vector[0],mg1,vol);
// itera Geometria
   controles.iteraGeometria(operaciones,vector[0],banderaIniciaDeNuevo,automatico,boton1,linea0,mg1); 

}












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
if( (iBars(NULL,PERIOD_M1)>2) && (barras_m1!=iBars(NULL,PERIOD_M1))   ){       // Velas de 1 minutito !!!
barras_m1 = iBars(NULL,PERIOD_M1);
//Print("M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1M1");

//controles.resumenOrdenes(balance);

}
for(int i=0;i<contadorGrilla;i++)
controles.controlVelas(vector[i],barras_m5,barras_m15,barras_m30,barras_h1);


    

  }
//+------------------------------------------------------------------+
void OnTimer()
{
 
   Print("TIMEEEEERRR");
 
}  

  