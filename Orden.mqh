//+------------------------------------------------------------------+
//|                                                        Orden.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Orden
  {
private:
 int idOrden;
 datetime tiempo;
 string tipo;
 double volumen;
 double precio;
 double sl;
 double tp;
 double beneficio;
 double balance;
 uint Ticket;
 double buy_TP_actual;
 double sell_TP_actual;
 bool techo;
 int AbiertabuyTicket;
 int CerradabuyTicket;
 int AbiertasellTicket;
 int CerradasellTicket;

 
public:
                     Orden();
                     Orden(int ordenid);
                    ~Orden();
                    int getIdOrden();
                    void setTicket(uint &ticket);
                    uint getTicket();
                    void setBuy_TP_actual(double &buyTpActual);
                    double getBuy_TP_actual();
                    void setSell_TP_actual(double &sellTpActual);
                    double getSell_TP_actual();
                    void setAbiertabuyTicket(int &abiertabuy);
                    int  getAbiertabuyTicket();
                    void setCerradabuyTicket(int &cerradabuy);
                    int  getCerradabuyTicket();
                    void setAbiertasellTicket(int &abiertasell);
                    int  getAbiertasellTicket();
                    void setCerradasellTicket(int &cerradasell);
                    int  getCerradasellTicket();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Orden::getIdOrden(void){
 return idOrden;
}
 void Orden::setTicket(uint &ticket){
  Ticket=ticket;
 }
 uint Orden::getTicket(){
  return Ticket;
 }
 void Orden::setBuy_TP_actual(double &buyTpActual){
  buy_TP_actual=buyTpActual;
 }
 double Orden::getBuy_TP_actual(){
  return buy_TP_actual;
 }
void Orden::setSell_TP_actual(double &sellTpActual){
 sell_TP_actual=sellTpActual; 
}
 double Orden::getSell_TP_actual(){
  return sell_TP_actual;
 }
void Orden::setAbiertabuyTicket(int &abiertabuy){
  AbiertabuyTicket=abiertabuy;
}
int  Orden::getAbiertabuyTicket(){
 return AbiertabuyTicket;
}
void Orden::setCerradabuyTicket(int &cerradabuy){
 CerradabuyTicket=cerradabuy;
}
int  Orden::getCerradabuyTicket(){
 return CerradabuyTicket;
}
void Orden::setAbiertasellTicket(int &abiertasell){
 AbiertasellTicket=abiertasell;
}
int  Orden::getAbiertasellTicket(){
 return AbiertasellTicket;
}
void Orden::setCerradasellTicket(int &cerradasell){
 CerradasellTicket=cerradasell;
}
int  Orden::getCerradasellTicket(){
 return CerradasellTicket;
}
 //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Orden::Orden(int ordenid)
  {
   idOrden=ordenid;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Orden::Orden()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Orden::~Orden()
  {
  }
//+------------------------------------------------------------------+
