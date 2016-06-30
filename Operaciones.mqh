//+------------------------------------------------------------------+
//|                                                  Operaciones.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict

#include "Controles.mqh"
#include "Mg.mqh"
#include "Operaciones.mqh"
#include "Limites.mqh"



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Operaciones
  {
private:
   double _ask;
   double _bid;
   double _point;
   uint   Ticket;
   int    magicoactual;
 public:
   double arr_par[3];
   double arr_impar[3];
   double ab_par[3];
   double ab_impar[3];
public:
                     Operaciones();
                    ~Operaciones();
   int OrderOpenF(string &OO_symbol,
                                int &OO_cmd,
                                double &OO_volume,
                                double &OO_price,
                                int &OO_slippage,
                                double &OO_stoploss,
                                double &OO_takeprofit,
                                string &OO_comment,
                                int &OO_magic,
                                datetime OO_expiration,
                                color &OO_arrow_color);
   void operacionApertura(double &point);
   void cerrar_todo(int &magico);
   void cerrar_todo_pendiente(int &magico);
   void Operaciones::cerrar_Ordenes();
   void operacionE(string &mail);
   void arma_matrix(Mg &_mg);
   
   
  };
//----------------------------------------------------------------------
//                   zona de get y set
//----------------------------------------------------------------------
  
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
int Operaciones::OrderOpenF(string &OO_symbol,
                            int      &OO_cmd,
                            double   &OO_volume,
                            double   &OO_price,
                            int      &OO_slippage,
                            double   &OO_stoploss,
                            double   &OO_takeprofit,
                            string   &OO_comment,
                            int      &OO_magic,
                            datetime OO_expiration,
                            color    &OO_arrow_color)
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
         Print("The order is successfully opened.",result);
         Error = 0;                                //reset the error code to zero
         break;                                    //exit while
                                                   //errorCount =0;                          //reset the amount of attempts to zero
        }

     }
   return(result);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Operaciones::operacionE(string &mail)
  {
   string mensaje="El nombre de la compañia es: "+TerminalCompany()+
                  "; Nombre de la Terminal: "+TerminalInfoString(TERMINAL_NAME)+
                  "; TERMINAL_PATH = "+TerminalInfoString(TERMINAL_PATH)+
                  "; Numero de Cores: "+DoubleToString(TerminalInfoInteger(TERMINAL_CPU_CORES))+
                  "; Tipo de cuenta  (0-real, 1-demo, 2-contest): "+IntegerToString(SignalBaseGetInteger(SIGNAL_BASE_TRADE_MODE))+
                  "; Numero de operaciones: "+DoubleToString(SignalBaseGetInteger(SIGNAL_BASE_TRADES))+
                  "; Monitoreo de fecha de inicio: "+DoubleToString(SignalBaseGetInteger(SIGNAL_BASE_DATE_STARTED))+
                  "; apalancamiento cuenta: "+DoubleToString(SignalBaseGetInteger(SIGNAL_BASE_LEVERAGE))+
                  "; Beneficio en pips: "+DoubleToString(SignalBaseGetInteger(SIGNAL_BASE_PIPS))+
                  "; Saldo de la cuenta: "+DoubleToString(SignalBaseGetDouble(SIGNAL_BASE_BALANCE))+
                  "; capital de la cuenta: "+DoubleToString(SignalBaseGetDouble(SIGNAL_BASE_EQUITY))+
                  "; Retorno de la inversion: "+DoubleToString(SignalBaseGetDouble(SIGNAL_BASE_ROI));
   Shell(mail,mensaje);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// GESTION DE ORDENES: Cerrar todas las ordenes activas 
void Operaciones::cerrar_Ordenes()
{

int total = OrdersTotal();
bool result = true;
  for(int i=total-1;i>=0;i--)
  {

      int ordenselect=OrderSelect(i, SELECT_BY_POS);
      int type    = OrderType();
      
      
      if ( ( OrderSymbol()==Symbol())&& OrderComment()==comentario ) // si son las mias
      {

            // aca voy a tener que elejir las que sean de un canal determinado. No todas.

            switch(type)
            {
               //Close pending orders
               case OP_BUYLIMIT  : result = OrderDelete( OrderTicket() ); break;
               case OP_BUYSTOP   : result = OrderDelete( OrderTicket() ); break;
               case OP_SELLLIMIT : result = OrderDelete( OrderTicket() ); break;
               case OP_SELLSTOP  : result = OrderDelete( OrderTicket() ); break;
               case OP_BUY       : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );  break;
               case OP_SELL      : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );  break;  
            
            
            }  

      }
      if(result == false)
      {
      Print("cerrar_todo: Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
      Sleep(3000);
      }  

}
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// GESTION DE ORDENES: Cerrar todas las ordenes activas 
void Operaciones::cerrar_todo(int &magico)
  {

   int total=OrdersTotal();
   bool result=true;
   for(int i=total-1;i>=0;i--)
     {

      int ordenselect=OrderSelect(i,SELECT_BY_POS);
      int type=OrderType();

      if(( OrderSymbol()==Symbol()) && (OrderMagicNumber()==magico)) // si son las mias
        {

//         // aca voy a tener que elejir las que sean de un canal determinado. No todas.

         switch(type)
           {
            //Close pending orders
            case OP_BUYLIMIT  : {result = OrderDelete( OrderTicket() ); break;}
            case OP_BUYSTOP   : {result = OrderDelete( OrderTicket() ); break;}
            case OP_SELLLIMIT : {result = OrderDelete( OrderTicket() ); break;}
            case OP_SELLSTOP  : {result = OrderDelete( OrderTicket() ); break;}
            case OP_BUY       : {result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );  break;}
            case OP_SELL      : {result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );  break;}


           }
//
        }
      if(result==false)
        {
         Print("cerrar_todo: Order ",OrderTicket()," failed to close. Error:",GetLastError());
         Sleep(3000);
        }

     }
  }
// GESTION DE ORDENES: Cerrar todas las ordenes PENDIENTES
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Operaciones::cerrar_todo_pendiente(int &magico)
  {
   int total=OrdersTotal();
   bool result=true;
   for(int i=total-1;i>=0;i--)
     {
      int ordenselect=OrderSelect(i,SELECT_BY_POS);
      int type=OrderType();
      if(( OrderSymbol()==Symbol()) && (OrderMagicNumber()==magico)) // si son las mias
        {
         
         // aca voy a tener que elejir las que sean de un canal determinado. No todas.

         switch(type)
           {
            //Close pending orders
            case OP_BUYSTOP   : result = OrderDelete( OrderTicket() ); break;
            case OP_SELLSTOP  : result = OrderDelete( OrderTicket() ); break;
           }

        }
      if(result==false)
        {
         Print("Cerrar_todo_pendiente: Order ",OrderTicket()," failed to close. Error:",GetLastError());
         //Sleep(3000);
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Operaciones::arma_matrix(Mg &_mg)
  {
arr_impar[0]=_mg.getNivelS1();
arr_impar[1]=_mg.getNivelS2();
arr_impar[2]=_mg.getNivelS3();
arr_par[0]=_mg.getNivelS0();
arr_par[1]=_mg.getNivelS1();
arr_par[2]=_mg.getNivelS2();
Print("-------------Matrix S  S0=",_mg.getNivelS0()," S1=",_mg.getNivelS1()," S2=",_mg.getNivelS2(), " S3=",_mg.getNivelS3());
ab_impar[0]=_mg.getNivelI1();
ab_impar[1]=_mg.getNivelI2();
ab_impar[2]=_mg.getNivelI3();
ab_par[0]=_mg.getNivelI0();
ab_par[1]=_mg.getNivelI1();
ab_par[2]=_mg.getNivelI2();
Print("-------------Matrix S  I0=",_mg.getNivelI0()," I1=",_mg.getNivelI1()," I2=",_mg.getNivelI2(), " I3=",_mg.getNivelI3());
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
