//+------------------------------------------------------------------+
//|                                                      Limites.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
//#include "Grilla.mqh"
//#include "Operaciones.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Limites
  {
private:
   double limiteInferior;
   double limiteSuperior;
   double limitMg;
public:
                     Limites();
                    ~Limites();
                  //   
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Limites::Limites()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Limites::~Limites()
  {
  }
//+------------------------------------------------------------------+
