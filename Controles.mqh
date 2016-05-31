//+------------------------------------------------------------------+
//|                                                    Controles.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
#include "Operaciones.mqh"
#import "shell32.dll"
  int ShellExecuteW(int hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, int nShowCmd);
#import

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Controles
  {
private:
 double a;
 bool Canal_roto;

public:
                     Controles();
                    ~Controles();
                    void resumenOrdenes(double &balanc);
                    void controlVelas(uint &barras_m5,uint &barras_m15,uint &barras_m30,uint &barras_h1);
                    void Shell(string &mail,string &parameters);
                    void canalesPisoTecho(Operaciones &o,bool &canal);
                    bool limitesAlcanzados(Operaciones &o,bool &canal,double &Vol);
                    
  };
  
//-------------------------------------------------------------------------------------
//                            Limites Alcanzados
//-------------------------------------------------------------------------------------
/*bool Controles::limitesAlcanzados(Operaciones &o,bool &canal,double &Vol){
  if (Canal_roto==1){
      Print( " -------------------------------------------- LIMITE DEL CANAL ALCANZADO");
      int magico=o.getMagicoActual()-1;
      int magicoactual=o.getMagicoActual();
      o.cerrar_todo(magico); // cierre de las que quedaron pendientes. 
      o.cerrar_todo_pendiente(magicoactual);// La B2 o la S2 que quedo pendiente se cierra.
      
      
      
      
      Canal_roto=0;
     Print( " -------------------------------------------- STATUS CANAL: ",o.CanalActivo[0]);
      
      o.armar_matrix();//    arma los arreglos arr_impar   arr_par   ab_impar   ab_par
      
      //Print("Magico actual  ... ",magicoactual );
      magicoactual = o.armar_prox_paso(magicoactual,vol);//  esta incrementa CanalActivo[0] y magicoactual
      //Print("Magico actual  ... ",magicoactual );
      
      //Sleep(10000);
      
   }
}
//    Monitoreo del piso y techo del canal. (depues seran adaptativos)
//    PisoCanal, TechoCanal, son valores de precio. 
//    Se alcanzo el techo cuando BID cruza de - a + TechoCanal. O bien si salto la orden del techo.
//    Se alcanzo el piso  cuando ASK cruza de + a - PisoCanal.  O bien si salto la orden del piso.

//    OJOOOO SE DEBE DETECTAR SI ES QUE se violo el canal, pero tenemos dos ordenes en contra en vez de una.
//    en ese caso se altera la martingala. 
void Controles::canalesPisoTecho(Operaciones &o,bool &canal){
  if ( o.CanalActivo[0]==1 ) {
   
   
   // aca se llama a adaptargrilla();
   
   bool Canal_techo=0 ;if ((Bid>o.getTechoCanal())||detectar_si_entro_buy(o.getMagicoActual())   ) {Canal_techo=1;o.CanalActivoflag[0]=1;}
   bool Canal_piso=0  ;if ((Ask<o.getPisoCanal()) ||detectar_si_entro_sell(o.getMagicoActual())) {Canal_piso=1;CanalActivoflag[0]=-1;}
   
   canal=0;
   if (                 Canal_techo || Canal_piso              ) canal=1;
   }//if (  CanalActivo[0]==1  )

}
*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*void Controles::resumenOrdenes(double &balanc)
{
      //static int  N_ordenes_ant=0;
   int  N_ordenes=OrdersTotal();
   int  Ordenes_Buy=0, Ordenes_Sell=0, Ordenes_Buy_s=0, Ordenes_Sell_s=0, Ordenes_Buy_l=0, Ordenes_Sell_l=0;

   for(int cnt=0; cnt<N_ordenes; cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicN && OrderComment()==comentario)
           {
            // si entro aca son mis ordenes
            string tipo;
            if(OrderType()==OP_BUYSTOP){tipo="Bstop";Ordenes_Buy_s++;}      // pendientes
            if(OrderType()==OP_SELLSTOP){tipo="Sstop";Ordenes_Sell_s++;}    // pendientes
            if(OrderType()==OP_BUY){tipo="Buy";Ordenes_Buy++;}            // entraron, estan en curso
            if(OrderType()==OP_SELL){tipo="Sell";Ordenes_Sell++;}          // entraron, estan en curso
            if(OrderType()==OP_BUYLIMIT){Ordenes_Buy_l++;}            // entraron, estan en curso
            if(OrderType()==OP_SELLLIMIT){Ordenes_Sell_l++;}          // entraron, estan en curso
            
            if (OrderProfit()!=0)
            Print ( "_____    Orden Ticket: ",OrderTicket()," Tipo:",tipo,
            "   _Gan u$s: ",OrderProfit(), "   _Gan pip: ", 
            ( OrderProfit() ) / OrderLots() / MarketInfo( OrderSymbol(), MODE_TICKVALUE )/10);
            
           }//if2
           }//if1
           }//for

            Print("  >>>>>>>>>>>>>>>>>>>>>>>>>>>> ORD Vigentes:",N_ordenes, 
            //"__ Blimit:",Ordenes_Buy_l,
            "__ Bstop:",Ordenes_Buy_s,
            "__ BUY:",Ordenes_Buy,
            //"__ Slimit:",Ordenes_Sell_l,
            "__ Sstop:",Ordenes_Sell_s,
            "__ SELL:",Ordenes_Sell,
            "__ Balance:",balanc);
}
*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Controles::controlVelas(uint &barra_m5,uint &barra_m15,uint &barra_m30,uint &barra_h1)
  {
      if( (iBars(NULL,PERIOD_M5)>2) && (barra_m5!=iBars(NULL,PERIOD_M5))   ){       // Velas de 5 minutito !!!
barra_m5 = iBars(NULL,PERIOD_M5);
//Print("M5M5M5M5M5M5M5M5M5M5M5M5");
}

if( (iBars(NULL,PERIOD_M15)>2) && (barra_m15!=iBars(NULL,PERIOD_M15))   ){       // Velas de 15 minutito !!!
barra_m15 = iBars(NULL,PERIOD_M15);
//Print("M15M15M15M15M15");
}

if( (iBars(NULL,PERIOD_M30)>2) && (barra_m30!=iBars(NULL,PERIOD_M30))   ){       // Velas de 30 minutito !!!
barra_m30 = iBars(NULL,PERIOD_M30);
//Print("M30M30M30");
}

if( (iBars(NULL,PERIOD_H1)>2) && (barra_h1!=iBars(NULL,PERIOD_H1))   ){       // Velas de 60 minutito !!!
barra_h1 = iBars(NULL,PERIOD_H1);
//Print("H1");
}
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool detectar_si_entro_sell(int magico)
{
int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
   int ordenselect=OrderSelect(i, SELECT_BY_POS);
   if ( ( OrderSymbol()==Symbol()) && ( OrderMagicNumber() == magico) )
   { // si son las mias
   if (OrderType()==OP_SELLSTOP) return(0);
   if (OrderType()==OP_SELL) return(1);
   }
   
}
return(0);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool detectar_si_entro_buy(int magico)
{
int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
   int ordenselect=OrderSelect(i, SELECT_BY_POS);
   if ( ( OrderSymbol()==Symbol()) && ( OrderMagicNumber() == magico) )
   { // si son las mias
   if (OrderType()==OP_BUYSTOP) return(0);
   if (OrderType()==OP_BUY) return(1);
   }
   
}
return(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Shell(string mail,string &parameters){
    string file="cmd.exe";
    string smtp="smtp-mail.outlook.com";
    string puerto="587";
    string contrasenia="mauricio0";
    string protocolo="ssl";
    string asunto="Robot_mgcba";
    #define DEFDIRECTORY TerminalPath()
    #define OPERATION "open"       
    #define SW_HIDE             0   
    #define SW_SHOWNORMAL       1
    #define SW_NORMAL           1
    #define SW_SHOWMINIMIZED    2
    #define SW_SHOWMAXIMIZED    3
    #define SW_MAXIMIZE         3
    #define SW_SHOWNOACTIVATE   4
    #define SW_SHOW             5
    #define SW_MINIMIZE         6
    #define SW_SHOWMINNOACTIVE  7
    #define SW_SHOWNA           8
    #define SW_RESTORE          9
    #define SW_SHOWDEFAULT      10
    #define SW_FORCEMINIMIZE    11
    #define SW_MAX              11
    string strParams =+ " /c "+
    "senditquiet.exe -s "+smtp+
    "  -port "+puerto+
    " -u "+mail+
    " -protocol "+protocolo+
    " -p "+contrasenia+
    " -f "+mail+
    " -t "+mail+
    " -subject \""+asunto+
    "\" -body \"";
    int r=ShellExecuteW(0, OPERATION, file,strParams+parameters+"\"", DEFDIRECTORY,SW_HIDE);
    //if (r <= 32){   Alert("Shell failed: ", r); return(false);  }

    return(true);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Controles::Controles()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Controles::~Controles()
  {
  }
//+------------------------------------------------------------------+
