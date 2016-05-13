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
                 // Deslizamiento maximo permitido.
public:
                     ConfiguracionInicial();
                    ~ConfiguracionInicial();
                     void setBoton();
                 
                 
  };

// ***************************************************************************
//         CONFIGURA BOTON 
// ===========================================================================
void ConfiguracionInicial::setBoton(void){

   ObjectCreate(0,"openshort",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,"openshort",OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,"openshort",OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,"openshort",OBJPROP_XSIZE,100);
   ObjectSetInteger(0,"openshort",OBJPROP_YSIZE,50);
   ObjectSetString(0,"openshort",OBJPROP_TEXT,"_START_");
   ObjectSetInteger(0,"openshort",OBJPROP_COLOR, White);
   ObjectSetInteger(0,"openshort",OBJPROP_BGCOLOR, clrGreen);
   ObjectSetInteger(0,"openshort",OBJPROP_BORDER_COLOR,clrBlack);
   ObjectSetInteger(0,"openshort",OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,"openshort",OBJPROP_BACK,false);
   ObjectSetInteger(0,"openshort",OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,"openshort",OBJPROP_STATE,false);
   ObjectSetInteger(0,"openshort",OBJPROP_FONTSIZE,16);

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
