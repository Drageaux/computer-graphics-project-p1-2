// Class: CS ???? 
// Semester: Fall ??
// Project number: ??
// Project title: ??
// Student(s):

//======================= My global variables
PImage PictureOfMyFace; // picture of author's face, should be: data/pic.jpg in sketch folder
PImage PictureOfBanner; // picture of banner, should be: data/pic.jpg in sketch folder

boolean lerp=true, spiral=true; // toggles to display vector interpoations
float b=0, c=0.5, d=1; // initial knots
//String [] PartTitle = new String[10];
String [] titleOfStep = {"?","?","?","?","?","?","?","?","?","?"};
int partShown = 0;

// My Animation
int MyFramesInAnimation=63;
int myCurrentFrame=0; // counting frames for animating my arrow morphs 
float myTime=0; // my time for animating my arrow morphs 

int numberOfParts = titleOfStep.length;
PNTS DrawnPoints = new PNTS(); // class containing array of points, used to standardize GUI
PNTS SmoothenedPoints = new PNTS(); // class containing array of points, used to standardize GUI
DUCKS DucksRow = new DUCKS(20);

//**************************** My text  ****************************
String title ="Class: 6491, Year: 2020, Project 02",            
       name ="Students: Chen LIU, Thong NGUYEN, Nishit UNDALE";
String subtitle = "Voronoi graph traversal";    
String guide="MyProject keys: '0' through '9' to activate steps, 'a' to start/stop animation "; // help info

//**************************** Color Ramp  ****************************
COLOR_RAMP colors = new COLOR_RAMP(65);

// Toggles for the project
Boolean 
  showDisks=true, 
  showPillars=true,
  showRobot=true,
  showTriangles=true,
  showVertices=true,
  showEdges=true,
  showVisitedTriangles=false,
  showCorner=true,
  showOpposite=false,
  showVoronoiFaces=true,
  showVoronoiEdges=true,
  showVoronoiArcs=true,

  step0=true,
  step1=false,
  step2=false,
  step3=false,
  step4=false,
  step5=false,
  step6=false,
  step7=false, // true,
  step8=false,
  step9=false,

  live=true;   // updates mesh at each frame

//************************************************************************
//**** DISK CLASS
//************************************************************************
class DISK 
  { 
  PNT center;
  VCT velocity;
  color status;
  VCT radius;
  
  // for debugging
  DISK write() {print("Center: ("+center.x+","+center.y+"); Velocity: "+velocity+""); return this;};  // writes point coordinates in text window
  
  
  } // end of DISK class

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
void showMyProject(PNTS MySites) // four points used to define 3 vectors
  {
  if(myCurrentFrame==MyFramesInAnimation) myCurrentFrame=0;
  myTime = (float)myCurrentFrame++/MyFramesInAnimation;
  if(easeInOut) myTime = easeInOut(0,0.5,1,myTime);    

  if(live)
    {
    //M.reset(); 
    //M.loadVertices(R.G,R.nv); 
    //M.triangulate();
    //M.computeOfast();
    //M.classifyVertices();
    //M.resetVisitedTriangles();
    //M.resetDiscoveredPillars();
    //M.resetVisiblePillars();
    //M.resetVisitedPillars();
    }
    
  if(step0) doStep0(MySites); 
  if(step1) doStep1(MySites); 
  if(step2) doStep2(MySites); 
  if(step3) doStep3(MySites); 
  if(step4) doStep4(MySites); 
  if(step5) doStep5(MySites); 
  if(step6) doStep6(MySites); 
  if(step7) doStep7(MySites); 
  if(step8) doStep8(MySites); 
  if(step9) doStep9(MySites); 
  
  textAlign(LEFT,BOTTOM);
  f(red); 
  int line=2, s=0;
  if(scribeText)
    {
    if(step0) scribeHeader("Step 0: "+titleOfStep[0],line++); 
    if(step1) scribeHeader("Step 1: "+titleOfStep[1],line++); 
    if(step2) scribeHeader("Step 2: "+titleOfStep[2],line++); 
    if(step3) scribeHeader("Step 3: "+titleOfStep[3],line++); 
    if(step4) scribeHeader("Step 4: "+titleOfStep[4],line++); 
    if(step5) scribeHeader("Step 5: "+titleOfStep[5],line++); 
    if(step6) scribeHeader("Step 6: "+titleOfStep[6],line++); 
    if(step7) scribeHeader("Step 7: "+titleOfStep[7],line++); 
    if(step8) scribeHeader("Step 8: "+titleOfStep[8],line++); 
    if(step9) scribeHeader("Step 9: "+titleOfStep[9],line++); 
    }
    textAlign(CENTER,CENTER);
  }


//====================================================================== PART 0
void doStep0(PNTS MySites) //
  {
  titleOfStep[0] = "Show and edit sites";
  cwf(black,6,yellow); show(ScreenCenter(),ringRadius); // ring
  cwF(dgreen,1); if(showIDs) Sites.writeIDsInEmptyDisks();
  cwF(dred,1); if(showIDs) Sites.showPickedPoint(16);
  guide="My keys: '0'...'9' to activate/deactivate step";
  }

//====================================================================== PART 1
void doStep1(PNTS R) //
  {
  titleOfStep[1] = "Compute and show Delaunay Triangles";
  showIDs=false;
  if(live) 
    {
    M.reset();   
    M.loadVertices(R.G,R.pointCount); 
    M.triangulate(); 
    M.computeOfast();
  //  M.classifyVertices();    
    }
  cwf(black,2,green);
  if(showTriangles) M.drawTriangles();
  //if(showEdges) {cw(dgreen,4); M.showNonBorderEdges(); cw(dred,8); M.showBorderEdges();}
  if(showVertices) M.showVertices(6);
  guide="My keys: '0'...'9' to activate/deactivate step";
  
  
  //for (PNT i : M.G){
    
  //  i.write();
  //}
  }
  
//====================================================================== PART 2
void doStep2(PNTS MySites) //
  {
  titleOfStep[2] = "Smoothing interior vertices";
  //for(int i=0; i<10; i++) 
  //  {
  //  M.smoothenInterior(0.1); 
  //  M.smoothenInterior(-0.1); 
  //  }
  guide="My keys: '0'...'9' to activate/deactivate step";
  }

//====================================================================== PART 3
void doStep3(PNTS MySites) //
  {
  titleOfStep[3] = "Corner operators";
    live=false;  
    fill(magenta); 
    if(showCorner) M.showCurrentCorner(5); 
  guide="My keys: '0'...'9' to activate/deactivate step";
  }

 //====================================================================== PART 4
void doStep4(PNTS MySites) //
  {
    titleOfStep[4] = "???";
    guide="My keys: '0'...'9' to activate/deactivate step";
    //for (PNT p : MySites.G) {
    //  System.out.println(p);
    //}
    //System.out.println(myTime);
    //System.out.println("MyFramesInAnimation:" + MyFramesInAnimation);
    // Phase A naive approach to find exact future collision time
    // first, find time t to first collision
    // for each disk, and for all its neighbors, find the closest neighbor
      
      
    for (int i = 0; i < MySites.pointCount; i++) {
    
      // initial vectors/velocity 
      float smallestTtc = -1;
      int nextImpactIndex = -1;
      for (int j = 0; j < MySites.pointCount; j++) {
        if (i != j) {
          float ttc = ttc(MySites.G[i], MySites.G[j], MySites.movements[i], MySites.movements[j], 26);
          // replace default ttc of -1 with new ttc
          // otherwise check if new ttc is smaller than current smallest 
          if (smallestTtc == -1 || (ttc > -1 && smallestTtc > ttc)){
            smallestTtc = ttc;
            nextImpactIndex = j;
          }          
        }
      }
      float ringTtc = ttc(MySites.G[i], ScreenCenter(), MySites.movements[i], V(), ringRadius - 13);
      // check if smallest TTC is positive
      if (smallestTtc > ringTtc){
          smallestTtc = ringTtc;
          nextImpactIndex = 91;
      }
      if (smallestTtc > 0 && nextImpactIndex > -1){
        if (nextImpactIndex == 91){
          System.out.println("smallest TTC for " + i + ": is with wall after " + smallestTtc + "s");
        } else {
           System.out.println("smallest TTC for " + i + ": is with " + nextImpactIndex + " after " + smallestTtc + "s");  
        }
      
      
        float w = 1./MyFramesInAnimation;
        if (smallestTtc > -1 && nextImpactIndex > -1){
          if (smallestTtc < w){
        
            //System.out.println("smallest TTC for " + i + ": is " + nextImpactIndex + " after " + smallestTtc + "s");
            //System.out.println("w is " + w);
            MySites.G[i].add(smallestTtc, MySites.movements[i]);
            w = w - smallestTtc;
            if(nextImpactIndex <= 90){
              VCT collision_vector = V(MySites.G[i].x - MySites.G[nextImpactIndex].x, MySites.G[i].y - MySites.G[nextImpactIndex].y);
              //collision_vector.write();
              
              VCT collision_norm = V(collision_vector.x / collision_vector.norm(), collision_vector.y / collision_vector.norm());
              
              //ARROW arrow = new ARROW(MySites.G[i], V(2, collision_norm));
              //show(arrow, blue);
              VCT i_normal = V(collision_norm.x * (dot(MySites.movements[i], collision_norm)), collision_norm.y * (dot(MySites.movements[i], collision_norm)));
              VCT j_normal = V(collision_norm.x * (dot(MySites.movements[nextImpactIndex], collision_norm)), collision_norm.y * (dot(MySites.movements[nextImpactIndex], collision_norm)));
             
              //ARROW inormalarr = new ARROW(MySites.G[i], V(1, i_normal));
              //show(inormalarr, orange);
              //ARROW jnormalarr = new ARROW(MySites.G[nextImpactIndex], V(1, j_normal));
              //show(jnormalarr, orange);
              //ARROW v1original = new ARROW(MySites.G[i], V(1, MySites.movements[i]));
              //show(v1original, green);
              //ARROW v2original = new ARROW(MySites.G[nextImpactIndex], V(1, MySites.movements[nextImpactIndex]));
              //show(v2original, green);
              
              MySites.movements[i] = V(MySites.movements[i].x-i_normal.x+j_normal.x, MySites.movements[i].y-i_normal.y+j_normal.y);             
              MySites.movements[nextImpactIndex] = V(MySites.movements[nextImpactIndex].x-j_normal.x+i_normal.x, MySites.movements[nextImpactIndex].y-j_normal.y+i_normal.y);
              
              //ARROW v1after = new ARROW(MySites.G[i], V(1, MySites.movements[i]));
              //show(v1after, red);
              //ARROW v2after = new ARROW(MySites.G[nextImpactIndex], V(1, MySites.movements[nextImpactIndex]));
              //show(v2after, red);
              
            }
            else{
              VCT collision_vector = V(MySites.G[i].x - ScreenCenter().x, MySites.G[i].y - ScreenCenter().y);
              collision_vector.write();
              VCT collision_norm = V(collision_vector.x / collision_vector.norm(), collision_vector.y / collision_vector.norm());
              //ARROW arrow = new ARROW(MySites.G[i], V(2, collision_norm));
              //show(arrow, blue);
              VCT i_normal = V(collision_norm.x * (dot(MySites.movements[i], collision_norm)), collision_norm.y * (dot(MySites.movements[i], collision_norm)));
              VCT j_normal = V(i_normal.reverse());
              //ARROW inormalarr = new ARROW(MySites.G[i], V(1, i_normal));
              //show(inormalarr, black);
              //ARROW jnormalarr = new ARROW(MySites.G[nextImpactIndex], V(1, j_normal));
              //show(jnormalarr, orange);
              ARROW v1original = new ARROW(MySites.G[i], V(1, MySites.movements[i]));
              show(v1original, green);
              MySites.movements[i] = V(MySites.movements[i].x-j_normal.x+i_normal.x, MySites.movements[i].y-j_normal.y+i_normal.y);
              //ARROW v1after = new ARROW(MySites.G[i], V(1, MySites.movements[i]));
              //show(v1after, red);
            }
          
          }
          //ARROW v = new ARROW(MySites.G[i], V(1, MySites.movements[i]));
          //show(v, red);
          MySites.G[i].translate(w,MySites.movements[i]);
        }
      }
    }
  }
  
float ttc(PNT p1, PNT p2, VCT v1, VCT v2, float radius) {
  float a = sq(v1.x-v2.x) + sq(v1.y-v2.y);
  float b = 2 * ( (p1.x-p2.x)*(v1.x-v2.x) + (p1.y-p2.y)*(v1.y-v2.y) );
  float c = sq(p1.x-p2.x) + sq(p1.y-p2.y) - sq(radius);
  
  float test1 = (-b + sqrt(sq(b)-(4*a*c))) / (2*a);
  float test2 = (-b - sqrt(sq(b)-(4*a*c))) / (2*a);
  
  // if no negative
  if (test1 > 0 && test2 > 0){
    if (test1 < test2){return test1;}
    else return test2;
  }
  // if 1 negative
  if (test1 > 0 && test2 < 0){
    //System.out.println("test 1: " + test1);
    return test1; 
  } else if (test2 > 0 && test1 < 0){
    //System.out.println("test 2: " + test2);
    return test2; 
  }
  
  //System.out.println("no positive result");
  return -1;
}
  
 

 //====================================================================== PART 5
void doStep5(PNTS MySites) //
  {
  titleOfStep[5] = "???";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 6
void doStep6(PNTS MySites) //
  {
  titleOfStep[6] = "???";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }


 //====================================================================== PART 7
void doStep7(PNTS MySites) //
  {
  titleOfStep[7] = "???";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 8
void doStep8(PNTS MySites) //
  {
  titleOfStep[8] = "?";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 9
void doStep9(PNTS MySites) //
  {
  titleOfStep[9] = "?";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }


    
//======================= called when a key is pressed
void myKeyPressed()
  {
  if(key=='<') MyFramesInAnimation=max(9,MyFramesInAnimation/2);
  if(key=='>') MyFramesInAnimation*=2;
  println(MyFramesInAnimation);
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
  }
  
