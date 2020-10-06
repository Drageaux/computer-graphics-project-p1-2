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
int pointCount = 91;

void doStep4(PNTS centers) {
  titleOfStep[4] = "???";
  guide="My keys: '0'...'9' to activate/deactivate step";
  // Phase A naive approach to find exact future collision time
  // first, find time t to first collision
  // for each disk, and for all its neighbors, find the closest neighbor
  float frameEndTime = 1.0 / MyFramesInAnimation;
  float renderedTime = 0.0;
  
  while (renderedTime < frameEndTime) {
    // Find minimum ttc across all point pairs
    float minTtc = Float.MAX_VALUE;
    int impactDisk_i = -1, impactDisk_j = -1;
    for (int i = 45; i < 46; i++) {
      for (int j = 0; j < pointCount; j++) {
        if (i == j) {
          continue;
        }
        float ttc = ttc(centers.G[i], centers.G[j], centers.movements[i], centers.movements[j], 26);
        if (ttc != -1 && ttc < minTtc) {
          minTtc = ttc;
          impactDisk_i = i;
          impactDisk_j = j;
        }
      }
    }
    
    if (impactDisk_i == -1 || minTtc + renderedTime > frameEndTime) {
      for (int i = 45; i < 46; i++) {
        centers.G[i].add(frameEndTime - renderedTime, centers.movements[i]);
      }
      break;
    } else {
      for (int i = 45; i < 46; i++) {
        centers.G[i].add(minTtc, centers.movements[i]);
      }
      renderedTime += minTtc;
      
      VCT collision_vector_j_to_i = V(centers.G[impactDisk_i].x - centers.G[impactDisk_j].x, //<>//
                                      centers.G[impactDisk_i].y - centers.G[impactDisk_j].y);
      VCT collision_vector_i_to_j = V(-1, collision_vector_j_to_i);
      // Should have the same direction as normal component of velocity i
      VCT collision_norm_i = V(1.0 / collision_vector_j_to_i.norm(), collision_vector_j_to_i);
      // This could be the same or opposite of collision_norm_i
      VCT collision_norm_j = V(collision_norm_i);
      
      if (dot(centers.movements[impactDisk_i], collision_norm_i) < 0) {
        collision_norm_i = V(-1, collision_norm_i);
      }
      if (dot(centers.movements[impactDisk_j], collision_norm_j) < 0) {
        collision_norm_j = V(-1, collision_norm_j);
      }
      
      VCT i_normal = V(dot(centers.movements[impactDisk_i], collision_norm_i), collision_norm_i);
      VCT j_normal = V(dot(centers.movements[impactDisk_j], collision_norm_j), collision_norm_j);
      
      VCT i_tangent = V(centers.movements[impactDisk_i], V(-1.0, i_normal));
      VCT j_tangent = V(centers.movements[impactDisk_j], V(-1.0, j_normal));
      
      VCT new_i_vel = V(i_tangent, dot(collision_vector_j_to_i, j_normal) > 0 ? j_normal : V(-1, j_normal));
      VCT new_j_vel = V(j_tangent, dot(collision_vector_i_to_j, i_normal) > 0 ? i_normal : V(-1, i_normal));
      
      centers.movements[impactDisk_i] = new_i_vel;
      centers.movements[impactDisk_j] = new_j_vel;
      
      println("Collision! " + (System.currentTimeMillis() % 1000));
    }
  }
  
  for (int i = 0; i < pointCount; i++) {
    ARROW arrow = new ARROW(centers.G[i], V(0.6, centers.movements[i]));
    show(arrow, blue);
  }
}
  
float ttc(PNT p1, PNT p2, VCT v1, VCT v2, float radius) {
  // If their norm vectors are point away from each other, no way they are colliding
  VCT collision_vector = V(p1.x - p2.x, p1.y - p2.y);
  float norm1 = dot(v1, collision_vector);
  float norm2 = dot(v2, collision_vector);
  if ((norm1 < 0) != (norm2 < 0)) {
    return -1;
  }
  
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
  if (test1 > 0){
    //System.out.println("test 1: " + test1);
    return test1; 
  } else if (test2 > 0){
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
  
