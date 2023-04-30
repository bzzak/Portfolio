let canvas;
let canvasBackground;
let fasthand , simpleMelody;

let brushIcon, textFieldIcon;

let oryginal, workingCopy;
let mouseStartX, mouseStartY, mouseEndX, mouseEndY;
let oryginalR, oryginalG, oryginalB;

let brushSize, textFontSize;
let brushColor;
let currentFont;

let blurButton, restoreButton, brightButton, filterButton, saveButton;
let brushSwitch, textSwitch, colorSwitch, fontSwitch, imageSwitch;
let brushSlider, textSlider;
let toolSwitchRadius, colorSwitchRadius;
let buttonWidth, buttonHeight;

let saveIteration;

let paintMode, textMode;

let photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9;

let scrollValue, minScrollValue, maxScrollValue;

let message;
let messageContainer;

const buttonFontSize = 25;
const minTextFontSize = 7, maxTextFontSize = 55;
const minBrushSize = 1, maxBrushSize = 10;

function preload()
{
  canvasBackground = loadImage("img/katar_background.jpeg");

  fasthand = loadFont("fonts/Fasthand-Regular.ttf");
  simpleMelody = loadFont("fonts/SimpleMelody.ttf");

  photo1 = loadImage("img/photo1.jpg");
  photo2 = loadImage("img/photo2.jpeg");
  photo3 = loadImage("img/photo3.png");
  photo4 = loadImage("img/photo4.jpg");
  photo5 = loadImage("img/photo5.jpg");
  photo6 = loadImage("img/photo6.png");
  photo7 = loadImage("img/photo7.jpg");
  photo8 = loadImage("img/photo8.png");
  photo9 = loadImage("img/photo9.jpg");

  brushIcon = loadImage("svg/brush.svg");
  textFieldIcon = loadImage("svg/text.svg");
}



function setup() {
  canvas = createCanvas(0.99999 * windowWidth, 0.999999 * windowHeight);
  
  mouseStartX = 0;
  mouseStartY = 0;
  mouseEndX = 0;
  mouseEndY = 0;

  buttonWidth = 0.08 * windowWidth;
  buttonHeight = 0.05 * windowHeight;

  toolSwitchRadius = 0.03 * windowWidth;
  colorSwitchRadius = 0.03 * windowWidth;

  brushColor = [0,0,0];
  currentFont = fasthand;

  paintMode = false;
  textMode = false;

  scrollValue = 0;
  
  saveIteration = 1;

  message = "";
  messageContainer = new MessageContainer();

  blurButton = new BlurButton(0.03 * windowWidth, 0.83 * windowHeight, buttonWidth, buttonHeight, simpleMelody, buttonFontSize);
  restoreButton = new RestoreButton(0.75 * windowWidth, 0.83 * windowHeight, buttonWidth, buttonHeight, simpleMelody, buttonFontSize);
  brightButton = new BrightButton(0.03 * windowWidth, 0.92 * windowHeight, buttonWidth, buttonHeight, simpleMelody, buttonFontSize);
  filterButton = new FilterButton(0.13 * windowWidth, 0.83 * windowHeight, buttonWidth, buttonHeight, simpleMelody, buttonFontSize);
  saveButton = new SaveButton(0.75 * windowWidth, 0.92 * windowHeight, buttonWidth, buttonHeight, simpleMelody, buttonFontSize);

  brushSwitch = new ToolSwitch(0.16 * windowWidth + 2 * toolSwitchRadius + 0.15 * buttonWidth / 2, 0.92 * windowHeight + toolSwitchRadius + 0.8 * buttonHeight / 2, toolSwitchRadius, brushIcon);
  textSwitch = new ToolSwitch(0.13 * windowWidth + 2 * toolSwitchRadius - 0.4 * buttonWidth / 2, 0.92 * windowHeight + toolSwitchRadius + 0.8 * buttonHeight / 2, toolSwitchRadius, textFieldIcon);
  colorSwitch = new ExpandColorSwitch(0.25 * windowWidth, 0.83 * windowHeight + buttonHeight / 2, colorSwitchRadius );
  fontSwitch = new TextFontChoiceSwitch(0.22 * windowWidth, 0.92 * windowHeight, 0.18 * windowWidth , buttonHeight, [[fasthand, "FastHand Regular"],[simpleMelody, "SimpleMelody"]], 0, true);
  imageSwitch = new ImageChoiceSwitch(0.875 * windowWidth, 0.04 * windowHeight, 0.1 * windowWidth, 0.92 * windowHeight, [photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9], 0.06 * windowHeight, false);
  
  brushSlider = new Slider(0.43 * width, 0.83 * height + 0.23 * buttonHeight, 0.23 * width, buttonHeight / 2, simpleMelody, buttonFontSize, brushIcon, 0.65 * buttonHeight, minBrushSize, maxBrushSize);
  textSlider = new Slider(0.43 * width, 0.92 * height + 0.23 * buttonHeight, 0.23 * width, buttonHeight / 2, simpleMelody, buttonFontSize, textFieldIcon, 0.65 * buttonHeight, minTextFontSize, maxTextFontSize);

  brushSize = brushSlider.value;
  textFontSize = textSlider.value;

  minScrollValue = - (imageSwitch.h + imageSwitch.data.length * imageSwitch.space) + (imageSwitch.h / imageSwitch.data.length + imageSwitch.space) * 6 - 0.02 * imageSwitch.space;
  maxScrollValue = 0;

}

function draw() {
  background(canvasBackground);

  if(workingCopy != null)
  {
    image(workingCopy, 0, 0, workingCopy.width, workingCopy.height);
  }

  drawBottomPanel();
  drawSidePanel();

  //Drawing area of modification
  push();
  noFill();
  stroke(0);
  strokeWeight(3);
  rect(mouseStartX, mouseStartY, mouseEndX - mouseStartX, mouseEndY - mouseStartY);
  pop();

  //Drawing text in text mode
  if(textMode && workingCopy != null)
  {
    push();
    messageContainer.redraw(false);
    pop();
  }

  //Drawing folowing dot in paint mode
  if(paintMode && mouseX <= 0.85 * width &&  mouseY <=  0.8 * height)
  {
    push();
    noStroke();
    fill(brushColor[0], brushColor[1], brushColor[2]);
    circle(mouseX, mouseY, brushSize);
    pop();
  }

}

function drawSidePanel()
{
  push();
  noStroke();
  fill(70);
  rect(0.85 * windowWidth, 0, 0.15 * windowWidth, windowHeight);
  stroke(0);
  strokeWeight(5);
  line(0.85 * windowWidth, 0, 0.85 * windowWidth, windowHeight);
  imageSwitch.draw();
  pop();
}

function drawBottomPanel()
{
  push();
  
  noStroke();
  fill(129, 4, 62);
  rect(0, 0.8 * windowHeight, 0.85 * windowWidth, 0.2 * windowHeight);
  stroke(0);
  strokeWeight(5);
  line(0, 0.8 * windowHeight, 0.85 * windowWidth, 0.8 * windowHeight);
  pop();
  blurButton.draw();
  restoreButton.draw();
  brightButton.draw();
  filterButton.draw();
  saveButton.draw();
  brushSwitch.draw();
  textSwitch.draw();
  colorSwitch.draw();
  fontSwitch.draw();
  brushSlider.draw();
  textSlider.draw();
}

