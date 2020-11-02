PImage selectedimage;
boolean invertbutton = false;
int [] pixelsBackup;
boolean flipimagebutton = false;


void setup() {
  size(1280, 720);
  background(0);
  fill(255);
  textSize(30);

  text("press s to select a picture", width/2-300, height/2);
  text("press 1 to make the image black and white", width/2-300, height/2+ 50);
  text("press 2 to invert the image colors", width/2-300, height/2 + 100);
  text("press 3 to blur the image horizontally", width/2-300, height/2 -50);
  text("press r to tint the image red", width/2-300, height/2 -200);
  text("press g to tint the image green", width/2-300, height/2 -150);
  text("press b to tint the image blue", width/2-300, height/2 -100);
  text("press 0 to reset to the original image", width/2-300, height/2 +150);
}





void draw() {
  if (selectedimage != null) {
    image(selectedimage, 0, 0);
  }
}



void fileSelected(File selection) {
  
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    selectedimage = loadImage(selection.getAbsolutePath());
    
    selectedimage.resize(1280, 720);
    
    selectedimage.loadPixels();
    
    pixelsBackup = new int [selectedimage.pixels.length];



    for (int i = 0; i<selectedimage.pixels.length; i++) {

      pixelsBackup[i] = selectedimage.pixels[i];
    }
  }
}



void keyPressed() {

  if (key == 's') {

    selectInput("Select a file to process:", "fileSelected");
  }

  if (key == '1') makeGrayScale();

  if (key == '2') invertimage();

  if (key == '3') blur_horizontally();

  if (key == 'r' ) change_color(0);

  if (key == 'g') change_color(1);

  if (key == 'b') change_color(2);

  if (key == '0') setoriginalimage();
}


void setoriginalimage() {
  selectedimage.loadPixels();
  for (int i=0; i < pixelsBackup.length; i++) {
    selectedimage.pixels[i] = pixelsBackup[i];
  }
  selectedimage.updatePixels();
  image(selectedimage, 0, 0);
}



void blur_horizontally() {
  selectedimage.loadPixels();
  float red_average = 0;
  float green_average = 0;
  float blue_average = 0;

  for (int i = 0; i < selectedimage.pixels.length; i= i+3) {
    red_average = red_average + red(selectedimage.pixels[i]);
    green_average = green_average + green(selectedimage.pixels[i]);
    blue_average = blue_average + blue(selectedimage.pixels[i]);
    if (i % 1000000 == 0 || i % 1000000  == 0) {
    } else {
      red_average = red_average + red(selectedimage.pixels[i-1]);
      green_average = green_average + green(selectedimage.pixels[i-1]);
      blue_average = blue_average + blue(selectedimage.pixels[i-1]);

      red_average = red_average + red(selectedimage.pixels[i+1]);
      green_average = green_average + green(selectedimage.pixels[i+1]);
      blue_average = blue_average + blue(selectedimage.pixels[i+1]);



      red_average = red_average/4;
      green_average = green_average/4;
      blue_average = blue_average/4;

      selectedimage.pixels[i] = color (red_average, green_average, blue_average);
      selectedimage.pixels[i-1] = color (red_average, green_average, blue_average);
      selectedimage.pixels[i+1] = color (red_average, green_average, blue_average);
      selectedimage.updatePixels();
    }
  }
}





void makeGrayScale() {
  for (int i = 0; i<selectedimage.pixels.length; i++) {

    float r = red(selectedimage.pixels[i]);
    float g = green(selectedimage.pixels[i]);
    float b = blue(selectedimage.pixels[i]);

    float avg = (r + g + b)/3;

    selectedimage.pixels[i] = color(avg, avg, avg);
  }

  selectedimage.updatePixels();
}




void change_color(int rgbvalue) {

  if (rgbvalue == 0) {
    for (int k=0; k<selectedimage.height; k++) { 
      for (int j=0; j<selectedimage.width; j++) { 
        int currentpix = j+k*selectedimage.width;
        float r = red((selectedimage.pixels[currentpix]));
        float g = green((selectedimage.pixels[currentpix]%1));
        float b = blue((selectedimage.pixels[currentpix])%1);
        selectedimage.pixels[currentpix] = color(r, g, b);
      }
    }
    selectedimage.updatePixels();
    image(selectedimage, 0, 0);
  }

  if (rgbvalue == 1) {
    for (int k=0; k<selectedimage.height; k++) {
      for (int j=0; j<selectedimage.width; j++) {
        int currentpix = j+k*selectedimage.width;
        float r = red((selectedimage.pixels[currentpix]%1));
        float g = green((selectedimage.pixels[currentpix]));
        float b = blue((selectedimage.pixels[currentpix]%1));
        selectedimage.pixels[currentpix] = color(r, g, b);
      }
    }
    selectedimage.updatePixels();
    image(selectedimage, 0, 0);
  }

  if (rgbvalue == 2) {
    for (int k=0; k<selectedimage.height; k++) { 
      for (int j=0; j<selectedimage.width; j++) { 
        int currentpix = j+k*selectedimage.width;
        float r = red((selectedimage.pixels[currentpix]%1));
        float g = green((selectedimage.pixels[currentpix]%1));
        float b = blue((selectedimage.pixels[currentpix]));
        selectedimage.pixels[currentpix] = color(r, g, b);
      }
    }
    selectedimage.updatePixels();
    image(selectedimage, 0, 0);
  }
}

void invertimage() {
  invertbutton = true;


  if (invertbutton == true) {
    fill(255, 0, 0);
    for (int k=0; k<selectedimage.height; k++) {
      for (int j=0; j<selectedimage.width; j++) {
        int currentpix = j+k*selectedimage.width;
        float r = red(abs(selectedimage.pixels[currentpix]-255));
        float g = green(abs(selectedimage.pixels[currentpix]-255));
        float b = blue(abs(selectedimage.pixels[currentpix]-255));
        selectedimage.pixels[currentpix] = color(r, g, b);
      }
    }
    selectedimage.updatePixels();
    image(selectedimage, 0, 0);
  }
}
