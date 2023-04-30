class Container
{
  constructor()
  {
    this.elements = [];
  }
  
  redraw()
  {
    this.elements.forEach(element => {
        element.draw();
    });
  }
  
  addElement(element)
  {
    this.elements.push(element);
  }

  emptyContainer()
  {
    this.elements = [];
  }
}

class MessageContainer extends Container
{
  constructor()
  {
    super();
    this.x = 0;
    this.y = 0;
    this.margin = 0;
    this.baseLine = 0;
  }

  redraw(isSaving)
  {
    this.x = mouseStartX;
    if(this.elements.length != 0) this.y = mouseStartY + this.elements[0].maxLetterAscent() + this.elements[0].maxLetterDescent();
    else this.y = mouseStartY + this.baseLine;

    this.elements.forEach(letter => 
      {
        if(mouseStartX == 0 && mouseStartY == 0 && mouseEndX == 0 && mouseEndY == 0)
        {
          if(letter.letterWidth() + this.x > workingCopy.width)
          {
            if(this.y + letter.letterAscent() +  letter.letterDescent() < workingCopy.height)
            {
              this.y += (letter.letterAscent() +  letter.letterDescent());
              this.x = this.margin;
            }
            else
            {
              const index = this.elements.indexOf(letter);
              this.elements.splice(index, 1);
            } 
          }
          else
          {
            if(!isSaving) letter.printLetter(this.x, this.y);
            else letter.printLetterToGraphic(this.x, this.y);
            this.x += letter.letterWidth();
          }
        }
        else
        {
          if(letter.letterWidth() + this.x > mouseEndX)
          {
            if(this.y + letter.letterAscent() +  letter.letterDescent() < mouseEndY)
            {
              this.y += (letter.letterAscent() +  letter.letterDescent());
              this.x = mouseStartX;
            }
            else
            {
              const index = this.elements.indexOf(letter);
              this.elements.splice(index, 1);
            } 
          }
          else
          {
            if(!isSaving) letter.printLetter(this.x, this.y);
            else letter.printLetterToGraphic(this.x, this.y);
            this.x += letter.letterWidth();
          }
        }
      });
    
  }

  saveToGraphic()
  {
    this.redraw(true);
    super.emptyContainer();
    workingCopy.loadPixels();
  }

  addElement(letter, font, size, r, g, b)
  {
    this.elements.push(new Letter(letter, font, size, r, g, b));
  }

  deleteLastElement()
  {
    if(this.elements.length > 0)
    {
      this.elements.pop();
    }
  }


}


class Element
{
  constructor(sx, sy, r, g, b, size) 
  {
     this.sx = sx;
     this.sy = sy;
     
     this.r = r;
     this.g = g;
     this.b = b;

     this.size = size;
  }
  
  
}

class LineElement extends Element
{
    constructor(sx, sy, dx, dy, r, g, b, size) 
  {
     super(sx, sy, r, g, b, size);
     this.dx = dx;
     this.dy = dy;
  }

  draw()
  {
    workingCopy.push();
    workingCopy.stroke(this.r, this.g, this.b);
    workingCopy.strokeWeight(this.size);
    workingCopy.noFill();
    workingCopy.line(this.sx, this.sy, this.dx, this.dy);
    workingCopy.pop();

    workingCopy.loadPixels();
  }
  
}

class CircleElement extends Element
{
    constructor(sx, sy, r, g, b, size) 
  {
     super(sx, sy, r, g, b, size);
  }

  draw()
  {
    workingCopy.push();
    workingCopy.noStroke();
    workingCopy.fill(this.r, this.g, this.b);
    workingCopy.circle(this.sx, this.sy, this.size);
    workingCopy.pop();

    workingCopy.loadPixels();
  }
  
}

class Letter extends Element
{
  constructor(letter, font, size, r, g, b)
  {
    super(0, 0, r, g, b, size);
    this.letter = letter;
    this.font = font;

    if(this.font == fasthand) this.fontRatio = 0.45;
    else if(this.font == simpleMelody) this.fontRatio = 0.85;
    else this.fontRatio = 1;  
  }

  printLetter(x, y)
  {
    fill(this.r, this.g, this.b);
    textFont(this.font);
    textSize(this.size);
    text(this.letter, x, y);
  }

  printLetterToGraphic(x, y)
  {
    workingCopy.push();
    workingCopy.fill(this.r, this.g, this.b);
    workingCopy.textFont(this.font);
    workingCopy.textSize(this.size);
    workingCopy.text(this.letter, x, y);
    workingCopy.pop();
  }
  
  letterWidth()
  {
   textFont(this.font);
   textSize(this.size);
   return textWidth(this.letter); 
  }
  
  letterAscent()
  {
   textFont(this.font);
   textSize(this.size);
   return textAscent() * this.fontRatio; 
  }

  maxLetterAscent()
  {
    textFont(this.font);
    textSize(maxTextFontSize);
    return textAscent() * this.fontRatio; 
  }
  
  letterDescent()
  {
   textFont(this.font);
   textSize(this.size);
   return textDescent() * this.fontRatio; 
  }

  maxLetterDescent()
  {
    textFont(this.font);
    textSize(maxTextFontSize);
    return textDescent() * this.fontRatio; 
  }
  
}