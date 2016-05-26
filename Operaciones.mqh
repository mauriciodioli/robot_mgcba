//+------------------------------------------------------------------+
//|                                                  Operaciones.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
extern string comentario="Flores-Strategy";   // Comentario
extern int      MagicN=314159;
#include "Controles.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Operaciones
  {
private:
 double _ask;
 double _bid;
 
public:
                     Operaciones();
                    ~Operaciones();
                    void operacionE(string &mail);
                    void operacionApertura(double &_point);
                    void ArmarGrillaInicial(int &D, double &d, double &Vo, int&slippagee, double &_pointt);
  };
//+----------------------------------------------------------------------------------------------------------------------+
//+----------------------------------------------------------------------------------------------------------------------+
//+----------------------------------------------------------------------------------------------------------------------+
//| The function opens or sets an order                                                                                  |
//| symbol      - symbol, at which a deal is performed.                                                                  |
//| cmd         - a deal (may be equal to any of the deal values).                                                       |
//| volume      - amount of lots.                                                                                        |
//| price       - Open price.                                                                                            |
//| slippage    - maximum price deviation for market buy or sell orders.                                                 |
//| stoploss    - position close price when an unprofitability level is reached (0 if there is no unprofitability level).|
//| takeprofit  - position close price when a profitability level is reached (0 if there is no profitability level).     |
//| comment     - order comment. The last part of comment can be changed by the trade server.                            |
//| magic       - order magic number. It can be used as a user-defined ID.                                               |
//| expiration  - pending order expiration time.                                                                         |
//| arrow_color - open arrow color on a chart. If the parameter is absent or equal to CLR_NONE,                          |
//|               the open arrow is not displayed on a chart.                                                            |
//+----------------------------------------------------------------------------------------------------------------------+
int OrderOpenF(string     OO_symbol,
               int        OO_cmd,
               double     OO_volume,
               double     OO_price,
               int        OO_slippage,
               double     OO_stoploss,
               double     OO_takeprofit,
               string     OO_comment,
               int        OO_magic,
               datetime   OO_expiration,
               color      OO_arrow_color)
  {
   int      result      = -1;    //result of opening an order
   int      Error       = 0;     //error when opening an order
   int      attempt     = 0;     //amount of performed attempts
   int      attemptMax  = 3;     //maximum amount of attempts
   bool     exit_loop   = false; //exit the loop
   string   lang=TerminalInfoString(TERMINAL_LANGUAGE);  //trading terminal language, for defining the language of the messages
   double   stopllvl=NormalizeDouble(MarketInfo(OO_symbol,MODE_STOPLEVEL)*MarketInfo(OO_symbol,MODE_POINT),Digits);  //minimum stop loss/ take profit level, in points
                                                                                                                     //the module provides safe order opening. 
//--- check stop orders for buying
   if(OO_cmd==OP_BUY || OO_cmd==OP_BUYLIMIT || OO_cmd==OP_BUYSTOP)
     {
      double tp = (OO_takeprofit - OO_price)/MarketInfo(OO_symbol, MODE_POINT);
      double sl = (OO_price - OO_stoploss)/MarketInfo(OO_symbol, MODE_POINT);
      if(tp>0 && tp<=stopllvl)
        {
         OO_takeprofit=OO_price+stopllvl+2*MarketInfo(OO_symbol,MODE_POINT);
        }
      if(sl>0 && sl<=stopllvl)
        {
         OO_stoploss=OO_price -(stopllvl+2*MarketInfo(OO_symbol,MODE_POINT));
        }
     }
//--- check stop orders for selling
   if(OO_cmd==OP_SELL || OO_cmd==OP_SELLLIMIT || OO_cmd==OP_SELLSTOP)
     {
      double tp = (OO_price - OO_takeprofit)/MarketInfo(OO_symbol, MODE_POINT);
      double sl = (OO_stoploss - OO_price)/MarketInfo(OO_symbol, MODE_POINT);
      if(tp>0 && tp<=stopllvl)
        {
         OO_takeprofit=OO_price -(stopllvl+2*MarketInfo(OO_symbol,MODE_POINT));
        }
      if(sl>0 && sl<=stopllvl)
        {
         OO_stoploss=OO_price+stopllvl+2*MarketInfo(OO_symbol,MODE_POINT);
        }
     }
//--- while loop
   while(!exit_loop)
     {
      result=OrderSend(OO_symbol,OO_cmd,OO_volume,OO_price,OO_slippage,OO_stoploss,OO_takeprofit,OO_comment,OO_magic,OO_expiration,OO_arrow_color); //attempt to open an order using the specified parameters
      //--- if there is an error when opening an order
      if(result<0)
        {
         Error = GetLastError();                                     //assign a code to an error
         switch(Error)                                               //error enumeration
           {                                                         //order closing error enumeration and an attempt to fix them
            case  2:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  Sleep(3000);                                       //3 seconds of delay
                  RefreshRates();
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt=0;                                         //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case  3:
               RefreshRates();
               exit_loop = true;                                     //exit while
               break;                                                //exit switch   
            case  4:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  Sleep(3000);                                       //3 seconds of delay
                  RefreshRates();
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case  5:
               exit_loop = true;                                     //exit while
               break;                                                //exit switch   
            case  6:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  Sleep(5000);                                       //3 seconds of delay
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case  8:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  Sleep(7000);                                       //3 seconds of delay
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case 64:
               exit_loop = true;                                     //exit while
               break;                                                //exit switch
            case 65:
               exit_loop = true;                                     //exit while
               break;                                                //exit switch
            case 128:
               Sleep(3000);
               RefreshRates();
               continue;                                             //exit switch
            case 129:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  Sleep(3000);                                       //3 seconds of delay
                  RefreshRates();
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case 130:
               exit_loop=true;                                       //exit while
               break;
            case 131:
               exit_loop = true;                                     //exit while
               break;                                                //exit switch
            case 132:
               Sleep(10000);                                         //sleep for 10 seconds
               RefreshRates();                                       //update data
               //exit_loop = true;                                   //exit while
               break;                                                //exit switch
            case 133:
               exit_loop=true;                                       //exit while
               break;                                                //exit switch
            case 134:
               exit_loop=true;                                       //exit while
               break;                                                //exit switch
            case 135:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  RefreshRates();
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case 136:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;                                 //define one more attempt
                  RefreshRates();
                  break;                                             //exit switch
                 }
               if(attempt==attemptMax)
                 {
                  attempt = 0;                                       //reset the amount of attempts to zero 
                  exit_loop = true;                                  //exit while
                  break;                                             //exit switch
                 }
            case 137:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;
                  Sleep(2000);
                  RefreshRates();
                  break;
                 }
               if(attempt==attemptMax)
                 {
                  attempt=0;
                  exit_loop=true;
                  break;
                 }
            case 138:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;
                  Sleep(1000);
                  RefreshRates();
                  break;
                 }
               if(attempt==attemptMax)
                 {
                  attempt=0;
                  exit_loop=true;
                  break;
                 }
            case 139:
               exit_loop=true;
               break;
            case 141:
               Sleep(5000);
               exit_loop=true;
               break;
            case 145:
               exit_loop=true;
               break;
            case 146:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;
                  Sleep(2000);
                  RefreshRates();
                  break;
                 }
               if(attempt==attemptMax)
                 {
                  attempt=0;
                  exit_loop=true;
                  break;
                 }
            case 147:
               if(attempt<attemptMax)
                 {
                  attempt=attempt+1;
                  OO_expiration=0;
                  break;
                 }
               if(attempt==attemptMax)
                 {
                  attempt=0;
                  exit_loop=true;
                  break;
                 }
            case 148:
               exit_loop=true;
               break;
            default:
               Print("Error: ",Error);
               exit_loop=true; //exit while 
               break;          //other options 
           }
        }
      //--- if no errors detected
      else
        {
         Print("The order is successfully opened.", result);
         Error = 0;                                //reset the error code to zero
         break;                                    //exit while
         //errorCount =0;                          //reset the amount of attempts to zero
        }
        
      }
   return(result);
  }
  
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
 
void Operaciones::ArmarGrillaInicial(int &D, double &d, double &Vo, int &slippagee, double &_pointt ) // H,d,Vo
{

   int Nordenes = (int) (D/d) ;
   int NBuyLimit = Nordenes/2 ;
   int NSellLimit = Nordenes/2 ;
   datetime _ExpDate=0; //TimeCurrent()+600*60;      // 10 horas de caducidad. 
   

   Print("Grilla INI:   D: ",D,"  d: ",d,"  Nordenes:  ",Nordenes,"  NBuyLimit:  ",NBuyLimit,"  NSellLimit:  ",NSellLimit);
   
   
   // bucle de las BUY
   double buyPrice = NormalizeDouble(Ask , Digits);
   double buyTP    = NormalizeDouble(Ask + 10 * d *_pointt  ,Digits);
   double buySL    = 0;
   OrderOpenF(Symbol(),OP_BUY,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,MagicN,_ExpDate,Blue);

   _ask=Ask;
   
   for (int nivel=1; nivel<=NBuyLimit ; nivel++ ) // colocamos las Buy Stop
   {
   
   double nivelpip = nivel*d;
   
   buyPrice = NormalizeDouble(_ask + 10*nivelpip*_pointt      ,Digits);
   buyTP    = NormalizeDouble(_ask + 10*(nivelpip+d)*_pointt  ,Digits);
   //buySL=NormalizeDouble(_bid-StopLoss*_point,Digits);
   
   Print(" nivel :",   nivel," BUY nivelpip :",   nivelpip, "  BUY Price ",buyPrice ,"  BUY TP    ",buyTP    );
   
   OrderOpenF(Symbol(),OP_BUYSTOP,Vo ,buyPrice ,slippagee,buySL,buyTP,comentario,MagicN,_ExpDate,Blue);//}
   
   
   }

  
   // bucle de las SELL
   double sellPrice = NormalizeDouble(Bid , Digits);
   double sellTP    = NormalizeDouble(Bid - 10 * d *_pointt  ,Digits);
   double sellSL    = 0;
   OrderOpenF(Symbol(),OP_SELL,Vo ,sellPrice,slippagee,sellSL,sellTP,comentario,MagicN,_ExpDate,clrRed);

   _bid=Bid;
   for (int nivel=1; nivel<=NSellLimit ; nivel++ )// colocamos las sell Stop
   {
   
   double nivelpip = nivel*d;
   
   sellPrice  = NormalizeDouble( _bid - 10*nivelpip*_pointt      ,Digits);
   sellTP     = NormalizeDouble( _bid - 10*(nivelpip+d)*_pointt  ,Digits);
   
   Print(" nivel :",   nivel," SELL nivelpip :",   nivelpip, "  SELL Price ",sellPrice ,"  SELL TP    ",sellTP  );
   
   //if (nivel!=0){
   OrderOpenF(Symbol(),OP_SELLSTOP,Vo ,sellPrice,slippagee,sellSL,sellTP,comentario,MagicN,_ExpDate,clrRed);//}
   //if (nivel==0){}
   }

   
   





}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Operaciones::operacionApertura(double &_pointt)
  {
     _pointt   = MarketInfo(Symbol(), MODE_POINT);
     EventSetTimer(5);                   // timer  
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Operaciones::operacionE(string &mail){
 string mensaje="El nombre de la compañia es: "+TerminalCompany()+
 "; Nombre de la Terminal: "+TerminalInfoString(TERMINAL_NAME)+
 "; TERMINAL_PATH = "+TerminalInfoString(TERMINAL_PATH)+
 "; Numero de Cores: "+TerminalInfoInteger(TERMINAL_CPU_CORES)+
 "; Tipo de cuenta  (0-real, 1-demo, 2-contest): "+SignalBaseGetInteger(SIGNAL_BASE_TRADE_MODE)+
 "; Numero de operaciones: "+SignalBaseGetInteger(SIGNAL_BASE_TRADES)+
 "; Monitoreo de fecha de inicio: "+SignalBaseGetInteger(SIGNAL_BASE_DATE_STARTED)+
 "; apalancamiento cuenta: "+SignalBaseGetInteger(SIGNAL_BASE_LEVERAGE)+
 "; Beneficio en pips: "+SignalBaseGetInteger(SIGNAL_BASE_PIPS)+
 "; Saldo de la cuenta: "+SignalBaseGetDouble(SIGNAL_BASE_BALANCE)+
 "; capital de la cuenta: "+SignalBaseGetDouble(SIGNAL_BASE_EQUITY)+
 "; Retorno de la inversion: "+SignalBaseGetDouble(SIGNAL_BASE_ROI);
   Shell(mail,mensaje);   
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Operaciones::Operaciones()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Operaciones::~Operaciones()
  {
  }
//+------------------------------------------------------------------+
