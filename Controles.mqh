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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Controles
  {
private:
 double a;
public:
                     Controles();
                    ~Controles();
                    void resumenOrdenes(double &balanc);
                    void controlVelas(uint &barras_m5,uint &barras_m15,uint &barras_m30,uint &barras_h1);
                    
  };
void Controles::resumenOrdenes(double &balanc)
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
