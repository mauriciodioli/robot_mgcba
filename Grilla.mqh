//+------------------------------------------------------------------+
//|                                                       Grilla.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
extern string comentario="Flores-Strategy";   // Comentario
extern int      MagicN=314159;
#include "Operaciones.mqh"
#include "Controles.mqh"
#include "Mg.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Grilla
  {
private:
 double _point;
 double TechoCanal;
 double TechoCanalp;
 double pisoCanal;
 double pisoCanalp;
 bool canal_roto;
 int nivel;
public:
 int CanalActivo[10];
 int ticketsellstop[100];
 int ticketbuystop[100];
public:
                     Grilla();
                    ~Grilla();
                    //la declaracion de los objetos siempre tienen que tener distinto nombre que en la declaracion en la cabecera
                    void ArmarGrillaInicial(int &D, double &d, double &Vo, int&slippagee,int &magico,Mg &mg,Operaciones &ope);                    
                    double getTechoCanal();
                    int    getPisoCanal();
                    bool   getCanalRoto();
                    int    getCanalActivo();
                    void   setPoint();
                    double getPoint();
                    
  };
 bool Grilla::getCanalRoto(void){
  return canal_roto;
 }
 double Grilla::getTechoCanal(void){
  return TechoCanal;
 }
  int Grilla::getPisoCanal(void){
  return pisoCanal;
 }
 //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Grilla::setPoint()
  {
     _point = MarketInfo(Symbol(), MODE_POINT);
     EventSetTimer(5);                   // timer  
  }
 double Grilla::getPoint(void){
  return _point;
 }
  //----------------------------------------------------------------------
//                   métodos de Operaciones
//----------------------------------------------------------------------
//*********************************************************************************************************  
//******************************************Arma la Grilla inical *****************************************
//*********************************************************************************************************    
//*********************************************************************************************************  
//******************************************Arma la Grilla inical *****************************************
//********************************************************************************************************* 
//*********************************************************************************************************  
//******************************************Arma la Grilla inical *****************************************
//*********************************************************************************************************  
//*********************************************************************************************************  
//******************************************Arma la Grilla inical *****************************************
//*********************************************************************************************************  
 //       H,d,Vo,desliz, magicoinicial. 
//       Los limites los hace con magico+1. 
//       DEVUELVE: el magico actual, y el valor en CanalActivo[n]=1

void Grilla::ArmarGrillaInicial(int &D, double &d, double &Vol_in, int &slippagee, int &magico,Mg &mg,Operaciones &ope) // H,d,Vo
{
   nivel=0;
   int Nordenes = (int) (D/d) ;
   int NBuyLimit = Nordenes/2 ;
   int NSellLimit = Nordenes/2 ;
   datetime _ExpDate=0; //TimeCurrent()+600*60;      // 10 horas de caducidad. 
   CanalActivo[0]=1;
   double Vo = 0.5*Vol_in;
   Print("Grilla INI:   D: ",D,"  d: ",d,"  Nordenes:  ",Nordenes,"  NBuyLimit:  ",NBuyLimit,"  NSellLimit:  ",NSellLimit);
   
   
   // bucle de las BUY
   double buyPrice = NormalizeDouble(Ask , Digits);
   mg.setNivelS0(buyPrice);
   double buyTP    = NormalizeDouble(Ask + 10 * d *_point  ,Digits);
   double buySL    = 0;
   string symbol=Symbol();int OO_cmd=OP_BUY;color OO_arrow_color=Blue;
   ticketbuystop[0]=ope.OrderOpenF(symbol,OO_cmd,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
  // ticketbuystop[0]=OrderOpenF1(Symbol(),OP_BUY,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,magico,_ExpDate,Blue);

   _ask=Ask;
   for (int nivel=1; nivel<=NBuyLimit ; nivel++ ) // colocamos las Buy Stop
   {
   
   double nivelpip = nivel*d;
   
   buyPrice = NormalizeDouble(_ask + 10*nivelpip*_point      ,Digits);
   buyTP    = NormalizeDouble(_ask + 10*(nivelpip+d)*_point  ,Digits);
   buySL=0;
   //Print(" nivel :",   nivel," BUY nivelpip :",   nivelpip, "  BUY Price ",buyPrice ,"  BUY TP    ",buyTP    );
   symbol=Symbol();OO_cmd=OP_BUYSTOP;OO_arrow_color=Blue;
   ticketbuystop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
   //ticketbuystop[nivel]=    OrderOpenF1(Symbol(),OP_BUYSTOP,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,magico,_ExpDate,Blue);//}
   if (nivel==NBuyLimit){TechoCanal = buyTP;TechoCanalp=(nivelpip+d);Print(" TechoCanal:",TechoCanal); }
   
   
   }

     // ***** 3ro Coloco el BUY 2Vo
   buyPrice = TechoCanal ;       // 2Vo
   buyTP    = NormalizeDouble(_ask + (10*1.5*TechoCanalp)*_point    ,Digits);
   buySL    = NormalizeDouble(_ask + (10*0.5*TechoCanalp)*_point    ,Digits);
   symbol=Symbol();OO_cmd=OP_BUYSTOP;OO_arrow_color=Blue;double Vo1=(2*Vol_in);int magico1=(magico+1);
   ticketbuystop[nivel]=ope.OrderOpenF (symbol ,OO_cmd     ,Vo1 ,buyPrice ,slippagee,buySL,buyTP,comentario,magico1,_ExpDate,OO_arrow_color);
  // ticketbuystop[nivel]=    OrderOpenF1(Symbol(),OP_BUYSTOP,(2*Vol_in) ,buyPrice ,slippagee,buySL,buyTP,comentario,(magico+1),_ExpDate,Blue);//}
   mg.setNivelS1(buySL);
   mg.setNivelS2(buyPrice);
   mg.setNivelS3(buyTP);
  
    
   // ***** 1ro la SELL market
   double sellPrice = NormalizeDouble(Bid , Digits);
   mg.setNivelI0(sellPrice);
   double sellTP    = NormalizeDouble(Bid - 10 * d *_point  ,Digits);
   double sellSL    = 0;
   symbol=Symbol();OO_cmd=OP_BUYSTOP;OO_arrow_color=clrRed;
   ticketbuystop[0]=ope.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice ,slippagee,sellSL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
   //ticketsellstop[0]=   OrderOpenF(Symbol(),OP_SELL,Vo ,sellPrice,slippagee,sellSL,sellTP,comentario,magico,_ExpDate,clrRed);

   _bid=Bid;
   // ***** 2do bucle de las SELL stop
   for (int nivel=1; nivel<=NSellLimit ; nivel++ )// colocamos las sell Stop
   {
   
   double nivelpip = nivel*d;
   
   sellPrice  = NormalizeDouble( _bid - 10*nivelpip*_point      ,Digits);
   sellTP     = NormalizeDouble( _bid - 10*(nivelpip+d)*_point  ,Digits);
   symbol=Symbol();OO_cmd=OP_SELLSTOP;OO_arrow_color=clrRed;
   ticketbuystop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice ,slippagee,sellSL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
  // ticketbuystop[nivel]=   OrderOpenF1(Symbol(),OP_SELLSTOP,Vo ,sellPrice,slippagee,sellSL,sellTP,comentario,magico,_ExpDate,clrRed);
   //Print(" nivel :",   nivel," SELL nivelpip :",   nivelpip, "  SELL Price ",sellPrice ,"  SELL TP    ",sellTP  );
      
   if (nivel==NSellLimit){pisoCanal= sellTP  ;pisoCanalp=(nivelpip+d);Print(" PisoCanal:",pisoCanal); }
   }
   // ***** 3ro Coloco el SELL 2Vo
   sellPrice = pisoCanal;       // 2Vo
   sellTP    = NormalizeDouble(_bid - (10*1.5*pisoCanalp)*_point    ,Digits);
   sellSL    = NormalizeDouble(_bid - (10*0.5*pisoCanalp)*_point    ,Digits);
   //MagicN=31415901;
   symbol=Symbol();OO_cmd=OP_SELLSTOP;OO_arrow_color=clrRed;Vo1=(2*Vol_in); magico1=(magico+1);
   ticketbuystop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo1 ,sellPrice ,slippagee,sellSL,buyTP,comentario,magico1,_ExpDate,OO_arrow_color);
  // ticketbuystop[nivel]=   OrderOpenF1(Symbol(),OP_SELLSTOP,(2*Vol_in) ,sellPrice ,slippagee,sellSL,sellTP,comentario,(magico+1),_ExpDate,clrRed);//}
   mg.setNivelI1(sellSL);
   mg.setNivelI2(sellPrice);
   mg.setNivelI3(sellTP);  
   

   magicoactual=magico+1;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Grilla::Grilla()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Grilla::~Grilla()
  {
  }
//+------------------------------------------------------------------+
