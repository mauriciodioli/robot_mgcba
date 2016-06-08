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
#include "Grilla.mqh"
#include "Mg.mqh"
#include "Orden.mqh"
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
 

public:
                     Controles();
                    ~Controles();
                    void resumenOrdenes(double &balanc);
                    void controlVelas(Grilla &grillaa,uint &barras_m5,uint &barras_m15,uint &barras_m30,uint &barras_h1);
                    void Shell(string &mail,string &parameters);
                    void canalesPisoTecho(Grilla &_grilla1);
                    bool limitesAlcanzados(Operaciones &o,Grilla &_grilla2,Mg &_mg1,double &Vol);
                    void adaptarGrilla(Orden &orden, Grilla &_grilla3);
                    void iteraGeometria(Operaciones &opg,Grilla &grilla4);
                    bool se_llego_al_TP(int magico);
                    bool orden_abierta(int ticket);
                    bool detectar_si_entro_buy(int magico);
                    bool detectar_si_entro_sell(int magico);
            
                   
  };
 


//    Monitoreo del piso y techo del canal. (depues seran adaptativos)
//    PisoCanal, TechoCanal, son valores de precio. 
//    Se alcanzo el techo cuando BID cruza de - a + TechoCanal. O bien si salto la orden del techo.
//    Se alcanzo el piso  cuando ASK cruza de + a - PisoCanal.  O bien si salto la orden del piso.

//    OJOOOO SE DEBE DETECTAR SI ES QUE se violo el canal, pero tenemos dos ordenes en contra en vez de una.
//    en ese caso se altera la martingala. 
void Controles::canalesPisoTecho(Grilla &_grilla1){


  if ( _grilla1.CanalActivo[0]==1 ) {
    
   // aca se llama a adaptargrilla();      
    if ((Bid>_grilla1.getTechoCanal())||detectar_si_entro_buy(_grilla1.getMagicoActual()) ) {_grilla1.setCanal_techo(1);_grilla1.CanalActivoflag[0]=1;}
    if ((Ask<_grilla1.getPisoCanal()) ||detectar_si_entro_sell(_grilla1.getMagicoActual())) {_grilla1.setCanal_piso(1);_grilla1.CanalActivoflag[0]=-1;}
   
    _grilla1.setCanalRoto(0);
    
    if (_grilla1.getCanal_techo()||_grilla1.getCanal_piso())_grilla1.setCanalRoto(1);
    
    
   }//if (  CanalActivo[0]==1  )

}
//+------------------------------------------------------------------+
//|                        Adaptar Grilla                            |
//+------------------------------------------------------------------+
void Controles::adaptarGrilla(Orden &orden, Grilla &_grilla3){
if ( _grilla3.CanalActivo[0]==1 ){ 
   static int nb=1,ns=1;
   int   ticketb=0, tickets=0;
   int Nbuys , Nsells ; // uno mas porque debe incluir a las B2, S2.
   double NuevoPiso, NuevoTecho;
   
   // este bucle de prueba recorre todos los elementos de la grilla inicial, 
   // y muestra sus tickets. 
   // Las ordenes market iniciales esta en el indice cero del array.
   // Las ordenes de la grilla estan en indice=1 en adelante hasta el penultimo.
   // El ultimo elemento del arreglo contiene los ticket de b2, s2.
            /*
   for (nb=0, ns=0; nb<=Nbuys || ns<=Nsells ; nb++,ns++ )
   {
   ticketb=ticketbuystop[nb];
   tickets=ticketsellstop[ns];
   Print ("Ind BUY: ",nb,"  ticketbuystop ___ ",ticketb,"          Ind SELL: ",ns,"      ticketsellstop ___ ",tickets);
   }
            */
         



   // el calculo de si se abre tal orden se debe deletear tal orden opuesta

   // ticketbuystop [Nbuys]         es B2
   // ticketsellstop[Nsells]        es S2
   // ticketbuystop [NBuyLimit]     es Bx del techo
   // ticketsellstop[NSellLimit]    es Sx del piso
   // ticketbuystop [1]             B1
   // ticketsellstop[1]             S1
   // ticketbuystop [0]             B0
   // ticketsellstop[0]             S0
   //bool listoBuys = 0,listoSells = 0 ;
   //do{
   

   Nbuys = _grilla3.getNBuyLimit()+1; Nsells = _grilla3.getNSellLimit()+1 ; // uno mas porque debe incluir a las B2, S2.
   // 1 reviso las ordenes de la grilla de adentro hacia afuera
   if (nb<=Nbuys) nb++;if (ns<=Nsells) ns++;
   if (nb>_grilla3.getNBuyLimit()) nb=1;if (ns>_grilla3.getNSellLimit()) ns=1;
     Print("La orden ordeneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee BUY #TICKET ",_grilla3.ticketbuystop[nb],"  Esta abierta. Corresponde cerrar SELL #TICKET ", _grilla3.ticketsellstop[(Nsells-nb)]);
//      
   
   
      if (orden_abierta(_grilla3.ticketbuystop[nb])){
         //listoBuys = 0;
         Print("La orden ordeneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee BUY #TICKET ",_grilla3.ticketbuystop[nb],"  Esta abierta. Corresponde cerrar SELL #TICKET ", _grilla3.ticketsellstop[(Nsells-nb)]);
//         AbiertabuyTicket=ticketbuystop[nb];CerradasellTicket=ticketsellstop[(Nsells-nb)];
//         
//         // el TP de la orden ANTERIOR a la que tengo que cerrar es el nuevo PISO
//         //double NuevoPiso = DameelPrecio(ticketsellstop[(Nsells-nb-1)]);
//         NuevoPiso = DameelPrecio(ticketsellstop[(Nsells-nb)]);
//         if( !SiEstaCerrada(ticketsellstop[(Nsells-nb)]) )
//            {  if  (OrderDelete(ticketsellstop[(Nsells-nb)], clrAquamarine)   )
//                   {
//                     // tengo q poner el s2 en el lugar del SELL que acabo de cerrar
//                     RecalculoReposicionamientoPiso(NuevoPiso);    // aca pasale el nuevo piso
//                     //modificarS2(NuevoPiso);
//                   }
//                     else Print("error de OrderDelete458");
//            }
//         
//         
//         //NSellLimit = NSellLimit - 1;
//         
         }
         //else{listoBuys = 1;}
   
//      if (orden_abierta(ticketsellstop[ns])){
//         //listoSells = 0 ;
//         //Print("La orden SELL#TICKET ",ticketsellstop[ns], "    esta abierta. Corresponde cerrar BUY #TICKET ", ticketbuystop[(Nbuys-ns)]);
//         AbiertasellTicket=ticketsellstop[ns];CerradabuyTicket=ticketbuystop[(Nbuys-ns)];
//         
//         // el TP de la orden anterior a la que tengo que cerrar es el nuevo TECHO
//         //double NuevoTecho = DameelPrecio(ticketbuystop[(Nbuys-ns-1)]);
//         NuevoTecho = DameelPrecio(ticketbuystop[(Nbuys-ns)]);
//         if( !SiEstaCerrada(ticketbuystop[(Nbuys-ns)]) )
//            { if  (OrderDelete(ticketbuystop[(Nbuys-ns)], clrAquamarine)   )
//                  {
//                     // tengo q poner el B2 en el lugar del buy que acabo de cerrar
//                     RecalculoReposicionamientoTecho(NuevoTecho);
//                     //modificarB2(NuevoTecho);
//                  }
//                     else Print("error de OrderDelete471");      
//            
//            }
//         //NBuyLimit = NBuyLimit - 1;
//         
//         }
         //else{listoSells = 1;}
   
     //}while((listoBuys&&listoSells)!=1);
     

   

   

 }
}
//-------------------------------------------------------------------------------------
//                            Limites Alcanzados
//-------------------------------------------------------------------------------------
bool Controles::limitesAlcanzados(Operaciones &o,Grilla &_grilla,Mg &_mg,double &Vol){

  if (_grilla.getCanalRoto()==1){  
      Print( " -------------------------------------------- LIMITE DEL CANAL ALCANZADO");
      
      int magico=_grilla.getMagicoActual()-1;
      int magicoactual=_grilla.getMagicoActual();
      o.cerrar_todo(magico); // cierre de las que quedaron pendientes. 
      o.cerrar_todo_pendiente(magicoactual);// La B2 o la S2 que quedo pendiente se cierra.
      
      
      
      
      _grilla.setCanalRoto(0);
     Print( " -------------------------------------------- STATUS CANAL: ");
      
      o.arma_matrix(_mg);//    arma los arreglos arr_impar   arr_par   ab_impar   ab_par
      
     //Print("Magico  actual  ... ",magicoactual );
     magicoactual=_grilla.armar_prox_paso(o,_grilla,Vol);//  esta incrementa CanalActivo[0] y magicoactual
     _grilla.setMagicoActual(magicoactual);
     //Print("Magico actual  ... ",magicoactual );
         //Sleep(10000);
         
   }
 return true;     

}
//+------------------------------------------------------------------+
//|                        iteraGeometria                            |
//+------------------------------------------------------------------+
void Controles::iteraGeometria(Operaciones &opg,Grilla &grilla4){


   int magicoActual;
   if (grilla4.CanalActivo[0]>1)   {        // aca comienza la iteracion de la geometria 
   
  // Print( " -------------------------------------------- MG CANAL: ",grilla4.CanalActivo[0]);
   // Al entrar aca, esta vigente la B1 o la S1 y ya esta armado el paso 2
   //    Y el magico actual es el de la orden stop recien puesta
   //    Como 1ra forma de saber si salto la orden stop actual, o sea si paso al prox paso   
   
   //Print("detectando si entro la orden STOP actual  ... ");
   
   if (detectar_si_entro_buy(grilla4.getMagicoActual()) ||  detectar_si_entro_sell(grilla4.getMagicoActual()))
   {
   
      //Print("ALERT Entro nuevo nivel de MG. **************************************************"); 
      magicoActual=grilla4.armar_prox_paso(opg,grilla4,vol);
      grilla4.setMagicoActual(magicoActual);//  incrementa CanalActivo[0]
   
   }
   else
   {
      
      // detectar_llego al beneficio cero
      
      // consultando el B
      //equity = AccountEquity();
      //balance = AccountBalance();
      
      //    bool se_llego_al_BeneficioCero (magicoactual)

      //o viendo si se toco el TP de la orden vigente
      //Print("detectando si entro la orden STOP actual  ...    NO");
      //Print("Llego al TP ???                   actual  ...    ");
      
      if (se_llego_al_TP(grilla4.getMagicoActual())){
            magicoActual=grilla4.getMagicoActual();
            opg.cerrar_todo_pendiente(magicoActual);
            grilla4.CanalActivo[0]=0; // se apaga el robot. Listo para empezar de nuevo.
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            Print("* Llego al TP y al B=0 Listo para empezar de nuevo   ....  ");
            Print("***********************************************************");
            // automatizar
           
         }
         else
         {//Print("Llego al TP ???                   actual  ...  NO");
         }
      
      //si se toco el TP de la orden vigente y el B<0 dar un mensage de error
        
      // si se llego al exito, lanzar el trailing stop
      
      
      
   
   }

   //Print( " -------------------------------------------- MG CANAL: ",CanalActivo[0]);
   
   }//if (CanalActivo[0]>1)
  
 } 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Controles::se_llego_al_TP(int magico){
int Ordenes_Buy=0, Ordenes_Sell=0, Ordenes_Buy2=0, Ordenes_Sell2=0;
int  N_ordenes=OrdersTotal();
bool devolver=0;

//Print("antes del for   N_ordenes",N_ordenes);
   for(int cnt=0; cnt<N_ordenes; cnt++)
     {
      //Print("dentro del for");
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
         //Print("OrderSelect");
         if(OrderSymbol()==Symbol() && (OrderMagicNumber()==magico || OrderMagicNumber()==(magico-1)) && OrderComment()==comentario)
           {
            //Print("ultimo if ");
            // si entro aca son mis ordenes
            string tipo;
            if(OrderType()==OP_BUY){tipo="Buy";Ordenes_Buy++;}            // entraron, estan en curso
            if(OrderType()==OP_SELL){tipo="Sell";Ordenes_Sell++;}          // entraron, estan en curso
            
            //if (OrderProfit()!=0)
            /*
            Print ( "_____    Orden Ticket: ",OrderTicket()," Tipo:",tipo,"  Vol Lotes:",OrderLots(),
            "   _Gan u$s: ",OrderProfit(), "   _Gan pip: ", 
            (( OrderProfit() ) / OrderLots() / MarketInfo( OrderSymbol(), MODE_TICKVALUE )/10),
            "   TakeProfit: ",OrderTakeProfit());
            */
           if ((Ordenes_Buy>Ordenes_Buy2)||(Ordenes_Sell>Ordenes_Sell2))
           devolver=0;//Print("NO LISTOOOOO");
           else
           devolver=1;//Print("LISTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
            
           }//if2
           }//if1
           }//for




Ordenes_Buy2=Ordenes_Buy; Ordenes_Sell2=Ordenes_Sell;



   //if (     (Bid>buy_TP_actual) || (Ask<sell_TP_actual)    )   return(1);
   //else
   //return(0);
   
   return(devolver);
   

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
void Controles::controlVelas(Grilla &grillaa,uint &barra_m5,uint &barra_m15,uint &barra_m30,uint &barra_h1)
  {
      if( (iBars(NULL,PERIOD_M5)>2) && (barra_m5!=iBars(NULL,PERIOD_M5))   ){       // Velas de 5 minutito !!!
barra_m5 = iBars(NULL,PERIOD_M5);
double mg=MathPow(2,(grillaa.CanalActivo[0]-1));
if (mg>1)
Print( " --------- n=",grillaa.CanalActivo[0],"------------------MG Actual  2^n=",MathPow(2,(grillaa.CanalActivo[0]-1)));
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
bool Controles::detectar_si_entro_sell(int magico)
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
bool Controles::detectar_si_entro_buy(int magico)
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
bool Controles::orden_abierta(int ticket){
int tiiket = ticket;

if (tiiket>0){
 if(OrderSelect(tiiket,SELECT_BY_TICKET,MODE_HISTORY))
    {
     datetime ctm=OrderCloseTime();    // SI ESTO NO ES CERO, LA orden ya fue cerrada.
     if(ctm>0) return (0);
    }
  else  Print("OrderSelect566 dio error _______ ",GetLastError(), "ticket",tiiket);


   
   if (OrderSelect(tiiket,SELECT_BY_TICKET,MODE_TRADES))
   {  
      if (OrderType()==OP_BUY)   return (1);
      if (OrderType()==OP_BUYSTOP)   return (0);
      if (OrderType()==OP_SELL)   return (1);
      if (OrderType()==OP_SELLSTOP)   return (0);
   }
   else  Print("OrderSelect577 dio error _______ ",GetLastError());
    
    
    }
return (0);
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
