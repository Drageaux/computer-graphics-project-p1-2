//************************************************************************
//**** TRIANGLES
//************************************************************************

// measures used for computing centroid and moment axis of polygon 
float triangleArea(PNT A, PNT B, PNT C) 
  {
  return dot(R(V(A,B)),V(A,C)) / 2; 
  }

float triangleMoment(PNT A, PNT B, PNT C) 
  {
  float b = d(A,B); 
  VCT T=U(A,B); 
  VCT N = R(T);
  VCT AC=V(A,C); 
  float h = dot(AC,N);
  float a = dot(AC,T);
  return ( b*b*b*h - a*b*b*h + a*a*b*h + b*h*h*h )/36.; 
  }
  
PNT TipOfEquilateralTriangle(PNT A, PNT B) {return P(A,R(V(A,B),PI/3));}

//*********** TRIANGLES
