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
  int tamaX;
  int tamaY;
  color idColor;
  string colFuente;
public:
                     Boton();
                     Boton(string &nombre,string &descripcion,int x,int y,color &c);
                     Boton(string &nombre,string &descripcion,int x,int y,color &c,int tamX,int tamY);
                     
                    ~Boton();
                    void   getBoton();
                    string getNombreBoton();
                    void   delet(string nomb);
                    void   setColor(string nombre,color &colorBoton);
                    void   getAccion(bool &bandera);
                    void   setPosicion(int &valX,int &valY);
                    void   setTam(int &tamX,int &TamY);
                    void   setDescripcion(string nom,string descrip);
                    void   setColorFuente(color colorfuente);
                    string  getColorFuente();
                    static void delet(int nbotones);  
                    
                    
  };
// ***************************************************************************
//         CONFIGURA BOTON 
// ===========================================================================
void Boton::getBoton(){

   ObjectCreate(0,nombreBoton,OBJ_BUTTON,0,0,0);
   
   setPosicion(posicionX,posicionY);
   setTam(tamaX,tamaY);
   ObjectSetString(0,nombreBoton,OBJPROP_TEXT,etiquetaBoton);
   ObjectSetInteger(0,nombreBoton,OBJPROP_COLOR, White);
   setColor(nombreBoton,idColor);
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
void Boton::setDescripcion(string nom,string descrip){
   ObjectSetString(0,nom,OBJPROP_TEXT,descrip);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::setPosicion(int &valX,int &valY){
   ObjectSetInteger(0,nombreBoton,OBJPROP_XDISTANCE,valX);
   ObjectSetInteger(0,nombreBoton,OBJPROP_YDISTANCE,valY);

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::setTam(int &tamX,int &tamY){
   ObjectSetInteger(0,nombreBoton,OBJPROP_XSIZE,tamX);
   ObjectSetInteger(0,nombreBoton,OBJPROP_YSIZE,tamY);

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::getAccion(bool &bandera){
   bandera=ObjectGetInteger(0,nombreBoton,OBJPROP_STATE);
    ObjectSetInteger(0,nombreBoton,OBJPROP_STATE,false);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::setColor(string nombre,color &colorBoton){
ObjectSetInteger(0,nombre,OBJPROP_BGCOLOR, colorBoton);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Boton::getNombreBoton(void){
 return nombreBoton;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::setColorFuente(color colorfuente){
 colFuente=colorfuente;
 ObjectSetInteger(0,nombreBoton,OBJPROP_COLOR, colorfuente);
}//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Boton::getColorFuente(void){
 return colFuente;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Boton::delet(int nbotones){

  for(int i=0;i<=nbotones;i++){
     string nombre="Boton"+IntegerToString(i);
     ObjectDelete(0,nombre);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Boton::Boton(string &nombre,string &descripciones,int x,int y,color &c)
  {
   nombreBoton=nombre;
   etiquetaBoton=descripciones;
   posicionX=x;
   posicionY=y;
   tamaX=100;
   tamaY=50;
   idColor=c;
   getBoton();
   
  }
  //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Boton::Boton(string &nombre,string &descripciones,int x,int y,color &c,int tamX,int tamY)
  {
   nombreBoton=nombre;
   etiquetaBoton=descripciones;
   posicionX=x;
   posicionY=y;
   tamaX=tamX;
   tamaY=tamY;
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
