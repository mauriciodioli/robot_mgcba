//+------------------------------------------------------------------+
//|                                                        Linea.mqh |
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
class Linea
  {
private:
 color idColor;
 string nombreLinea;

public:
                     Linea();
                     Linea(string &nombre,color idcolor,double _ask1,datetime tiempo,bool bandera);
                   //  Linea(string &nombre,datetime tiempo);
                    ~Linea();
//+------------------------------------------------------------------+
//| Create the line                                       |
//+------------------------------------------------------------------+
void LineCreate(string &nombre,double _ask,datetime tiempo,bool bandera ); 
//+------------------------------------------------------------------+ 
//| Move horizontal line                                             | 
//+------------------------------------------------------------------+ 
static void HLineMove( string &name,double price);       
void setColor(string &nombreLinea,color colorLinea);             
};

//+------------------------------------------------------------------+
//| Create the line                                       |
//+------------------------------------------------------------------+
void Linea::LineCreate(string &nombre,double _ask1,datetime tiempo,bool bandera )         // priority for mouse click
  {//--- check correctness of the input parameters
    string name=nombre;
   //--------Crea linea Vertical
   if(bandera==true)if(!ObjectCreate(0,name,OBJ_VLINE,0,tiempo,0)){Print(__FUNCTION__,": failed to create a vertical line! Error code = ",GetLastError());}
   //--------Crea linea Horizontal
   if(bandera==false)if(!ObjectCreate(0,name,OBJ_HLINE,0,0,_ask1)){Print(__FUNCTION__,": failed to create a horizontal line! Error code = ",GetLastError());}
   //--- set line color
    setColor(name,idColor);
   //--- set line display style
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
   //--- set line width
   ObjectSetInteger(0,name,OBJPROP_WIDTH,3);
   //--- display in the0foreground (false) or background (true)
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
   //--- enable (true) or disable (false) the mode of moving the line by mouse
   //--- when creating a graphical object using ObjectCreate function, the object cannot be
   //--- highlighted and moved by default. Inside this method, selection parameter
   //--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,true);
   //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
   //--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
   //--- successful execution
  }

//+------------------------------------------------------------------+ 
//| Move horizontal line                                             | 
//+------------------------------------------------------------------+ 
void Linea::HLineMove( string &name,double price)      // line price 
  { 
  int chart_ID=0;
//--- if the line price is not set, move it to the current Bid price level 
   if(!price) 
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- reset the error value 
   ResetLastError(); 
//--- move a horizontal line 
   if(!ObjectMove(0,name,0,0,price)){Print(__FUNCTION__, ": failed to move the horizontal line! Error code = ",GetLastError());} 
//--- successful execution 
  
  } 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Linea::setColor(string &nombre,color colorLinea){
 ObjectSetInteger(0,nombre,OBJPROP_COLOR, colorLinea);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Linea::Linea(string &nombre,color idcolor,double _ask1,datetime tiempo,bool bandera){  
   idColor=idcolor;
   nombreLinea=nombre;
   LineCreate(nombre,_ask1,tiempo,bandera);
  
  }

 Linea::Linea(){}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Linea::~Linea()
  {
  }
//+------------------------------------------------------------------+
