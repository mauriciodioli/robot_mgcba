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
Mg mg1;
Grilla *vector[];
Grilla grilla;
Orden  *vectorOrden[];
Orden orden;

//+------------------------------------------------------------------------------------+
//| Sonidos Se declara un obj sonido el cual tiene los distintos metodos para sonidos  |
//+------------------------------------------------------------------------------------+
//string sonidoIinicio="ini.wav";
string sonidoIinicio="ok.wav";
string sonidoFin="stops.wav";
//+------------------------------------------------------------------------------------+
//| Constructor de botones (nombre del Boton, Descripcion,X,Y,Color,X tamaño,Y tamaño) |
//+------------------------------------------------------------------------------------+
string Boton1="Boton1";
string descripcion="_INICIO_";
color colorBoton1=clrGreen;

string Boton2="Boton2";
string descripcion2="_RESET_";
color colorBoton2=clrRed;

string Boton3="Boton3";
string descripcion3="_AUTO_";
color colorBoton3=clrBlue;

string Boton4="Boton4";
string descripcion4="I/O";
color colorBoton4=clrMaroon;

Boton boton1(Boton1,descripcion,40,50,colorBoton1);//boton 1
Boton boton2(Boton2,descripcion2,40,50,colorBoton2);
Boton boton3(Boton3,descripcion3,40,150,colorBoton3,100,50);
Boton boton4(Boton4,descripcion4,40,200,colorBoton4,100,50);

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
bool banderaIniciaBoton=true,automatico=false,banderaEliminaObjetoVector=false,banderaAgregaGrilla=false;
int CanalActivoflag[10],contadorGrilla=0;   // 10 flags de si un canal esta activo
string come;
string email="madioli26@hotmail.com";

 //datetime time=D'2014.03.05 15:46:58';
//+------------------------------------------------------------------+
//| Expert initialization function               |||||||||||||||||||||
//+------------------------------------------------------------------+
int OnInit()
  {
  
  //-----------------------inicia operaciones como marca el diagrama de flujos
   int x=40;   int y=100;
   boton1.setPosicion(x,y); 
   //boton1.setColorFuente(clrGreen);
   //boton2.setColorFuente(clrRed);
   //boton3.setColorFuente(clrBlue);
   operaciones.operacionE(email);
   ArrayResize(vector,10000);
   ArrayResize(vectorOrden,100000); 
   for(int t=0;t<1;t++){   
   //grilla.lanzaGrilla(vector,contadorGrilla,mg1,operaciones);
    grilla.lanzaGrilla(vector,vectorOrden,contadorGrilla,mg1,operaciones);
    Print("inicia grilla N°",vector[t].getIdGrilla());
    }
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
boton1.getAccion(ban);//INICIO
if (ban==1){
//       H,d,Vo,desliz, magicoinicial. 
//       Los limites los hace con magico+1. 
//       DEVUELVE: el magico actual, y el valor en CanalActivo[n]=1
  Print("SE ACCIONO EL BOTON INICIO");
  if(banderaIniciaBoton){
    boton1.setDescripcion(Boton2,"_RESET_");
    banderaIniciaBoton=true;
    colorBoton1=clrLightSlateGray;
    boton1.setColor(Boton1,colorBoton1);
    boton1.setDescripcion(Boton1,":)");
    sonido.setSonido(sonidoIinicio);
    grilla.lanzaGrilla(vector,vectorOrden,contadorGrilla,mg1,operaciones);
    time=TimeCurrent();
    numeroLienas++;
    string nom="linea"+IntegerToString(numeroLienas);
    Linea line(nom,clrYellow,Ask,time,true);
   }
                               
}

boton2.getAccion(ban);//RESET
if(ban==1){
banderaEliminaObjetoVector=true;
 boton2.setDescripcion(Boton2,"-->");
 operaciones.cerrar_Ordenes();
 banderaIniciaBoton=true;
 boton1.setDescripcion(Boton1,"_INICIO_");
 colorBoton1=clrGreen;
 boton1.setColor(Boton1,colorBoton1);
 //ArrayFree(vector);ArrayResize(vector,1000); 
}

boton3.getAccion(ban);//AUTO
if(ban==1){
   sonido.setSonido(sonidoIinicio);
  if(automatico){
      automatico=false;
      boton3.setDescripcion(Boton3,"_AUTO_");
    
   }else{
         automatico=true;
         banderaIniciaBoton=false;
         boton3.setDescripcion(Boton3,":)");
         boton1.setDescripcion(Boton1,":)");
         colorBoton1=clrLightSlateGray;
         boton1.setColor(Boton1,colorBoton1);
        }
}

boton4.getAccion(ban);//I/O
if(ban==1){
 Print("SE ACCIONO EL BOTON I/O");
  grilla.lanzaGrilla(vector,vectorOrden,contadorGrilla,mg1,operaciones);
  //grilla.lanzaGrilla(vector,contadorGrilla,mg1,operaciones);
  time=TimeCurrent();
  numeroLienas++;
  string nom="linea"+IntegerToString(numeroLienas);
  Linea line(nom,clrYellow,Ask,time,true);
}
   
  
//----------------------------------------------------------------------------
for(int i=0;i<contadorGrilla;i++){// scan de todas las grillas !!!
//---------------------Mueve lineas-------------------------------------------
//
if(vector[i].getEstadoGrilla()){ //entro si la grilla existe
      ObjLinea.HLineMove(linea1,vector[i].getTechoCanal());
      ObjLinea.HLineMove(linea2,vector[i].getPisoCanal());
      //Print(i," posicion del vector contadorGrilla ",contadorGrilla," vector[contadorGrilla].setIdGrilla ",vector[i].getIdGrilla());
       // Monitoreo del piso y techo del canal. (depues seran adaptativos)
        controles.canalesPisoTecho(vector[i]);
      // Adapta la grilla
        controles.adaptarGrilla(orden,vector[i],mg1);
      // Limites alcanzados
        controles.limitesAlcanzados(operaciones,vector[i],mg1,vector,vectorOrden,contadorGrilla);      
      // itera Geometria        
        controles.iteraGeometria(operaciones,vector[i],vectorOrden,mg1,banderaEliminaObjetoVector);
         
               
      // ***************************************************************************
      //    INICIA GRILLA AUTOMAICAMENTE
      // ===========================================================================  
      if(!vector[i].getEstadoGrilla())
         grilla.lanzaGrillaAutomatica(vector,vectorOrden,contadorGrilla,banderaAgregaGrilla,mg1,operaciones,banderaIniciaBoton,automatico,boton1,linea0);
  }//fin de primer if
}


// ***************************************************************************
// ELIMINA OBJETO DEL ARRAY DE OBJETOS NO ELIMINA BIEN LOS OBJETOS DE LA GRILLA, METODO DESABILITADO
// ===========================================================================
//for(int j=contadorGrilla-1;j>=0;j--){
//elimina objeto
  //Print("entra j",j," contador ",contadorGrilla);
  //controles.deleteGrilla(banderaEliminaObjetoVector,contadorGrilla,j,vector);  
  
 //}
  

  
  






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

 //controles.resumenOrdenes(balance,vector[0].getMagicoActual());

}






   //controles.controlVelas(vector[0],barras_m5,barras_m15,barras_m30,barras_h1);
}

//+------------------------------------------------------------------+
void OnTimer()
{
 
   Print("TIMEEEEERRR");
 
}  

  