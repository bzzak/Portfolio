class Button
{
  constructor(x, y, w, h, font, fontSize, highLightCounter = 0)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.font = font;
    this.fontSize = fontSize;
    this.highLightCounter = highLightCounter;
  }
}

class BlurButton extends Button
{
 
  constructor(x, y, w, h, font, fontSize)
  {
   super(x, y, w, h, font, fontSize); 
  }
  
  draw()
  {
    push();
    if(this.highLightCounter > 0) fill(201, 13, 101);
    else fill(250, 68, 153);
    strokeWeight(3);
    rect(this.x, this.y, this.w, this.h, 20);
    textFont(this.font);
    fill(0, 0, 0);
    textSize(this.fontSize);
    textAlign(CENTER, CENTER);
    text("Blur" ,this.x + this.w / 2, this.y + this.h / 2);
    if(this.highLightCounter > 0) this.highLightCounter--;
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLightCounter = 10;
      if(workingCopy != null)
      {
        blur();
        return true;
      }
    }

    return false;
  }
}


class BrightButton extends Button
{
 
  constructor(x, y, w, h, font, fontSize)
  {
   super(x, y, w, h, font, fontSize); 
  }
  
  draw()
  {
    push();
    if(this.highLightCounter > 0) fill(201, 13, 101);
    else fill(250, 68, 153);
    strokeWeight(3);
    rect(this.x, this.y, this.w, this.h, 20);
    textFont(this.font);
    fill(0, 0, 0);
    textSize(this.fontSize);
    textAlign(CENTER, CENTER);
    text("Brighten" ,this.x + this.w / 2, this.y + this.h / 2);
    if(this.highLightCounter > 0) this.highLightCounter--;
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLightCounter = 10;
      if(workingCopy != null)
      {
        bright();
        return true;
      }
    }

    return false;
  }
}


class FilterButton extends Button
{
 
  constructor(x, y, w, h, font, fontSize)
  {
   super(x, y, w, h, font, fontSize); 
  }
  
  draw()
  {
    push();
    if(this.highLightCounter > 0) fill(201, 13, 101);
    else fill(250, 68, 153);
    strokeWeight(3);
    rect(this.x, this.y, this.w, this.h, 20);
    textFont(this.font);
    fill(0, 0, 0);
    textSize(this.fontSize);
    textAlign(CENTER, CENTER);
    text("Gray" ,this.x + this.w / 2, this.y + this.h / 2);
    if(this.highLightCounter > 0) this.highLightCounter--;
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLightCounter = 10;
      if(workingCopy != null)
      {
        gray();
        return true;
      }
    }

    return false;
  }
}


class RestoreButton extends Button
{
 
  constructor(x, y, w, h, font, fontSize)
  {
   super(x, y, w, h, font, fontSize); 
  }
  
  draw()
  {
    push();
    if(this.highLightCounter > 0) fill(201, 13, 101);
    else fill(250, 68, 153);
    strokeWeight(3);
    rect(this.x, this.y, this.w, this.h, 20);
    textFont(this.font);
    fill(0, 0, 0);
    textSize(this.fontSize);
    textAlign(CENTER, CENTER);
    text("Restore" ,this.x + this.w / 2, this.y + this.h / 2);
    if(this.highLightCounter > 0) this.highLightCounter--;
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLightCounter = 10;
      if(workingCopy != null)
      {
        restore();
        return true;
      }
    }

    return false;
  }
}


class SaveButton extends Button
{
 
  constructor(x, y, w, h, font, fontSize)
  {
   super(x, y, w, h, font, fontSize); 
  }
  
  draw()
  {
    push();
    if(this.highLightCounter > 0) fill(201, 13, 101);
    else fill(250, 68, 153);
    strokeWeight(3);
    rect(this.x, this.y, this.w, this.h, 20);
    textFont(this.font);
    fill(0, 0, 0);
    textSize(this.fontSize);
    textAlign(CENTER, CENTER);
    text("Save" ,this.x + this.w / 2, this.y + this.h / 2);
    if(this.highLightCounter > 0) this.highLightCounter--;
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.h) 
    {
      this.highLightCounter = 10;
      if(workingCopy != null)
      {
        save(workingCopy, "photo("+saveIteration+").png");
        saveIteration++;
        return true;
      }
    }

    return false;
  }
}


class Slider extends Button
{
  
  constructor(x, y, w, h, font, fontSize, icon, iconSize, min, max)
  {
    super(x, y, w, h, font, fontSize);
    this.icon = icon;
    this.iconSize = iconSize;
    this.xSlider = x;
    this.ySlider = y;
    this.x = 0.5 * (w -  0.1 * w - 1) + x + 1;
    this.y = y;
    this.ratio = 0.5;
    this.value = Math.round( (min + 0.5 * (max - min)) * 2) / 2;
    this.min = min;
    this.max = max;
  }

  draw()
  {
    if(this.x >= this.xSlider + this.w - (0.1 * this.w - 2) - 2) this.x = this.xSlider + this.w - (0.1 * this.w - 2) - 2;
    else if(this.x <= this.xSlider + 1) this.x = this.xSlider + 1;

    push();
    image(this.icon, this.xSlider - this.iconSize - 10, this.ySlider - 3, this.iconSize, this.iconSize );
    strokeWeight(3);
    fill(100, 100, 100);
    rect(this.xSlider, this.ySlider, this.w, this.h, 20);
    fill(250, 68, 153);
    noStroke();
    rect(this.xSlider + 2, this.y + 1, this.x + 1 + 0.1 * this.w - 2 - this.xSlider - 1, this.h - 2, 20);
    fill(189, 27, 103);
    stroke(0);
    strokeWeight(1);
    rect(this.x + 1, this.y + 1, 0.1 * this.w - 2, this.h - 2, 20);
    fill(0);
    color(0);
    textFont(this.font);
    textSize(this.fontSize);
    text(this.value, this.xSlider + this.w +  0.5 * this.fontSize, this.ySlider + 0.75 * this.fontSize);
    pop();
  }
  
  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.xSlider + 1 && mouseX <= this.xSlider + 1 + this.w && mouseY >= this.y && mouseY <= this.h + this.y) 
    {
      if(mouseX - (0.1 * this.w - 2) / 2 < this.x && this.x >= this.xSlider + 1)
      {
        this.x = mouseX - (0.1 * this.w - 2) / 2;
        this.ratio = (this.x - this.xSlider  - 1) / (this.w -  0.1 * this.w - 1);
        if(this.ratio <= 0) this.ratio = 0;
        else if(this.ratio >= 1) this.ratio = 1;
        this.value = Math.round( (this.min + this.ratio * (this.max - this.min)) * 2) / 2;
        //this.draw();
        //toolSize = (mouseX - 100) / 50;
      }
      else if(mouseX - (0.1 * this.w - 2) / 2 > this.x && this.x <= this.xSlider + this.w - (0.1 * this.w - 2) - 2)
      {
        this.x = mouseX - (0.1 * this.w - 2) / 2;
        this.ratio = (this.x - this.xSlider  - 1) / (this.w -  0.1 * this.w - 1);
        if(this.ratio <= 0) this.ratio = 0;
        else if(this.ratio >= 1) this.ratio = 1;
        this.value = Math.round( (this.min + this.ratio * (this.max - this.min)) * 2) / 2;
        //this.draw();
        //toolSize = (mouseX - 100) / 50;
      }

      return true;
    }

    return false;
  }
}




class Switch
{
  constructor(x, y)
  {
    this.x = x;
    this.y = y;
    this.isActive = false;
  }

  activate()
  {
    this.isActive = true;
  }

  deactivate()
  {
    this.isActive = false;
  }

  toogleActive()
  {
    this.isActive = !(this.isActive);
  }

  
}

class ToolSwitch extends Switch
{
  constructor(x, y, r, icon)
  {
    super(x, y);
    this.r = r;
    this.icon = icon;
  }

  draw()
  {
    push();
    strokeWeight(3);
    color(0);
    if(this.isActive) fill(201, 13, 101);
    else fill(250, 68, 153);
    circle(this.x - this.r, this.y - this.r, this.r);
    image(this.icon, this.x - 1.75 * 0.8 * this.r, this.y - 1.75 * 0.8 * this.r, 0.8 * this.r, 0.8 * this.r);
    pop();
  }

  isClicked(mouseX, mouseY)
  {
    if (mouseX >= this.x - 1.755 * 0.8 * this.r && mouseX <= this.x - 1.755 * 0.8 * this.r + 0.9 * this.r && mouseY >= this.y - 1.8 * 0.8 * this.r && mouseY <= this.y - 1.8 * 0.8 * this.r + 0.9 * this.r) 
    {
      this.toogleActive();
      return true;
    }

    return false;
  }
  
}

class ExpandColorSwitch extends Switch
{
  constructor(x, y, r)
  {
    super(x , y);
    this.r = r;
    this.selectedColor = [0,0,0];
    this.colors = [ [0,0,0], [157,157,157], [255,255,255], [190,38,51], [224,111,139], [73,60,43], [164,100,34], [235,137,49], [247,226,107], [47,72,78], [68,137,26], [163,206,39], [27,38,50], [0,87,132], [49,162,242], [178,220,239] ];
  }

  draw()
  {
    push();
    stroke(0);
    strokeWeight(3);
    fill(this.selectedColor[0], this.selectedColor[1], this.selectedColor[2])
    circle(this.x, this.y, this.r);

    if(this.isActive)
    {
      const expandXStart = this.x - (0.15 * height) / 2;
      const expandYStart = this.y - (0.19 * height);
      const expandSize = 0.15 * height;
      let row = 0;

      push();
      stroke(0);
      strokeWeight(5);
      noFill();
      rect(expandXStart, expandYStart, expandSize, expandSize, 20);
      noStroke();
      for(let i = 0; i < 16; i++)
      {
        fill(this.colors[i][0], this.colors[i][1], this.colors[i][2]);
        if(i % 4 == 0 && i != 0) row++;
        if(i == 0) rect(expandXStart + (i % 4) * (expandSize / 4), expandYStart + row * (expandSize / 4), expandSize / 4, expandSize / 4, 20, 0, 0, 0);
        else if(i == 3) rect(expandXStart + (i % 4) * (expandSize / 4), expandYStart + row * (expandSize / 4), expandSize / 4, expandSize / 4, 0, 20, 0, 0);
        else if(i == 12) rect(expandXStart + (i % 4) * (expandSize / 4), expandYStart + row * (expandSize / 4), expandSize / 4, expandSize / 4, 0, 0, 0, 20);
        else if(i == 15) rect(expandXStart + (i % 4) * (expandSize / 4), expandYStart + row * (expandSize / 4), expandSize / 4, expandSize / 4, 0, 0, 20, 0);
        else rect(expandXStart + (i % 4) * (expandSize / 4), expandYStart + row * (expandSize / 4), expandSize / 4, expandSize / 4);
      }
      pop();
    }
  
    pop();
  }

  isClicked(mouseX, mouseY)
  {
    let wasClicked = false;

    if(mouseX >= this.x - 0.5 * this.r && mouseX <= this.x + 0.5 * this.r && mouseY >= this.y - 0.5 * this.r && mouseY <= this.y + 0.5 * this.r)
    {
      this.toogleActive();
      return true;
    }
    else if(this.isActive == true)
    {
      const expandXStart = this.x - (0.15 * height) / 2;
      const expandYStart = this.y - (0.19 * height);
      const expandSize = 0.15 * height;
      let row = 0;

      for(let i = 0; i < 16; i++)
      {
        if(i % 4 == 0 && i != 0) row++;
        if(mouseX >= expandXStart + (i % 4) * (expandSize / 4) && mouseX <= expandXStart + (i % 4) * (expandSize / 4) + (expandSize / 4) && mouseY >= expandYStart + row * (expandSize / 4) && mouseY <= expandYStart + row * (expandSize / 4) + (expandSize / 4))
        {
          this.selectedColor = [this.colors[i][0],this.colors[i][1],this.colors[i][2]];
          wasClicked = true;
          break;
        }
      }
      this.deactivate();
      return wasClicked;
    }

    return false;
  }


}

class SingleChoiceSwitch
{
  constructor(x, y, w, h, data, space, isHorizontal)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.data = data;
    this.space = space;
    this.isHorizontal = isHorizontal;
    this.activeItem = 0;
    this.scroll = 0;
  }

  isClicked(mouseX, mouseY)
  {
    for(let i = 0; i < this.data.length; i++)
    {
      if(this.isHorizontal)
      {
        if(mouseX >= this.x + i * (this.w / this.data.length + this.space) + this.scroll && mouseX <= this.x + i * (this.w / this.data.length + this.space) + (this.w / this.data.length) + this.scroll && mouseY >= this.y && mouseY <= this.y + this.h)
        {
          this.activeItem = i;
          return true;
        }
      }
      else
      {
        if(mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y + i * (this.h / this.data.length + this.space) + this.scroll && mouseY <= this.y + i * (this.h / this.data.length + this.space) + (this.h / this.data.length) + this.scroll)
        {
          this.activeItem = i;
          return true;
        }
      }
    }
    return false;
  }
}

class TextFontChoiceSwitch extends SingleChoiceSwitch
{
  constructor(x, y, w, h, data, space, isHorizontal)
  {
    super(x, y, w, h, data, space, isHorizontal);
  }

  draw()
  {
    push();
    
    if(this.isHorizontal)
    { 
      
      for(let i = 0; i < this.data.length; i++)
      {
        noStroke();
        if(i == this.activeItem) fill(250, 68, 153);
        else fill(100, 100, 100);

        if(i == 0) rect(this.x + i * (this.w / this.data.length) + i * this.space, this.y, this.w / this.data.length, this.h, 20, 0, 0, 20);
        else if(i == this.data.length - 1) rect(this.x + i * (this.w / this.data.length) + i * this.space, this.y, this.w / this.data.length, this.h, 0, 20, 20, 0);
        else rect(this.x + i * (this.w / this.data.length) + i * this.space, this.y, this.w / this.data.length, this.h);

        color(0);
        fill(0);
        textFont(this.data[i][0]);
        textSize(0.013 * width);
        textAlign(CENTER, CENTER);
        text(this.data[i][1], this.x + i * (this.w / this.data.length) + i * this.space + (this.w / this.data.length) / 2, this.y + this.h / 2)

        stroke(0);
        strokeWeight(3);
        noFill();
        rect(this.x, this.y, this.w + this.data.length * this.space, this.h, 20);

      }
    }
    else
    { 

      for(let i = 0; i < this.data.length; i++)
      {
        noStroke();
        if(i == this.activeItem) fill(250, 68, 153);
        else fill(100, 100, 100);

        if(i == 0) rect(this.x, this.y + i * (this.h / this.data.length) + i * this.space, this.w, this.h / this.data.length, 20, 20, 0, 0);
        else if(i == this.data.length - 1) rect(this.x, this.y + i * (this.h / this.data.length) + i * this.space, this.w, this.h / this.data.length, 20, 20, 0, 0);
        else rect(this.x, this.y + i * (this.h / this.data.length) + i * this.space, this.w, this.h / this.data.length);

        color(0);
        fill(0);
        textFont(this.data[i][0]);
        textSize(0.03 * height);
        textAlign(CENTER, CENTER);
        text(this.data[i][1], this.x + this.w / 2, this.y + i * (this.h / this.data.length) + i * this.space + (this.h / this.data.length) / 2)

        stroke(0);
        strokeWeight(3);
        noFill();
        rect(this.x, this.y, this.w , this.h + this.data.length * this.space, 20);
      }
    }


    pop();
  }
}

class ImageChoiceSwitch extends SingleChoiceSwitch
{
  constructor(x, y, w, h, data, space, isHorizontal)
  {
    super(x, y, w, h, data, space, isHorizontal);
  }

  draw()
  {
    push();

    if(this.isHorizontal)
    {
      for(let i = 0; i < this.data.length; i++)
      {
        image(this.data[i], this.x + i * (this.w / this.data.length) + i * this.space + scrollValue, this.y, this.w / this.data.length, this.h);
        if(i == this.activeItem) stroke(255, 0, 0);
        else stroke(0);
        strokeWeight(5);
        noFill();
        rect(this.x + i * (this.w / this.data.length) + i * this.space + scrollValue, this.y, this.w / this.data.length, this.h);
      }
    }
    else
    {
      for(let i = 0; i < this.data.length; i++)
      {
        image(this.data[i], this.x, this.y + i * (this.h / this.data.length) + i * this.space + scrollValue, this.w, this.h / this.data.length);
        if(i == this.activeItem) stroke(255, 0, 0);
        else stroke(0);
        strokeWeight(5);
        noFill();
        rect(this.x, this.y + i * (this.h / this.data.length) + i * this.space + scrollValue, this.w, this.h / this.data.length);
      }
    }

    
    pop();
  }
}

 