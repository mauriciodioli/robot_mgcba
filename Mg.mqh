//+------------------------------------------------------------------+
//|                                                           Mg.mqh |
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
class Mg
  {
private:
 double nivelS0;
 double nivelS1;
 double nivelS2;
 double nivelS3;
 double nivelI0;
 double nivelI1;
 double nivelI2;
 double nivelI3;

public:
                     Mg();
                    ~Mg();
                    void setNivelS0(double &nS0);
                    void setNivelS1(double &nS1);
                    void setNivelS2(double &nS2);
                    void setNivelS3(double &nS3);
                    void setNivelI0(double &nI0);
                    void setNivelI1(double &nI1);
                    void setNivelI2(double &nI2);
                    void setNivelI3(double &nI3);
                    double getNivelS0();
                    double getNivelS1();
                    double getNivelS2();
                    double getNivelS3();
                    double getNivelI0();
                    double getNivelI1();
                    double getNivelI2();
                    double getNivelI3();
  };
void Mg::setNivelS0(double &nS0){
 nivelS0=nS0;
}
double Mg::getNivelS0(){
   return nivelS0;
  }
void Mg::setNivelS1(double &nS1){
 nivelS1=nS1;
}  
double Mg::getNivelS1(){
  return nivelS1;
}
void Mg::setNivelS2(double &nS2){
 nivelS2=nS2;
}
double Mg::getNivelS2(){
  return nivelS2;
}
void Mg::setNivelS3(double &nS3){
 nivelS3=nS3;
}
double Mg::getNivelS3(){
  return nivelS3;
}
void Mg::setNivelI0(double &nI0){
 nivelI0=nI0;
}
double Mg::getNivelI0(){
  return nivelI0;
}
void Mg::setNivelI1(double &nI1){
 nivelI1=nI1;
}
double Mg::getNivelI1(){
   return nivelI1;
} 
void Mg::setNivelI2(double &nI2){
 nivelI2=nI2;
}
double Mg::getNivelI2(){
   return nivelI2;
}
void Mg::setNivelI3(double &nI3){
 nivelI3=nI3;
}
double Mg::getNivelI3(){
   return nivelI3;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Mg::Mg()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Mg::~Mg()
  {
  }
//+------------------------------------------------------------------+
