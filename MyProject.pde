// Class: CS 6491
// Semester: Fall 2020
// Project number: 1
// Project title: Morphing Arrows
// Student(s): Chen LIU

//======================= My global variables
PImage PictureOfMyFace; // picture of author's face, should be: data/pic.jpg in sketch folder
PImage PictureOfBanner; // picture of banner, should be: data/pic.jpg in sketch folder

boolean lerp=true, spiral=true; // toggles to display vector interpoations
float b=0, c=0.5, d=1; // initial knots
int partShown = 0;
//String [] PartTitle = new String[10];
String [] PartTitle = {"?","?","?","?","?","?","?","?","?","?"};


int numberOfParts = PartTitle.length;
PNTS DrawnPoints = new PNTS(); // class containing array of points, used to standardize GUI
PNTS SmoothenedPoints = new PNTS(); // class containing array of points, used to standardize GUI
DUCKS DucksRow = new DUCKS(20);

//**************************** My text  ****************************
String title = "Class: 6491, Year: 2020, Project 01",
       name = "Chen LIU";
String subtitle = "Playing with ARROWS";    
String guide="MyProject keys: '0' through '9' to select project parts, 'a' to start/stop animation "; // help info

//======================= my setup, executed once at the beginning 
void mySetup()
  {
  DrawnPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  SmoothenedPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  DrawnPoints.empty(); // reset pont list P
  SmoothenedPoints.empty(); // reset pont list P
  //initDucklings(); // creates Ducling[] points
  }

//======================= called in main() and executed at each frame to redraw the canvas
void showMyProject(ARROW A, ARROW B) // four points used to define 3 vectors
  {
  if(0<=partShown && partShown<numberOfParts)
    {
    switch(partShown) 
      {
      case 0: showPart0(A,B); break;
      case 1: showPart1(A,B); break;
      case 2: showPart2(A,B); break;
      case 3: showPart3(A,B); break;
      case 4: showPart4(A,B); break;
      case 5: showPart5(A,B); break;
      case 6: showPart6(A,B); break;
      case 7: showPart7(A,B); break;
      case 8: showPart8(A,B); break;
      case 9: showPart9(A,B); break;
      }
    }
  }
  
//====================================================================== PART 0
void showPart0(ARROW A, ARROW B) //
  {
  PartTitle[0] = "Experimenting sandbox";

  ARROW A025  = SAM(A,B,0.25);   show(A025,myColors[0]);
  ARROW A050  = SAM(A,B,0.50);   show(A050,green);
  ARROW A075  = SAM(A,B,0.75);   show(A075,myColors[2]);

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }

//====================================================================== PART 1
void showPart1(ARROW A, ARROW B) {
  PartTitle[1] = "Linear Morph of Arrows (LMoA)";
  showLinearPatternOfArrows(A, B, 31);
  ARROW A25 = ArrowLinearMorph(A, B, 0.25);
  show(A25, black);
  ARROW A50 = ArrowLinearMorph(A, B, 0.5);
  show(A50, green);
  ARROW A75 = ArrowLinearMorph(A, B, 0.75);
  show(A75, blue);
  ARROW At = ArrowLinearMorph(A, B, currentTime);
  show(At, yellow);
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
}

void showLinearPatternOfArrows(ARROW A, ARROW B, int quads) {
  cwf(black,2,cyan);
  beginShape(QUAD_STRIP); 
  for(int f=0; f<=quads; f++)
      {
      float s=(float)f/quads; 
      ARROW N =  ArrowLinearMorph(A,B,s); 
      PNT rP = N.rP();
      PNT rQ = N.rQ();
      v(rP);
      v(rQ);
      }
  endShape();
}
  
//====================================================================== PART 2
void showPart2(ARROW A, ARROW B) {
  PartTitle[2] = "Steady Morph of Arrows (SMoA)";
  showSAMPatternOfArrows(A, B, 31);
  ARROW A25 = ArrowSteadyMorph(A, B, 0.25);
  show(A25, black);
  ARROW A50 = ArrowSteadyMorph(A, B, 0.5);
  show(A50, green);
  ARROW A75 = ArrowSteadyMorph(A, B, 0.75);
  show(A75, blue);
  ARROW At = ArrowSteadyMorph(A, B, currentTime);
  show(At, yellow);
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
}
 
void showSAMPatternOfArrows(ARROW A, ARROW B, int quads) {
  cwf(black, 2, cyan);
  beginShape(QUAD_STRIP); 
  for(int f=0; f<=quads; f++)
      {
      float s=(float)f/quads; 
      ARROW N =  SAM(A,B,s); 
      PNT rP = N.rP();
      PNT rQ = N.rQ();
      v(rP);
      v(rQ);
      }
  endShape();
}

//====================================================================== PART 3
void showPart3(ARROW A, ARROW B) {
  PartTitle[3] = "Polar Morph of Arrows";
  showPolarPatternOfArrows(A, B, 31);
  ARROW A25 = ArrowPolarMorph(A, B, 0.25);
  show(A25, black);
  ARROW A50 = ArrowPolarMorph(A, B, 0.5);
  show(A50, green);
  ARROW A75 = ArrowPolarMorph(A, B, 0.75);
  show(A75, blue);
  ARROW At = ArrowPolarMorph(A, B, currentTime);
  show(At, yellow);
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
}

void showPolarPatternOfArrows(ARROW A, ARROW B, int quads) {
  cwf(black, 2, cyan);
  beginShape(QUAD_STRIP); 
  for(int f=0; f<=quads; f++)
      {
      float s=(float)f/quads; 
      ARROW N =  ArrowPolarMorph(A,B,s); 
      PNT rP = N.rP();
      PNT rQ = N.rQ();
      v(rP);
      v(rQ);
      }
  endShape();
}

 //====================================================================== PART 4
void showPart4(ARROW A, ARROW B) //
  {
  PartTitle[4] = "Extrapolate with Two Arrows (Seashell)";
  VCT AVec = A.rV();
  VCT BVec = B.rV();
  float AtoBAngle = angle(AVec, BVec);
  float scaling = B.rm() / A.rm();
  PNT AStart = A.rP();
  PNT BStart = B.rP();
  showLinearPatternOfArrows(A, B, 1);
  
  for (int i = 0; i < 50; i++) {
    VCT scaledRotatedStartToStart = V(scaling, R(V(AStart, BStart), AtoBAngle));
  
    VCT CVec = V(scaling, R(BVec, AtoBAngle));
    PNT CStart = P(BStart, scaledRotatedStartToStart);
    show(CStart, CVec, blue);
    
    showLinearPatternOfArrows(Arrow(BStart, BVec), Arrow(CStart, CVec), 1);
    
    AStart = BStart;
    BStart = CStart;
    AVec = BVec;
    BVec = CVec;
  }

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }

 //====================================================================== PART 5
void showPart5(ARROW A, ARROW B) {
  PartTitle[5] = "Pendulum";
  easeInOut = false;

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  
  // Compute pivot position
  float angleAB = abs(angle(A.rV(), B.rV()));
  PNT ATail = A.rP();
  PNT BTail = B.rP();
  ARROW C = new ARROW(ATail, BTail);
  float angleBC = abs(angle(B.rV(), C.rV()));
  float distPivotToA = C.rm() / sin(angleAB) * sin(angleBC);
  float angleAC = abs(angle(A.rV(), C.rV()));
  float distPivotToB = C.rm() / sin(angleAB) * sin(angleAC);
  VCT reversedAVec = V(-distPivotToA / A.rm(), A.rV());
  PNT pivot = P(A.rP(), reversedAVec);
  circledLabel(pivot, "P");
  
  VCT verticalVec = new VCT(0, 1000);
  float angleASwing = abs(angle(A.rV(), verticalVec));
  float angleBSwing = abs(angle(B.rV(), verticalVec));
  
  float maxSwing = max(angleASwing, angleBSwing);
  float swingAtTime = maxSwing * cos(PI * currentTime);
  ARROW pendulum = new ARROW(pivot, R(verticalVec, swingAtTime));
  
  PNT pendulumEnd = P(pivot, pendulum.rV());
  stroke(240);
  line(pivot.x, pivot.y, pendulumEnd.x, pendulumEnd.y);
  
  // Calculate time when the pendulum sweeps past A or B
  float timeAtA = acos(angleASwing / maxSwing) / PI;
  float timeAtB = acos(-angleBSwing / maxSwing) / PI;
  
  // Calculate the speed that the distance from pivot to the tail of arrow changes
  float distPivotToArrowSpeed = (distPivotToA - distPivotToB) / (timeAtA - timeAtB);
  float initialDist = distPivotToA - distPivotToArrowSpeed * timeAtA;
  float currentDist = initialDist + distPivotToArrowSpeed * currentTime;
  
  // Calculate the speed that arrow magnitude changes
  float magnitudeSpeed = (A.rm() - B.rm()) / (timeAtA - timeAtB);
  float initialMagnitude = A.rm() - magnitudeSpeed * timeAtA;
  float currentMagnitude = initialMagnitude + magnitudeSpeed * currentTime;
  
  VCT pivotToArrowVec = R(new VCT(0, currentDist), swingAtTime);
  PNT interpolatedTail = P(pivot, pivotToArrowVec);
  VCT interpolatedVec = V(currentMagnitude / currentDist, pivotToArrowVec);
  ARROW interpolatedArrow = new ARROW(interpolatedTail, interpolatedVec);
  show(interpolatedArrow, black);
}

 //====================================================================== PART 6
void showPart6(ARROW A, ARROW B) //
  {
  PartTitle[6] = "six?";

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }

 //====================================================================== PART 7
void showPart7(ARROW A, ARROW B) //
  {
  PartTitle[7] = "seven?";

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }

 //====================================================================== PART 8
void showPart8(ARROW A, ARROW B) //
  {
  PartTitle[8] = "eight?";

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }

 //====================================================================== PART 9
void showPart9(ARROW A, ARROW B) //
  {
  PartTitle[9] = "nine?";

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  show(A,dred); show(B,blue);
  }








    
//======================= called when a key is pressed
void myKeyPressed()
  {
  //int k = int(key); if(47<k && k<58) partShown=int(key)-48;
  if(key=='<') {DucksRow.decrementCount(); }
  if(key=='>') {DucksRow.incrementCount(); }
  }
  
//======================= called when the mouse is dragged
void myMouseDragged()
  {
  if (keyPressed) 
    {
    //if (key=='b') b+=2.*float(mouseX-pmouseX)/width;  // adjust knot value b    
    //if (key=='c') c+=2.*float(mouseX-pmouseX)/width;  // adjust knot value c    
    //if (key=='d') d+=2.*float(mouseX-pmouseX)/width;  // adjust knot value a 
    }
  }

//======================= called when the mouse is pressed 
void myMousePressed()
  {
  if (!keyPressed) 
    {
    if(partShown==2 || partShown==3)
      {
      }
    }
  }
  
