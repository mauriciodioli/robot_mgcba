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
public:
   double dist;
   double volumen;
   double buys;
   double sells;
public:
                     ConfiguracionInicial();
                    ~ConfiguracionInicial();
                   void setDistancia(int &dis);
                   void setVolumen(int &vol);
                   void setCantidadBuy(int &buy);
                   void setCantidadSell(int &sell);
                 
  };
  //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::setDistancia(int &dis)
  {
    dis=50; 
  
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::setVolumen(int &vol)
  {
   vol=2;   
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::setCantidadBuy(int &buy)
  {
    buy=4;
  }
    //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConfiguracionInicial::setCantidadSell(int &sell)
  {   
    sell=4;
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
