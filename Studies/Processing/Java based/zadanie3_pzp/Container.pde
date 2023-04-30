
//Here we keep all the text, that has been written yet
class Container
{
  //StringList will contain every line of text
  private ArrayList<Letter> message;
  private int x = 0;
  private int y = 0;
  private int margin = 100;
  private int beginLine = 100;
  
  
  Container()
  {
    message = new ArrayList<Letter>();
  }
  
  void read()
  {
    x = margin;
    y = beginLine;
    for (int i = 0; i < message.size(); i++)
    {
      if(message.get(i).letterWidth() + x > width - margin)
      {
        if(y + message.get(i).letterAscent() +  message.get(i).letterDescent() < (0.75 * height) + scrollValue)
        {
          y += (message.get(i).letterAscent() +  message.get(i).letterDescent());
          x = margin;
        } 
      }
      else
      {
       message.get(i).printLetter(x, y);
       x += message.get(i).letterWidth();
      }

    }
  }
  
  void write(float size, char key, PFont font)
  {
    message.add(new Letter(size, key, font));
  }
  
  void deleteLastLetter()
  {
    if(message.size() > 0)
    {
     message.remove(message.size() - 1); 
    }
  }
}
