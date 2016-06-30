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
 int idMg;
 int idGrilla;
 bool estadoMg;
 bool estadoGrilla;
 double nivelS0;
 double nivelS1;
 double nivelS2;
 double nivelS3;
 double nivelI0;
 double nivelI1;
 double nivelI2;
 double nivelI3;
 double arr_par[3];
 double arr_impar[3];
 double ab_par[3];
 double ab_impar[3];
public:
                     Mg();
                    ~Mg();
                    int  getIdMg();
                    int  getIdGrilla();
                    bool getEstadoMg();
                    bool getEstadoGrilla();
                    void arma_matrix(Mg &mg);
                    bool setMg(int idmg,int Idgrilla,bool estadomg,bool estadogrilla);
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
                    void   setArr_par(int appuntero, double appvalor);
                    double getArr_par(int appuntero);
                    void   setArr_impar(int aipuntero,double aivalor);
                    double getArr_impar(int aipuntero);
                    void   setAb_par(int bppuntero,double bpvalor);
                    double getAb_par(int bppuntero);
                    void   setAb_impar(int bipuntero,double bivalor);
                    double getAb_impar(int bipuntero);
  };
  
bool Mg::setMg(int idmg,int Idgrilla,bool estadomg,bool estadogrilla){
   idMg=idmg;
   idGrilla=Idgrilla;
   estadoMg=estadomg;
   estadoGrilla=estadogrilla;
 return true;
}
int  Mg::getIdMg(){
 return idMg;
}
int  Mg::getIdGrilla(){
 return idGrilla;
}
bool Mg::getEstadoMg(){
 return estadoMg;
}
bool Mg::getEstadoGrilla(){
 return estadoGrilla;
}
void Mg::setArr_par(int appuntero, double appvalor){
 arr_par[appuntero]=appvalor;
}
double Mg::getArr_par(int appuntero){
 return arr_par[appuntero];
}
void Mg::setArr_impar(int aipuntero,double aivalor){
 arr_impar[aipuntero]=aivalor;
}
double Mg::getArr_impar(int aipuntero){
 return arr_impar[aipuntero];
}
void  Mg::setAb_par(int bppuntero,double bpvalor){
 ab_par[bppuntero]=bpvalor;
}
double Mg::getAb_par(int bppuntero){
 return ab_par[bppuntero];
}
void Mg::setAb_impar(int bipuntero,double bivalor){
  ab_impar[bipuntero]=bivalor;
 }
double Mg::getAb_impar(int bipuntero){
 return ab_impar[bipuntero];
}
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
void Mg::arma_matrix(Mg &mg)
 {
arr_impar[0]=mg.getNivelS1();
arr_impar[1]=mg.getNivelS2();
arr_impar[2]=mg.getNivelS3();
arr_par[0]=mg.getNivelS0();
arr_par[1]=mg.getNivelS1();
arr_par[2]=mg.getNivelS2();
Print("-------------Matrix S  S0=",mg.getNivelS0()," S1=",mg.getNivelS1()," S2=",mg.getNivelS2(), " S3=",mg.getNivelS3());
ab_impar[0]=mg.getNivelI1();
ab_impar[1]=mg.getNivelI2();
ab_impar[2]=mg.getNivelI3();
ab_par[0]=mg.getNivelI0();
ab_par[1]=mg.getNivelI1();
ab_par[2]=mg.getNivelI2();
Print("-------------Matrix S  I0=",mg.getNivelI0()," I1=",mg.getNivelI1()," I2=",mg.getNivelI2(), " I3=",mg.getNivelI3());
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
