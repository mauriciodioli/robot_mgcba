//+------------------------------------------------------------------+
//|                                                        Canal.mqh |
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
class Canal
  {
private:
 double techo;
 double piso;
 int longitud;
 int radio; 
 double centroDcanal;
public:
                     Canal();
                    ~Canal();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Canal::Canal()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Canal::~Canal()
  {
  }
//+------------------------------------------------------------------+
