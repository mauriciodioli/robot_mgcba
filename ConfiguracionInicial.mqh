//+------------------------------------------------------------------+
//|                                         ConfiguracionInicial.mqh |
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
class ConfiguracionInicial
  {
private:
   double dist;
   double vol;
   double buy;
   double sell;
public:
                     ConfiguracionInicial();
                    ~ConfiguracionInicial();
                   void distancia(int &dis);
                   void volumen();
                   void estableceCantidadBuy();
                   void estableceCantidadSell();
  };
  //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::distancia(int &dis)
  {
    printf("configuara distancia %d",dis);
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::volumen()
  {
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::estableceCantidadBuy()
  {
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::estableceCantidadSell()
  {
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ConfiguracionInicial::ConfiguracionInicial()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ConfiguracionInicial::~ConfiguracionInicial()
  {
  }
//+------------------------------------------------------------------+
