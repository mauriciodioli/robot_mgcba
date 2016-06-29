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
#include "Boton.mqh"
#include "Linea.mqh"
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
                    void   resumenOrdenes(double &balanc,int magico);
                    void   controlVelas(Grilla &grillaa,uint &barras_m5,uint &barras_m15,uint &barras_m30,uint &barras_h1);
                    void   Shell(string &mail,string &parameters);
                    void   canalesPisoTecho(Grilla &_grilla1);
                    bool   limitesAlcanzados(Operaciones &o,Grilla &_grilla2,Mg &_mg1,Grilla* &vector[],Orden* &vectorOrden[],int &contador);
                    void   adaptarGrilla(Orden &orden, Grilla &_grilla3,Mg &mg);
                    void   iteraGeometria(Operaciones &opg,Grilla &grilla4,Orden* &vectorOrden[],Mg &m,bool &banderaEliminaObjetoVector);
                    double DameelPrecio(int ticket);
                    bool   se_llego_al_TP(int magico);
                    bool   SiEstaCerrada(int ticket);
                    bool   orden_abierta(int ticket);
                    bool   detectar_si_entro_buy(int magico);
                    bool   detectar_si_entro_sell(int magico);
                    void   RecalculoReposicionamientoPiso(double &piso,Grilla &grilla,Mg &mg);
                    void   RecalculoReposicionamientoTecho(double &techo,Grilla &grilla,Mg &mg);
                    bool   deleteGrilla(bool &banderaEliminaObjetoVector,int &contadorGrilla,int &i,Grilla* &vector[]);
            
                   
  };
//************************************************************************************************
//**********************************ELIMINA UN OBJETO GRILLA**************************************
//************************************************************************************************
bool Controles::deleteGrilla(bool &banderaEliminaObjetoVector,int &contadorGrilla,int &i,Grilla* &vector[]){
 
 if(banderaEliminaObjetoVector&&!vector[i].getEstadoGrilla()){
  
   
   if(i==0&&contadorGrilla==1){ 
   //if(i==0&&contadorGrilla==1||i==contadorGrilla-1&&!vector[i].getEstadoGrilla()){ 
   
      Print(" 1 if entraaaaaaaaaaaaaaaaaaaaa!!! i",i," contador ",contadorGrilla); 
      
       delete(vector[i]); contadorGrilla--;
              
       banderaEliminaObjetoVector=false;
       
       Print(" 1 if eliminoooooooooooooooooooooooooooooooo!!! i",i," contador ",contadorGrilla);           
      return true;
   }
  
  
   if(i==0&&contadorGrilla==2){ 
   Print(" 2 if entraaaaaaaaaaaaaaattttaaaaaa!!! i",i," contador ",contadorGrilla," grilla ",vector[i].getIdGrilla()); 
      vector[0]=vector[1]; 
      delete(vector[1]);
      
      contadorGrilla--;
      //if(i>0)i--;
     
      banderaEliminaObjetoVector=false;
      
      Print(" 2 if eliminoooooooooooooooooooooooooooooooo!!! i",i," contador ",contadorGrilla); 
      return true;
      }
   
   
   
   
   if(contadorGrilla>2&&contadorGrilla<contadorGrilla-1){
      Print(" 3 if eliminoooooooooooooooooooooooooooooooo!!! i",i," contador ",contadorGrilla);  
       for(int y=i;y<=contadorGrilla;y++)         
         vector[y]=vector[y+1]; 
       
       delete(vector[i+1]);contadorGrilla--;
       banderaEliminaObjetoVector=false;
       Print(" 3 if eliminoooooooooooooooooooooooooooooooo!!! i",i," contador ",contadorGrilla);
       return true; 
      }
   
  
      }//fin if bandera
      return false;
    }


//    Monitoreo del piso y techo del canal. (depues seran adaptativos)
//    PisoCanal, TechoCanal, son valores de precio. 
//    Se alcanzo el techo cuando BID cruza de - a + TechoCanal. O bien si salto la orden del techo.
//    Se alcanzo el piso  cuando ASK cruza de + a - PisoCanal.  O bien si salto la orden del piso.

//    OJOOOO SE DEBE DETECTAR SI ES QUE se violo el canal, pero tenemos dos ordenes en contra en vez de una.
//    en ese caso se altera la martingala. 
void Controles::canalesPisoTecho(Grilla &_grilla1){

if ( _grilla1.getCanalActivo()==1 ) {
     // aca se llama a adaptargrilla();  
    if ((Bid>_grilla1.getTechoCanal())||detectar_si_entro_buy(_grilla1.getMagicoActual()) ) {
       
       _grilla1.setCanal_techo(1);     
       _grilla1.setCanalActivoFlag(1);  
     
     }
    
    if ((Ask<_grilla1.getPisoCanal()) ||detectar_si_entro_sell(_grilla1.getMagicoActual())) {
       
       _grilla1.setCanal_piso(1);      
       _grilla1.setCanalActivoFlag(-1);
       
    
    }
    //Print("lllllego la grilla Ask ",Ask ," _grilla1.getPisoCanal() ",_grilla1.getPisoCanal()," getMagicoActual() ",_grilla1.getMagicoActual()," detectar_si_entro_sell(_grilla1.getMagicoActual()) ",detectar_si_entro_sell(_grilla1.getMagicoActual()));
    _grilla1.setCanalRoto(0);
    
    if (_grilla1.getCanal_techo()||_grilla1.getCanal_piso()){
       
       _grilla1.setCanalRoto(1);
       //Print("_grilla1.getCanalRoto()------------------------------------------------------------------------------- ",_grilla1.getIdGrilla());
       
       }
    
    
   }//if (  CanalActivo[0]==1  )

}
//+------------------------------------------------------------------+
//|                        Adaptar Grilla                            |
//+------------------------------------------------------------------+
void Controles::adaptarGrilla(Orden &orden, Grilla &_grilla3,Mg &mg){
if ( _grilla3.getCanalActivo()==1 ){ 
//Print("_grilla3.getCanalActivo() ",_grilla3.getCanalActivo());
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
   //  Print("La orden BUY #TICKET ",_grilla3.ticketbuystop[nb],"  Esta abierta. Corresponde cerrar SELL #TICKET ", _grilla3.ticketsellstop[(Nsells-nb)]);
      
    
   
      if (orden_abierta(_grilla3.getTicketbuystop(nb))){
         //listoBuys = 0;
        // Print("La orden BUY #TICKET ",_grilla3.ticketbuystop[nb],"  Esta abierta. Corresponde cerrar SELL #TICKET ", _grilla3.ticketsellstop[(Nsells-nb)]);
         orden.setAbiertabuyTicket(_grilla3.getTicketbuystop(nb));orden.setCerradasellTicket(_grilla3.getTicketsellstop((Nsells-nb)));
    
         // el TP de la orden ANTERIOR a la que tengo que cerrar es el nuevo PISO
         //double NuevoPiso = DameelPrecio(ticketsellstop[(Nsells-nb-1)]);
         NuevoPiso = DameelPrecio(_grilla3.getTicketsellstop((Nsells-nb)));
           //    Print("*********************************** NuevoPiso ***********************",NuevoPiso," grilla ",_grilla3.getIdGrilla());
           if( !SiEstaCerrada(_grilla3.getTicketsellstop((Nsells-nb))) )
            {  if  (OrderDelete(_grilla3.getTicketsellstop((Nsells-nb)), clrAquamarine)   )
                   {
                     // tengo q poner el s2 en el lugar del SELL que acabo de cerrar
                     RecalculoReposicionamientoPiso(NuevoPiso,_grilla3,mg);    // aca pasale el nuevo piso
                     //modificarS2(NuevoPiso);
                   }
                     else Print("error de OrderDelete458");
            }
         
         
         //NSellLimit = NSellLimit - 1;
         
         }
       //  else{listoBuys = 1;}
   
      if (orden_abierta(_grilla3.getTicketsellstop(ns))){
         //listoSells = 0 ;
         //Print("La orden SELL#TICKET ",ticketsellstop[ns], "    esta abierta. Corresponde cerrar BUY #TICKET ", ticketbuystop[(Nbuys-ns)]);
         orden.setAbiertasellTicket(_grilla3.getTicketsellstop(ns));orden.setCerradabuyTicket(_grilla3.getTicketbuystop((Nbuys-ns)));
         
         // el TP de la orden anterior a la que tengo que cerrar es el nuevo TECHO
         //double NuevoTecho = DameelPrecio(ticketbuystop[(Nbuys-ns-1)]);
         NuevoTecho = DameelPrecio(_grilla3.getTicketbuystop((Nbuys-ns)));
        //? Print("*********************************** NuevoTecho ***********************",NuevoTecho," grilla ",_grilla3.getIdGrilla()," magico actual ",_grilla3.getMagicoActual());
    
         if( !SiEstaCerrada(_grilla3.getTicketbuystop((Nbuys-ns))) )
            { if  (OrderDelete(_grilla3.getTicketbuystop((Nbuys-ns)), clrAquamarine)   )
                  {
                     // tengo q poner el B2 en el lugar del buy que acabo de cerrar
                     RecalculoReposicionamientoTecho(NuevoTecho,_grilla3,mg);
                     //modificarB2(NuevoTecho);
                  }
                     else Print("error de OrderDelete471");      
            
            }
         //NBuyLimit = NBuyLimit - 1;
         
         }
       //  else{listoSells = 1;}
   
     //}while((listoBuys&&listoSells)!=1);
     

   

   

 }
}
//-------------------------------------------------------------------------------------
//                            Limites Alcanzados
//-------------------------------------------------------------------------------------
bool Controles::limitesAlcanzados(Operaciones &o,Grilla &_grilla,Mg &_mg,Grilla* &vector[],Orden* &vectorOrden[],int &contador){
  
  if (_grilla.getCanalRoto()==1){  
      Print( " -------------------------------------------- LIMITE DEL CANAL ALCANZADO GRILLA: ",_grilla.getIdGrilla());
      
      int magico=_grilla.getMagicoActual()-1;
      int magicoactual=_grilla.getMagicoActual();
      o.cerrar_todo(magico); // cierre de las que quedaron pendientes. 
      o.cerrar_todo_pendiente(magicoactual);// La B2 o la S2 que quedo pendiente se cierra.
      
      
      
      _grilla.setCanalRoto(0);
     Print( " -------------------------------------------- STATUS CANAL GRILLA: ", _grilla.getIdGrilla());
      
      o.arma_matrix(_mg);//    arma los arreglos arr_impar   arr_par   ab_impar   ab_par
      
     //Print("Magico  actual  ... ",magicoactual );
     
     
     magicoactual=_grilla.armar_prox_paso(o,_grilla);//  esta incrementa CanalActivo[0] y magicoactual
     _grilla.setMagicoActual(magicoactual);
     
         //Sleep(10000);
      //grilla.lanzaGrilla(vector,vectorOrden,contador,_mg,o);//lanza grilla
      
   }
 return true;     

}
//+------------------------------------------------------------------+
//|                        iteraGeometria                            |
//+------------------------------------------------------------------+
void Controles::iteraGeometria(Operaciones &opg,Grilla &grilla,Orden* &vectorOrden[],Mg &m,bool &banderaEliminaObjetoVector){
    
  if (grilla.getCanalActivo()>1)   {        // aca comienza la iteracion de la geometria 
   //Print("idGrilla ",grilla.getIdGrilla(), " -------------------------------------------- MG CANAL: ",grilla.getCanalActivo()," magicoActual ",grilla.getMagicoActual());
   
   // Al entrar aca, esta vigente la B1 o la S1 y ya esta armado el paso 2
   //    Y el magico actual es el de la orden stop recien puesta
   //    Como 1ra forma de saber si salto la orden stop actual, o sea si paso al prox paso   
   if (detectar_si_entro_buy(grilla.getMagicoActual()) ||  detectar_si_entro_sell(grilla.getMagicoActual()))
   {
      int magicoActual=grilla.armar_prox_paso(opg,grilla);
      grilla.setMagicoActual(magicoActual);//  incrementa CanalActivo[0]
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
      //Print("Llego al TP ???                   actual  ...    grilla ",grilla.getIdGrilla()," grilla.getMagicoActual() ",grilla.getMagicoActual());
         
       if (se_llego_al_TP(grilla.getMagicoActual())){ Print("grilla ",grilla.getIdGrilla()," se_llego_al_TP(grilla.getMagicoActual() ",se_llego_al_TP(grilla.getMagicoActual())," magicoActual ",grilla.getMagicoActual());
           
            int magicoActual=grilla.getMagicoActual();
            opg.cerrar_todo_pendiente(magicoActual);
            int a=0;
            grilla.setCanalActivo(a); // se apaga el robot. Listo para empezar de nuevo.
            banderaEliminaObjetoVector=true;//condicion para eliminar grilla del vector de grillas
            grilla.setEstadoGrilla(false);//estado en true para eliminar la grilla esta
           
            Print("***********************************************************");
            Print("* TERMINO GRILLA N°.... ",grilla.getIdGrilla()," volumen operado ",grilla.getVolumen());
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
double Controles::DameelPrecio(int ticket)
{
int tiiket = ticket;

   if (OrderSelect(tiiket,SELECT_BY_TICKET))
   {  
      return(OrderOpenPrice());
      
   }
   else  Print("DameelPrecio:  OrderSelect dio error _______ ",GetLastError());
    
return (0);
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
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
         if(OrderSymbol()==Symbol() && (OrderMagicNumber()==magico || OrderMagicNumber()==(magico-1)) && OrderComment()==comentario)
           {
            // si entro aca son mis ordenes
            string tipo;
            if(OrderType()==OP_BUY){tipo="Buy";Ordenes_Buy++;}            // entraron, estan en curso
            if(OrderType()==OP_SELL){tipo="Sell";Ordenes_Sell++;}          // entraron, estan en curso

             //Print(" magico ",magico," ticket ", OrderTicket()," Ordenes_Buy ",Ordenes_Buy," Ordenes_Sell ",Ordenes_Sell);

            //if (OrderProfit()!=0)
          
            //Print ( "_____    Orden Ticket: ",OrderTicket()," Tipo:",tipo,"  Vol Lotes:",OrderLots(),
            //"   _Gan u$s: ",OrderProfit(), "   magico ",magico , 
            //(( OrderProfit() ) / OrderLots() / MarketInfo( OrderSymbol(), MODE_TICKVALUE )/10),
            //"   TakeProfit: ",OrderTakeProfit()," Tipo:",tipo);
           
           if ((Ordenes_Buy>Ordenes_Buy2)||(Ordenes_Sell>Ordenes_Sell2)){
           devolver=0;            
           }else{
           devolver=1;//Print("LISTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
           //Print("OrderMagicNumber()",OrderMagicNumber(),"=",magico);
        
           }
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
void Controles::resumenOrdenes(double &balanc,int magico)
{
      //static int  N_ordenes_ant=0;
   int  N_ordenes=OrdersTotal();
   int  Ordenes_Buy=0, Ordenes_Sell=0, Ordenes_Buy_s=0, Ordenes_Sell_s=0, Ordenes_Buy_l=0, Ordenes_Sell_l=0;

   for(int cnt=0; cnt<N_ordenes; cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
      {
        // if(OrderSymbol()==Symbol() && OrderMagicNumber()==magico && OrderComment()==comentario)
           if(OrderSymbol()==Symbol() && OrderComment()==comentario)      
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
            "__ Balance:",balanc,
            "__ Magico:",balanc);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Controles::controlVelas(Grilla &grillaa,uint &barra_m5,uint &barra_m15,uint &barra_m30,uint &barra_h1)
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
    //Print(" OrdersTotal  ",OrdersTotal()," order magic number ",OrderMagicNumber()," == ",magico," magico");
 
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
//Print("detectar_si_entro_buy OrderMagicNumber()  ",grilla.getMagicoInicial(),"=",magico,"magico que entra en buy-------------- ",magico);
int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
   int ordenselect=OrderSelect(i, SELECT_BY_POS);
  
  if ( ( OrderSymbol()==Symbol()) && (  OrderMagicNumber() == magico) )
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

bool Controles::SiEstaCerrada(int ticket)
{
int tiiket = ticket;


 if(OrderSelect(tiiket,SELECT_BY_TICKET,MODE_HISTORY))
    {
     datetime ctm=OrderCloseTime();    // SI ESTO NO ES CERO, LA orden ya fue cerrada.
     if(ctm>0) return (1);
     
     //Print("SiEstaCerrada   ************************** ",ctm);
     
    }
  else  Print("OrderSelect539 dio error _______ ",GetLastError());
  
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
//****************************************************************************************
//****************************************************************************************
void Controles::RecalculoReposicionamientoPiso(double &piso,Grilla &grilla,Mg &mg){
//TechoCanal, PisoCanal; // valores de techo y piso del canal globales
double nuevopiso = piso;
static double control1a, control2a;

   // Actualizamos valor global de piso. El techo no se altera.
   grilla.setPisoCanal(nuevopiso);
   
double   diametro = grilla.getTechoCanal()-nuevopiso ;
double   diametrop = diametro/(10*grilla.getPoint()) ;  // diametro en pip ?????
   
   // Actualizamos valor global del diametro. El techo no se altera.
   //Diametro = (int) diametrop ;
int dist_tp_sl_pip = (int) grilla.getDiametro()/4;
  
Print("********* RecalculoReposicionamiento PISO ************ ",nuevopiso);
Print("********* RecalculoReposicionamiento diametro  ************ ",diametrop);
Print("********* RecalculoReposicionamiento dist_tp_sl_pip  ************ ",dist_tp_sl_pip);
Print("********* RecalculoReposicionamiento GRILLA ************ ",grilla.getIdGrilla());
   // RECALCULO PARA B2       <<<<<<<<<    esta se modifica solamente SL TP
   double buyPrice = grilla.getTechoCanal();
   double buyTP    = NormalizeDouble(grilla.getTechoCanal() +  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   double buySL    = NormalizeDouble(grilla.getTechoCanal() -  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   Print("RECALCULO PARA B2   buyPrice ",buyPrice," buyTP ",buyTP," buySL ",buySL);
 
   if (control1a!=(buyPrice+buySL+buyTP)){// para que solo la llame si los valores son distintos
   int tiketb2=grilla.getTicketB2();
   if (OrderModify(  tiketb2 ,      buyPrice,       buySL,    buyTP,    0,  clrHotPink) ){
     Print("magico actual ",grilla.getMagicoActual()," id grilla ",grilla.getIdGrilla()," tiketb2 ",tiketb2);}
   else{
   Print("magico actual ",grilla.getMagicoActual()," id grilla ",grilla.getIdGrilla()," tiketb2 ",tiketb2);
   Print("RecalculoReposicionamientoPiso: RECALCULO PARA B2       <<<<<<<<<    esta se modifica solamente SL TP error de OrderModify582 :", GetLastError());}
   
   }
   control1a=buyPrice+buySL+buyTP;
   double normalizedouble=NormalizeDouble(grilla.getTechoCanal() -  2*dist_tp_sl_pip *10* grilla.getPoint()    ,Digits);
   mg.setNivelS0(normalizedouble);
   mg.setNivelS1(buySL);
   mg.setNivelS2(buyPrice);
   mg.setNivelS3(buyTP);
   
   
   // RECALCULO PARA S2       <<<<<<<<<    esta se modifica posicion
   double sellPrice = grilla.getPisoCanal();
   double sellTP    = NormalizeDouble(grilla.getPisoCanal() -  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   double sellSL    = NormalizeDouble(grilla.getPisoCanal() +  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   Print("RECALCULO PARA S2   sellPrice ",sellPrice," sellTP ",sellTP," sellSL ",sellSL);

   if (control2a!=(sellPrice+sellSL+sellTP)){// para que solo la llame si los valores son distintos
   int tikets2=grilla.getTicketS2();
   if (OrderModify(   tikets2,      sellPrice,       sellSL,    sellTP,    0,  clrHotPink) ){}
   else{Print("RecalculoReposicionamientoPiso: RECALCULO PARA S2       <<<<<<<<<    esta se modifica posicion error de OrderModify596 :", GetLastError());}
   
   }
   control2a = sellPrice+sellSL+sellTP;
   normalizedouble=NormalizeDouble(grilla.getPisoCanal() +  2*dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   mg.setNivelI0(normalizedouble);
   mg.setNivelI1(sellSL);
   mg.setNivelI2(sellPrice);
   mg.setNivelI3(sellTP);







}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Controles::RecalculoReposicionamientoTecho(double &techo,Grilla &grilla,Mg &mg){

//TechoCanal, PisoCanal; // valores de techo y piso del canal globales
double nuevotecho = techo;
static double control1a, control2a;

   // Actualizamos valor global de piso. El piso no se altera.
   grilla.setTechoCanal(nuevotecho);
   
double   diametro = nuevotecho-grilla.getPisoCanal();
double   diametrop = diametro/(10*grilla.getPoint()) ;  

   // Actualizamos valor global del diametro. El techo no se altera.
   //Diametro = (int) diametrop ;
      grilla.setDiametro((int) diametrop);
int dist_tp_sl_pip = (int) grilla.getDiametro()/4;


   

Print("********* RecalculoReposicionamiento GRILLA ************ ",grilla.getIdGrilla());   
Print("********* RecalculoReposicionamiento TECHO ************ ",nuevotecho);
//Print("********* RecalculoReposicionamiento diametro  ************ ",diametro);
Print("********* RecalculoReposicionamiento diametro  ************ ",diametrop);
Print("********* RecalculoReposicionamiento dist_tp_sl_pip  ************ ",dist_tp_sl_pip);

   // RECALCULO PARA B2       <<<<<<<<<    esta se modifica posicion
   double buyPrice = grilla.getTechoCanal();
   double buyTP    = NormalizeDouble(grilla.getTechoCanal() +  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   double buySL    = NormalizeDouble(grilla.getTechoCanal() -  dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   Print("RECALCULO PARA B2   buyPrice ",buyPrice," buyTP ",buyTP," buySL ",buySL);
   
   if (control1a!=(buyPrice+buySL+buyTP)){// para que solo la llame si los valores son distintos
   int tiketB2=grilla.getTicketB2();
   if (OrderModify(   tiketB2,      buyPrice,       buySL,    buyTP,    0,  clrHotPink) ){}
   else{
        Print("magico actual ",grilla.getMagicoActual()," id grilla ",grilla.getIdGrilla()," tiketb2 ",tiketB2);
        Print("RecalculoReposicionamientoPiso: RECALCULO PARA B2       <<<<<<<<<    esta se modifica posicion error de OrderModify617 :", GetLastError());}
   
   }
   control1a=buyPrice+buySL+buyTP;
   double normalizedouble=NormalizeDouble(grilla.getTechoCanal() -  2*dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   mg.setNivelS0(normalizedouble);
   mg.setNivelS1(buySL);
   mg.setNivelS2(buyPrice);
   mg.setNivelS3(buyTP);
   
   
   // RECALCULO PARA S2       <<<<<<<<<    esta se modifica solamente SL TP
   double sellPrice = grilla.getPisoCanal();
   double sellTP    = NormalizeDouble(grilla.getPisoCanal() -  dist_tp_sl_pip *10*  grilla.getPoint(),Digits);
   double sellSL    = NormalizeDouble(grilla.getPisoCanal() +  dist_tp_sl_pip *10*  grilla.getPoint(),Digits);
   Print("RECALCULO PARA S2   sellPrice ",sellPrice," sellTP ",sellTP," sellSL ",sellSL);

   if (control2a!=(sellPrice+sellSL+sellTP)){// para que solo la llame si los valores son distintos
   int tikets2=grilla.getTicketS2();
   if (OrderModify(   tikets2,      sellPrice,       sellSL,    sellTP,    0,  clrHotPink) ){}
   else{Print("RecalculoReposicionamientoPiso: RECALCULO PARA S2       <<<<<<<<<    esta se modifica solamente SL TP error de OrderModify655 :", GetLastError());}

   }
   control2a = sellPrice+sellSL+sellTP;
   normalizedouble=NormalizeDouble(grilla.getPisoCanal() +  2*dist_tp_sl_pip *10* grilla.getPoint(),Digits);
   mg.setNivelI0(normalizedouble);
   mg.setNivelI1(sellSL);
   mg.setNivelI2(sellPrice);
   mg.setNivelI3(sellTP);



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
