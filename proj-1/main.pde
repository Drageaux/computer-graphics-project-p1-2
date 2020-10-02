// Course template for 2D projects provided by Prof. Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!
import java.awt.Toolkit;
import java.awt.datatransfer.*;

//**************************** global variables ****************************
// FONT TEXT
PFont font;
String MyText=""; // string copied from clipboard to be printed on canvas FAST
float stringX=0, stringY=0;

// Editable Control points or vertices of polyline,\ / polyloop
PNTS ControlPoints = new PNTS(); // class containing array of points, used to standardize GUI
boolean showIDs = true;

// Arrows
ARROW ArrowRed=Arrow(), ArrowGreen=Arrow(), ArrowBlue=Arrow(), ArrowMagenta=Arrow(), ArrowMetal=Arrow(), ArrowBanana=Arrow();
boolean first=true; // used to distinguish creation and update of arrows
boolean showFaceWarp=false; // used to distinguish creation and update of arrows
boolean showControlArrows=false;

// Animation
boolean animate=false;
float currentTime=0, warpedTime=0;  // current and warped time
int currentFrame=0; // frame to advance timing
int framesInAnimation=90; // intermediate frames for the whole animation 
boolean easeInOut=true;

void settings() {
  // Fixes "Profile GL4bc not available" error on my computer
  System.setProperty("jogl.disable.openglcore", "true");
  size(1000, 1000, P2D);
}

//**************************** initialization ****************************
void setup()               // executed once at the beginning 
  {
  //fullScreen(P2D, 2);
  //size(800, 800, P2D);     // window size (need P2D for texture mapping)
  //size(1000, 1000, P2D);     // window size (need P2D for texture mapping)
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing for drawing curves
  //PictureOfMyFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  PictureOfMyFace = loadImage("data/chen.jpg");  // load image from file JR.jpg in folder data *** replace that file with your pic of your own face
  PictureOfBanner = loadImage("data/GTbanner.jpg");  // load image from file GTbanner.jpg in folder data *** replace that file with your pic of your own face
  ControlPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  //ControlPoints.loadControlPointsFromFile("data/pts");  // loads points form file saved with this program
  //ControlPoints.resetPointsOnCircle(18); // uncomment to create new config with 8 or whatever number of points. Then edit them and save with 'S'
  declareArrows();
  loadControlArrows("data/arrows0");
  setPointsToArrows(ControlPoints); 
  int i=0;
  colorMode(HSB, 360, 100, 100); // Hue, saturation, brightness
  textureMode(NORMAL);
  font = loadFont("ChalkboardSE-Regular-32.vlw"); textFont(font, 24);
  loadControlArrows("data/arrows"+str(partShown)); 
  setPointsToArrows(ControlPoints);
  mySetup();
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  int i=0;
  background(white); // clear screen by painting white background
  
  textAlign(CENTER,CENTER);

  // advance animation (controlled by 'a')
  if(animate) 
    {
    if(currentFrame==framesInAnimation) currentFrame=0;
    currentFrame++; 
    if (currentFrame>framesInAnimation) {currentFrame=0; animate=false;}
    float t = (float)currentFrame/framesInAnimation;
    float ct=(1.-cos(TWO_PI*t))/2;
    if(easeInOut) currentTime=easeInOut(0,0.5,1,ct); 
    else currentTime=ct;
    }

  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  if(showQuadGrid) drawQuadGrid(50);
  if(showHexGrid) drawHexGrid(50);
  if(showKagomeGrid) drawKagomeGrid(50);


  // ============ arrows and images
  updateArrows(ControlPoints);
  ARROW ArrowLeft  = SAM(Arrow[0],Arrow[1],currentTime);
  ARROW ArrowRight = SAM(Arrow[2],Arrow[3],currentTime);
  
  
  

  // ************************************ Displays my project ************************************
  PNT A = ArrowLeft.rP(),  B = ArrowLeft.rQ(), C = ArrowRight.rP(), D = ArrowRight.rQ(); 
 
  if(!showFaceWarp) showMyProject(ArrowLeft,ArrowRight);
 
     
     
  //ControlPoints.writeIDsInEmptyDisks(); 


    // show animated face-warp comntrolled by two wiper-arrows, each animated using a steady similarity morph between two control arrows
  if(showFaceWarp && (!keyPressed || key!='e')) showBannerBetweenArrows(ArrowLeft, ArrowRight, PictureOfBanner, 255);
  if(showControlArrows) 
    {
    showArrows(); 
    show(ArrowLeft,dred);
    show(ArrowRight,dgreen);
    if(showIDs) showArrowIDs();
    }

  //if(MyText.length()>0) P(stringX,stringY).writeLabel(MyText,red); // text from clipboard written where mouse was when 'C' was pressed
  showTextFromClipBoard();
  
  showPointer(); // show mouse pointer and mouse and key pressed (will not show on pictures)

  textAlign(LEFT,BOTTOM);
  f(red);
  scribeHeader("Part "+str(partShown)+": "+PartTitle[partShown],3);
  f(black);
  scribeHeader("time = "+nf(currentTime,0,2),2);

  displayGuide(); // shows help for selected PART of myProject

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas


  if(filmingTIF && (animate || changed)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(filmingJPG && (animate || changed)) snapFrameToJPG(); // saves image on canvas as movie frame 
  if(snapTIFpicture) snapPictureToTIF();   
  if(snapJPGpicture) snapPictureToJPG();   
  changed=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  
