//+------------------------------------------------------------------+
//|                                                       Grilla.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
//*********************************************************************
//--------------------------Configuracion de parametros-----------
//*********************************************************************
extern string  comentario="Flores-Strategy";   // Comentario
extern int     MagicN=10000;//MagicN=314159;
extern double  gap=2;    //      gap: gap entre operaciones
extern double  vol=0.1;  //       Volumen inicial
extern double  dgrilla=2;    // (d) grilla inicial
extern int     Dtot=50;    //    (D)  grilla inicial
extern int     slippage=10;               // Deslizamiento maximo permitido.
static int     magicoini=MagicN;

#include "Controles.mqh"
#include "Operaciones.mqh"
#include "Mg.mqh"
#include "Grilla.mqh"
#include "Orden.mqh"
#include "Linea.mqh"
#include "Boton.mqh"
Orden ordenn;
Linea ObjLineaa;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Grilla
  {
private:
 int     idGrilla;
 Mg      martGala;
 double  _point;
 double  _ask;
 double  _bid;
 double  Diametro;
 double  TechoCanal;
 double  TechoCanalp;
 double  pisoCanal;
 double  pisoCanalp;
 int     magicoactual;
 int     magicoinicial;
 double  nivelpip;
 bool    Canal_techo;
 bool    Canal_piso;
 bool    canal_roto;
 int     nivel;
 int     Nordenes;       // total de ordenes grilla
 int     NBuyLimit;      // total de buy stop
 int     NSellLimit;     // 
 int     ticketB2;
 int     ticketS2;
 bool    estado;
 int     ticketBuystop;
 int     ticketSellstop;
 int     canalActivo; 
 int     canalActivoflag;
private:
 //int CanalActivo[10];
 //int CanalActivoflag[10]; 
 int ticketsellstop[100];
 int ticketbuystop[100]; 
public:
                    Grilla();
                    ~Grilla();
                    Grilla(int idgrilla,Mg &m);
                    //la declaracion de los objetos siempre tienen que tener distinto nombre que en la declaracion en la cabecera
                    void   ArmarGrillaInicial(Mg &m,Operaciones &ope,Orden* &vectorOrden[]);
                    //void   ArmarGrillaInicial(Mg &m,Operaciones &ope);
                    int    armar_prox_paso(Operaciones &op,Grilla &grilla);
                    void   setIdGrilla(int idgrilla);
                    int    getIdGrilla();
                    void   setMagicoInicial(int magicoInicial);
                    int    getMagicoInicial();
                    void   setMagicoActual(int &magicoActual);
                    int    getMagicoActual();
                    void   setDiametro(double diametro);    
                    double getDiametro();                
                    double getTechoCanal();
                    void   setTechoCanal(double techocanal);
                    double getPisoCanal();
                    void   setPisoCanal(double pisocanal);
                    void   setCanal_techo(bool canaltecho);
                    bool   getCanal_techo();
                    void   setCanal_piso(bool canalpiso);
                    bool   getCanal_piso();
                    void   setCanalRoto(bool canalroto);
                    bool   getCanalRoto();
                    void   setCanalActivoFlag(int canalActivoFlag);
                    int    getCanalActivoFlag();
                    void   setCanalActivo(int &canalactivo);
                    int    getCanalActivo();
                    void   setPoint();
                    double getPoint();
                    void   setAsk(double &ask);
                    double getAsk(double &ask);
                    void   setBid(double &bid);
                    double getBid(double &bid);
                    void   setNordenes(int &norden);
                    int    getNordenes();
                    void   setNBuyLimit(int &nbuylimit);
                    int    getNBuyLimit();
                    void   setNSellLimit(int &nsellimit);
                    int    getNSellLimit();
                    //void   setTicketbuystop(int tickeBuy);
                    int    getTicketbuystop(int nb);
                    //void   setTicketsellstop(int ticketSell);
                    int    getTicketsellstop(int ns);
                    void   setTicketB2(int ticketb2);
                    int    getTicketB2();
                    void   setTicketS2(int ticketb2);
                    int    getTicketS2();
                    void   setEstadoGrilla(bool estadoGrilla);
                    bool   getEstadoGrilla();
                    void   lanzaGrilla(Grilla* &vector[],Orden* &vectorOrden[],int &contador,Mg &mg,Operaciones &op);
                    void   lanzaGrillaAutomatica(Grilla* &vector[],Orden* &vectorOrden[],int &contadorGrilla,bool &banderaAgregaGrilla,Mg &mg,Operaciones &op,bool &banderaIniciaBoton,bool automatico,Boton &boton1n,string linea);
                    
                    //void lanzaGrilla(Grilla* &vector[],int &contador,Mg &mg,Operaciones &op);
                    
  };
void   Grilla::setEstadoGrilla(bool estadoGrilla){
 estado=estadoGrilla;
}
bool   Grilla::getEstadoGrilla(){
 return estado;
}
void Grilla::setIdGrilla(int idgrilla){
   idGrilla=idgrilla;   
}
int Grilla::getIdGrilla(void){
 return idGrilla;
}
void  Grilla::setNordenes(int &norden){
  Nordenes=norden;
 }
int  Grilla::getNordenes(){
  return Nordenes;
 }
void  Grilla::setNBuyLimit(int &nbuylimit){
 NBuyLimit=nbuylimit;
}
int  Grilla::getNBuyLimit(){
 return NBuyLimit;
}
void  Grilla::setNSellLimit(int &nsellimit){
 NSellLimit=nsellimit;
}
int  Grilla::getNSellLimit(){
 return NSellLimit;
}
void Grilla::setMagicoInicial(int magicoInicial){
  magicoinicial=magicoInicial;
}
int  Grilla::getMagicoInicial(){
   return magicoinicial;
}
void Grilla::setMagicoActual(int &magicoActual){
   magicoactual=magicoActual;
 }
int Grilla::getMagicoActual(void){
  return magicoactual;
}
void Grilla::setCanalActivo(int &canalactivo){
 canalActivo=canalactivo;
 //CanalActivo[0]=canalActivo;
}
int Grilla::getCanalActivo(void){
 return canalActivo;
  //return CanalActivo[0];
}
void Grilla::setCanalActivoFlag(int canalActivoFlag){
 canalActivoflag=canalActivoFlag;
}
int  Grilla::getCanalActivoFlag(){
 return canalActivoflag;
}
//void Grilla::setTicketbuystop(int tickeBuy,){
// ticketBuystop=tickeBuy;
//}
int  Grilla::getTicketbuystop(int nb){
 
 return ticketbuystop[nb];
}
//void Grilla::setTicketsellstop(int ticketSell){
//  ticketSellstop=ticketSell;
//}
int  Grilla::getTicketsellstop(int ns){
  return ticketsellstop[ns];
}
//void Grilla::setTicketB2(int ticketb2){
// ticketB2=ticketb2;
//}
int Grilla::getTicketB2(){
 return ticketB2;
}
void Grilla::setTicketS2(int tickets2){
 ticketS2=tickets2;
}
int Grilla::getTicketS2(){
 return ticketS2;
}
void Grilla::setCanalRoto(bool canalroto){
 canal_roto=canalroto;
}
bool Grilla::getCanalRoto(void){
  return canal_roto;
}
void Grilla::setDiametro(double diametro){
 Diametro=diametro;
}
double Grilla::getDiametro(void){
 return Diametro;
}
double Grilla::getTechoCanal(void){
  return TechoCanal;
}
void Grilla::setTechoCanal(double techocanal){
 TechoCanal=techocanal;
}
double Grilla::getPisoCanal(void){
  return pisoCanal;
}
void Grilla::setPisoCanal(double pisocanal){
 pisoCanal=pisocanal;
}
void Grilla::setCanal_piso(bool canalpiso){
 Canal_piso=canalpiso;
}
bool Grilla::getCanal_piso(void){
   return Canal_piso;
}
void Grilla::setCanal_techo(bool canaltecho){
 Canal_techo=canaltecho;
}
bool Grilla::getCanal_techo(void){
   return Canal_techo;
}
void  Grilla::setAsk(double &ask){
 _ask=ask;
}
double  Grilla::getAsk(double &ask){
 return _ask;
}
void  Grilla::setBid(double &bid){
 _bid=bid;
}
double  Grilla::getBid(double &bid){
 return _bid;
}

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
void Grilla::ArmarGrillaInicial(Mg &mg,Operaciones &ope,Orden* &vectorOrden[]) // H,d,Vo
//void Grilla::ArmarGrillaInicial(Mg &mg,Operaciones &ope) // H,d,Vo
{
   Print("magicoini ",magicoini," getIdGrilla() ",getIdGrilla());
   setMagicoInicial(magicoini+idGrilla);
   Print("ttttttttttttttttttttttttttttttttttttttttttttidGrilla",getIdGrilla()," mmmmmmmmmmmmmmmmmmmmmmmmmagico inicial ",getMagicoInicial());
   nivel=0; nivelpip=0;
   Nordenes = (int) ( Dtot /  (dgrilla+gap)  ) ;
   NBuyLimit = Nordenes/2 ;
   NSellLimit = Nordenes/2 ;  
   string symbol=Symbol();int OO_cmd=OP_BUY;color OO_arrow_color=Blue;
   datetime _ExpDate=0; //TimeCurrent()+600*60;      // 10 horas de caducidad. 
   int a=1;
   setCanalActivo(a);
//   Print(" setCanalllllllllllllllllllllllllllllllllllllllllllllllllllActivo(1) ",getCanalActivo());
//   
   //ArrayResize(ticketbuystop,NBuyLimit+10);
   //ArrayResize(ticketsellstop,NSellLimit+10);

   //double Vo = 0.5*vol;
   double Vo = vol;
   
   Print("Grilla INI:   D: ",Dtot,"  d: ",dgrilla,"  gap: ",gap,"  Nordenes:  ",Nordenes,"  NBuy_Stop:  ",NBuyLimit,"  NSell_Stop:  ",NSellLimit," Vo ",Vo);
  
 
   // ***** 1ro la BUY market
   int magico=getMagicoInicial();
   double buyPrice = NormalizeDouble(Ask , Digits);
   mg.setNivelS0(buyPrice);
   double buyTP    = NormalizeDouble(Ask + 10 * dgrilla *_point  ,Digits);
   double buySL    = 0;
   symbol=Symbol();OO_cmd=OP_BUY;OO_arrow_color=Blue;
   ticketsellstop[0]=ope.OrderOpenF(symbol,OO_cmd,Vo ,buyPrice ,slippage,buySL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
   ordenn.setOrden(vectorOrden,0,ticketbuystop[0],idGrilla,true);
   _ask=Ask;
   
  // ***** 2do bucle de las BUY stop 
  for (nivel=1; nivel<=NBuyLimit ; nivel++ ) // colocamos las Buy Stop
   {
     //double nivelpip = nivel*d;
      nivelpip = nivel*(gap+dgrilla);
       
      //Orden orden(nivel);Print("orden ",orden.getIdOrden());
      buyPrice = NormalizeDouble(_ask + 10*nivelpip*_point      ,Digits);
      buyTP    = NormalizeDouble(_ask + 10*(nivelpip+dgrilla)*_point  ,Digits);
      buySL=0;
      
      //Print(" nivel :",   nivel," BUY nivelpip :",   nivelpip, "  BUY Price ",buyPrice ,"  BUY TP    ",buyTP    );
      
      symbol=Symbol();OO_cmd=OP_BUYSTOP;OO_arrow_color=clrWhite;
      ticketbuystop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo ,buyPrice ,slippage,buySL,buyTP,comentario,magico,_ExpDate,OO_arrow_color);
      ordenn.setOrden(vectorOrden,nivel,ticketbuystop[nivel],idGrilla,true);  
      //if (nivel==NBuyLimit){TechoCanal = buyTP;TechoCanalp=(nivelpip+d);Print(" TechoCanal:",TechoCanal); }
       if (nivel==NBuyLimit)
         {     TechoCanal = NormalizeDouble(_ask + 10*(nivelpip+dgrilla+gap)*_point  ,Digits);
               TechoCanalp=(nivelpip+dgrilla+gap);Print(" TechoCanal:",TechoCanal); 
         }
   }

   // ***** 3ro Coloco el BUY 2Vo
   buyPrice = TechoCanal ;       // 2Vo
   buyTP    = NormalizeDouble(_ask + (10*1.5*TechoCanalp)*_point    ,Digits);
   buySL    = NormalizeDouble(_ask + (10*0.5*TechoCanalp)*_point    ,Digits);
   symbol=Symbol();OO_cmd=OP_BUYSTOP;OO_arrow_color=Blue;double Vo1=(2*vol);int magico1=(magico+1);
   ticketB2=ticketbuystop[nivel]=ope.OrderOpenF (symbol ,OO_cmd     ,Vo1 ,buyPrice ,slippage,buySL,buyTP,comentario,magico1,_ExpDate,OO_arrow_color);
   ordenn.setOrden(vectorOrden,nivel,ticketbuystop[nivel],idGrilla,true);  
   
   mg.setNivelS1(buySL);
   mg.setNivelS2(buyPrice);
   mg.setNivelS3(buyTP);  
   
   
    
   // ***** 1ro la SELL market
   double sellPrice = NormalizeDouble(Bid , Digits);
   mg.setNivelI0(sellPrice);
   double sellTP    = NormalizeDouble(Bid - 10 * dgrilla *_point  ,Digits);
   double sellSL    = 0;
   symbol=Symbol();OO_cmd=OP_SELL;OO_arrow_color=clrRed;
   ticketsellstop[0]=ope.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice ,slippage,sellSL,sellTP,comentario,magico,_ExpDate,OO_arrow_color);
   ordenn.setOrden(vectorOrden,0,ticketsellstop[0],idGrilla,true);  
   
   _bid=Bid;
   // ***** 2do bucle de las SELL stop
   for (nivel=1; nivel<=NSellLimit ; nivel++ )// colocamos las sell Stop
   {
    
    nivelpip =nivel*(gap+dgrilla);
   
    sellPrice  = NormalizeDouble( _bid - 10*nivelpip*_point      ,Digits);
    sellTP     = NormalizeDouble( _bid - 10*(nivelpip+dgrilla)*_point  ,Digits);
    symbol=Symbol();OO_cmd=OP_SELLSTOP;OO_arrow_color=clrRed;
    ticketsellstop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice ,slippage,sellSL,sellTP,comentario,magico,_ExpDate,OO_arrow_color);
    ordenn.setOrden(vectorOrden,nivel,ticketsellstop[nivel],idGrilla,true);  
    if (nivel==NSellLimit)
      {     pisoCanal= NormalizeDouble( _bid - 10*(nivelpip+dgrilla+gap)*_point  ,Digits);
            pisoCanalp=(nivelpip+dgrilla+gap);Print(" PisvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvoCanal:",pisoCanal);       
      }
   }
   // ***** 3ro Coloco el SELL 2Vo
   sellPrice = pisoCanal;       // 2Vo
   sellTP    = NormalizeDouble(_bid - (10*1.5*pisoCanalp)*_point    ,Digits);
   sellSL    = NormalizeDouble(_bid - (10*0.5*pisoCanalp)*_point    ,Digits);
   //MagicN=31415901;
   symbol=Symbol();OO_cmd=OP_SELLSTOP;OO_arrow_color=clrRed;Vo1=(2*vol); magico1=(magico+1);
   ticketS2=ticketsellstop[nivel]=ope.OrderOpenF(symbol,OO_cmd,Vo1 ,sellPrice ,slippage,sellSL,sellTP,comentario,magico1,_ExpDate,OO_arrow_color);
   ordenn.setOrden(vectorOrden,nivel,ticketsellstop[nivel],idGrilla,true);  
   mg.setNivelI1(sellSL);
   mg.setNivelI2(sellPrice);
   mg.setNivelI3(sellTP);  
   
   Diametro = TechoCanalp + pisoCanalp;
  
  setMagicoInicial(magico1);
  magicoactual=getMagicoInicial();
  setIdGrilla(magico1);
  Print("ArmarGrillaInicial magicoactual ",magicoactual," magico1 ",magico1," idGrilla",idGrilla);
   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Grilla::lanzaGrillaAutomatica(Grilla* &vector[],Orden* &vectorOrden[],int &contadorGrilla,bool &banderaAgregaGrilla,Mg &mg,Operaciones &op,bool &banderaIniciaBoton,bool automatico,Boton &boton1n,string linea){
  // automatizar
          //if(banderaAgregaGrilla){
           if(automatico){
             banderaAgregaGrilla=false;
             banderaIniciaBoton=false;
             grilla.lanzaGrilla(vector,vectorOrden,contadorGrilla,mg,op);
             //grilla.lanzaGrilla(vector,contadorGrilla,m,opg);
             datetime timee=TimeCurrent();
             ObjLinea.HLineMoveVertical(linea,timee);
          }else{
               banderaIniciaBoton=true;
               boton1.setDescripcion(boton1.getNombreBoton(),"_INICIO_");
               color colorBoton1=clrGreen;
               boton1.setColor(boton1.getNombreBoton(),colorBoton1);
          }
         //}
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Grilla::lanzaGrilla(Grilla* &vector[],Orden* &vectorOrden[],int &contadorGrilla,Mg &mg,Operaciones &op){
//void Grilla::lanzaGrilla(Grilla* &vector[],int &contadorGrilla,Mg &mg,Operaciones &op){
    vector[contadorGrilla]=new Grilla();
    vector[contadorGrilla].setIdGrilla(contadorGrilla*1000);
    vector[contadorGrilla].setPoint();
    vector[contadorGrilla].setEstadoGrilla(true);
    vector[contadorGrilla].ArmarGrillaInicial(mg,op,vectorOrden);
    //vector[contadorGrilla].ArmarGrillaInicial(mg,op); 
    contadorGrilla++;
 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Grilla::armar_prox_paso(Operaciones &op,Grilla &grillaa){
      Orden orden;
      int valor=grillaa.getCanalActivo();
      valor++;
      grillaa.setCanalActivo(valor);   
         
      int magicoo=grillaa.getMagicoActual();
      magicoo ++;
     
      string symbol;int OO_cmd;int OO_slippage=10;datetime OO_expiration=0;color OO_arrow_color;
    
      double Vo=vol*MathPow(2,valor);
      uint Ticket;
     
if (grillaa.getCanalActivoFlag()==1){         // ARRIBA
 
if ((grillaa.getCanalActivo()&1)==1){         // IMPAR

   double buySL = op.arr_impar[0];     //SL
   double buyPrice = op.arr_impar[1];  //B
   double buyTP = op.arr_impar[2];     //TP+
   
   Print("-------------Orden MG BUYSTOP arr impar",buyPrice," buyTP ",buyTP," buySL ",buySL, " Vo=",Vo);
   symbol=Symbol(); OO_cmd=OP_BUYSTOP; OO_arrow_color=clrBlue;
   Ticket=op.OrderOpenF(symbol,OO_cmd,(Vo),buyPrice ,OO_slippage,buySL,buyTP,comentario,magicoo,OO_expiration,OO_arrow_color);
         
   orden.setTicket(Ticket);
   orden.setBuy_TP_actual(buyTP);
}

if ((grillaa.getCanalActivo()&1)==0){      // PAR
   double sellTP = op.arr_par[0];      //TP
   double sellPrice = op.arr_par[1];   //S
   double sellSL = op.arr_par[2];      //SL
 
Print("-------------Orden MG BUYSTOP arr par",sellPrice," buyTP ",sellTP," buySL ",sellSL, " Vo=",Vo);   
symbol=Symbol(); OO_cmd=OP_SELLSTOP; OO_arrow_color=clrRed;
Ticket=op.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice,OO_slippage,sellSL,sellTP,comentario,magicoo,OO_expiration,OO_arrow_color);
orden.setTicket(Ticket);
orden.setSell_TP_actual(sellTP);
}

}


if (grillaa.getCanalActivoFlag()==-1){        // ABAJO
if ((grillaa.getCanalActivo()&1)==1){      // IMPAR

   double sellSL = op.ab_impar[0];     //SL
   double sellPrice = op.ab_impar[1];  //S   
   double sellTP = op.ab_impar[2];     //TP


symbol=Symbol(); OO_cmd=OP_SELLSTOP; OO_arrow_color=clrRed;
Ticket=op.OrderOpenF(symbol,OO_cmd,Vo ,sellPrice,OO_slippage,sellSL,sellTP,comentario,magicoo,OO_expiration,OO_arrow_color);
orden.setSell_TP_actual(sellTP);
}

if ((grillaa.getCanalActivo()&1)==0){      // PAR
double buyTP = op.ab_par[0];        //TP
double buyPrice = op.ab_par[1];     //B
double buySL = op.ab_par[2];        //SL
symbol=Symbol(); OO_cmd=OP_BUYSTOP; OO_arrow_color=clrRed;
Ticket=op.OrderOpenF(symbol,OO_cmd,Vo ,buyPrice ,OO_slippage,buySL,buyTP,comentario,magicoo,OO_expiration,OO_arrow_color);
orden.setBuy_TP_actual(buyTP);
}



}
 setMagicoInicial(magicoo);
 magicoini=getMagicoInicial();
return (magicoo);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Grilla::Grilla(int idgrilla,Mg &m){
 idGrilla=idgrilla;
 
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
