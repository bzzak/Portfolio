class Letter
{
  private float size;
  private char letter;
  private PFont font;
  
  Letter(float s, char c, PFont f)
  {
    size = s;
    letter = c;
    font = f;
  }
  
  //Write letter in given position
  public void printLetter(int x, int y)
  {
    textFont(this.font);
    textSize(size);
    text(letter, x, y);
  }
  
  public float letterWidth()
  {
   textFont(this.font);
   textSize(size);
   return textWidth(letter); 
  }
  
  public float letterAscent()
  {
   textFont(this.font);
   textSize(size);
   return textAscent(); 
  }
  
  public float letterDescent()
  {
   textFont(this.font);
   textSize(size);
   return textDescent(); 
  }
  
  public float letterSize()
  {
   textFont(this.font);
   textSize(size);
   return size; 
  }
}
