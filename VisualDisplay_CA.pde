/* Name: Caoimhín Arnott
 Student Number: 20104296
 Description of Assignment: Outputs an interactive display,
 using a theme of 'heads' watching you with dynamic 'eyes'.
 For instructions, please click and drag continuously. */

void setup() {
  size (1280, 720);
  surface.setLocation(0, 0);
  textSize(30);
}

color white = 255;
color black = 0;
color darkTeal = #014040;
color lightTeal = #03A678;
color orange = #F27405;
color crimson = #731702;

int cell = 80;
// Reference for a single cell's size in pixels. Hardcoded for consistency.
int gridToggle = 0;
// Toggles visibility for the grid. Triggered by the keyPressed() method using the key spacebar.
int rotationVariable = 0;
// Determines rotation values for triangles in the drawHeads method.

int tealAlternator = 1;
// Tracks sequential dark teal & light teal color designations
int orangeAlternator = 3;
// Tracks sequential orange & crimson color designations
int opacityVariable = 255;
// Determines opacity. Decremented on left mouse press in the mousePressed() method.

float randomRow = 0;
// Stores a random row value when the R key is pressed. Infuences the drawEyes method.
float randomColumn = 0;
// Stores a random column value when the R key is pressed. Infuences the drawEyes method.
int toggleAllEyes = 1;
// Toggles between the two modes of the drawEyes method.
float eyeSize = 0;
// Determines eye size. Incremented on left mouse press.

void draw() {
  drawGrid();
  drawHeads();
  fill(white);
  drawName();
  drawID();
}
/* Draws the grid (visibility is toggled by the spacebar key), head and eye shapes, and the name & ID text.
 Setting fill(white) ensures the text colour is white for name, ID, and on-screen instructions. */

void drawGrid() {
  background(black);
  if (gridToggle == 1) {
    strokeWeight(1);
    stroke(white);
  } else {
    noStroke();
  }
  float i = 1;
  do {
    line(width*(i/16), 0, width*(i/16), height);
    i++;
  } while (i <= 16);
  for (float j = 1; j <= 9; j++) {
    line(0, height*(j/9), width, height*(j/9));
  }
  noStroke();
}
/* Blanks the background to black each time the method is called.
 Loops draw the x & y axis grid lines respectively, but only when gridToggle is set to 1.
 Pressing the spacebar key toggles gridToggle on and off through the the keyPressed() method.
 noStroke() is included at the end so that all later shapes drawn do not also have the grid's white stroke. */

void drawHeads () {
  for (int row = 1; row < 9; row++) {
    for (int l = 0; l < 17; l++) {
      if (rotationVariable > 3) {
        rotationVariable = 0;
      }
      if ((tealAlternator > 2) || (tealAlternator < 1)) {
        tealAlternator = 1;
      }
      determineColor(tealAlternator);
      if ((rotationVariable == 0) && (row != 1) && (l != 16)) {
        triangle(cell*l, (cell/2)+(cell*(row-1)), (cell/2)+(cell*l), cell*row, (cell/2)+(cell*l), (cell*row)-cell);
      } else if ((rotationVariable == 1) && (row != 1) && (l != 16)) {
        triangle(cell*l, (cell/2)+(cell*(row-1)), cell*l-(cell/2), (cell*row)-cell, (cell/2)+(cell*l), (cell*row)-cell);
        drawEyes(cell*l, (cell/2)+(cell*(row-1)));
      } else if ((rotationVariable == 2) && (l != 0) && (row !=1)) {
        triangle(cell*l, (cell/2)+(cell*(row-1)), cell*l-(cell/2), (cell*row)-cell, cell*l-(cell/2), cell*row);
      } else if ((rotationVariable == 3) && (row != 8) && (l != 16)) {
        triangle(cell*l, (cell/2)+(cell*(row-1)), cell*l-(cell/2), cell*row, (cell/2)+(cell*l), cell*row);
      }
      if (l != 16) {
        rotationVariable++;
      }
    }
    rotationVariable += 2;
    tealAlternator++;
  }
}
/* drawHeads executes on 8 rows, with the nested loop executing 17 times per row.
 rotationVariable determines the rotation of the drawn triangle and increments with each loop.
 When either rotationVariable or tealAlternator are incremented 5 times, they are reassigned to their default values.
 Since there are 4 rotations possible, rotationVariable must notincrement on the 17th loop for pattern consistency.
 The determineColor method is called with tealAlternator as an argument to set the fill colour.
 tealAlternator is incremented one per row, giving each row an alternating colour.
 rotationVariable is also incremented by 2 when moving onto a new row, alternating the head motifs' spacing.
 */

void determineColor(int x) {
  if (x == 1) {
    fill(darkTeal, opacityVariable);
  } else if (x == 2) {
    fill(lightTeal, opacityVariable);
  } else if (x == 3) {
    fill(orange);
  } else if (x == 4) {
    fill(crimson);
  }
}
/* determineColor returns a color corresponding to a 1-4 int number passed to it.
 1-2 correspond with the teal colors, while 3-4 correspond with the orange/crimson colors. */

void drawEyes(int x, int y) {
  if (toggleAllEyes == 1) {
    determineColor(orangeAlternator);
    circle(x-(cell/4), y-(cell/16), eyeSizeCalc());
    circle(x+(cell/4), y-(cell/16), eyeSizeCalc());
    orangeAlternator++;
    if ((orangeAlternator > 4) || (orangeAlternator < 3)) {
      orangeAlternator = 3;
    }
  } else {
    fill(orange);
    if ((randomRow % 2) == 0) {
      circle((randomColumn*4)*cell-(cell*1.25), (randomRow*cell)-(cell*9/16), 6);
      circle((randomColumn*4)*cell-(cell*0.75), (randomRow*cell)-(cell*9/16), 6);
    } else {
      circle((randomColumn*4)*cell-(cell*3.25), (randomRow*cell)-(cell*9/16), 6);
      circle((randomColumn*4)*cell-(cell*2.75), (randomRow*cell)-(cell*9/16), 6);
    }
  }
}
/* drawEyes executes two ways depending on the value toggleAllEyes; pressing R or backspace alternates this toggle.
 For default toggleAllEyes =1, a pair of pair of 'eyes' i.e., circles are drawn for each 'head' on screen.
 The colours alternating between orangeAlternator values 3 (orange) & 4 (crimson) */

float eyeSizeCalc() {
  if (eyeSize != 0) {
    return 6+eyeSize;
  }
  return 0;
}
/* Determines the size of the eyes and returns a float value for the drawEyeCicles method.
 Left mouse presses will increment eyeSize; this method ensures there are no eyes until the mouse is pressed at least once.*/

void drawName () {
  String name = "Caoimhín Arnott";
  int i = 0;
  do {
    text(name.charAt(i), width/36+((width/16)*i), height / 18);
    i++;
  } while (i < name.length());
}
/* Outputs the name string one character at a time.
 charAt selects each letter in the string, one at a time, as i is incremented once per loop.
 The x axis coordinate begins halfway through the first grid cell, and is incremented by one cell's length per loop.
 The loop control variable terminates once it's looped a number of times equal to the length of the 'name' string. */

void drawID () {
  String id = "20104296";
  int i = 0;
  while (i < id.length()) {
    text(id.charAt(i), width/36+((width/16)*i), height*17/18);
    i++;
  }
}
// Outputs the 'id' string one character at a time; see 'drawName' method's comments for explanation

void mousePressed() {
  if (mouseButton == LEFT) {
    opacityVariable -= 63;
    eyeSize += 1.2;
    if (opacityVariable < 0) {
      opacityVariable = 255;
    }
    if (eyeSize > 5) {
      eyeSize = 0;
    }
  }
}
/*  If the left mouse button is pressed, the on-screen opacity decreases and the eyeSize increases.
 After four left mouse presses, the fifth press will restore both variables to their default values. */

void mouseClicked() {
  if (mouseButton == RIGHT) {
    save("spookyPeeps.png");
  }
}
//If the right mouse button is clicked, the current display will be saved as a PNG file.

void keyPressed() {
  if (key == 32) {
    gridToggle++;
    if (gridToggle >= 2) {
      gridToggle = 0;
    }
  }
  if ((key == 114) || (key == 82)) {
    toggleAllEyes = 0;
    randomColumn = int(random(1, 5));
    randomRow = int(random(2, 9));
  }
  if (key == 8) {
    toggleAllEyes = 1;
  }
}
/* Spacebar toggles a visible grid on and off by incrementing gridToggle. Only 0 and 1 values are possible.
 the r or R keys toggle a the toggleAllEyes variable to 0, i.e., off. This runs an alternate version of
 the drawEyes method, such that a single pair of eyes is drawn in a random 'head' on the page.
 */

void mouseDragged() {
  background(black);
  String instructions = ". mouse drag: instructions.. left mouse press: cycle transparency & eye size.. right mouse press: save image.. spacebar: toggle grid.. r key: randomly places one pair of eyes.. backspace: toggles all eyes back on";
  int rowCount = 2;
  String period = ".";
  float widthTracker = 1.3;
  int i = 0;
  while (i < instructions.length()) {
    String testString = instructions.substring(i, i+1);
    if (testString.equals(period) == true) {
      rowCount++;
      widthTracker = 1.3;
    }
    if (widthTracker == 3.3) {
      text(instructions.substring(i, i+1).toUpperCase(), widthTracker*(width/50), height*rowCount/18);
    } else
    {
      text(instructions.charAt(i), widthTracker*(width/50), height*rowCount/18);
    }
    widthTracker++;
    i++;
  }
}
/* Displays instructions onscreen when the mouse is dragged. The string continues onto a new line
 whenever a period is encountered. The first letter in a sentence (i.e., third character) is auto-capitalised. */
