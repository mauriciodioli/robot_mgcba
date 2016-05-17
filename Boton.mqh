//+------------------------------------------------------------------+
//|                                                        Boton.mqh |
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
class Boton
  {
private:
  string nombreBoton;
  string etiquetaBoton;
  int posicionX;
  int posicionY;
  int idColor;
public:
                     Boton();
                     Boton(string &nombre,string &descripcion,int &x,int &y,int &c);
                    ~Boton();
                    void getBoton();
                    void setColor();
                    
  };
// ***************************************************************************
//         CONFIGURA BOTON 
// ===========================================================================
void Boton::getBoton(){

   ObjectCreate(0,nombreBoton,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,nombreBoton,OBJPROP_XDISTANCE,posicionX);
   ObjectSetInteger(0,nombreBoton,OBJPROP_YDISTANCE,posicionY);
   ObjectSetInteger(0,nombreBoton,OBJPROP_XSIZE,100);
   ObjectSetInteger(0,nombreBoton,OBJPROP_YSIZE,50);
   ObjectSetString(0,nombreBoton,OBJPROP_TEXT,etiquetaBoton);
   setColor();
   ObjectSetInteger(0,nombreBoton,OBJPROP_COLOR, White);
   ObjectSetInteger(0,nombreBoton,OBJPROP_BORDER_COLOR,clrBlack);
   ObjectSetInteger(0,nombreBoton,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0,nombreBoton,OBJPROP_BACK,false);
   ObjectSetInteger(0,nombreBoton,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,nombreBoton,OBJPROP_STATE,false);
   ObjectSetInteger(0,nombreBoton,OBJPROP_FONTSIZE,16);
   ChartRedraw(0);  
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::setColor(){
switch(idColor){
      case 1: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrBlue);break;}
      case 2: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrRed);break;}
      case 3: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrGreen);break;}
      case 4: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrYellow);break;}
      case 5: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrBrown);break;}
      case 6: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrOrange);break;}
      case 7: {ObjectSetInteger(0,nombreBoton,OBJPROP_BGCOLOR, clrViolet);break;}
    }

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Boton::Boton(string &nombre,string &descripcion,int &x,int &y,int &c)
  {
   nombreBoton=nombre;
   etiquetaBoton=descripcion;
   posicionX=x;
   posicionY=y;
   idColor=c;
   getBoton();
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Boton::~Boton()
  {
  }
//+------------------------------------------------------------------+
