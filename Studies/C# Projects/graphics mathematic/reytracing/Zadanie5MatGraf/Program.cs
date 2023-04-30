using System;
using System.Collections;

namespace Zadanie5MatGraf
{
    class Program
    {
        public enum Axis
        {
            X, Y, Z, NONE
        }

        static void Main(string[] args)
        {
            MyVector startCamera = new MyVector(0, 0, -100);
            MyVector startNewOriginRelative = new MyVector(0, 1, 0);
            double startZoom = 0.3;
            MyVector camera = new MyVector(startCamera.X, startCamera.Y, startCamera.Z);
            MyVector newOriginRelative = new MyVector(startNewOriginRelative.X, startNewOriginRelative.Y, startNewOriginRelative.Z);
            double zoom = startZoom;
            double rotation = 0;
            Axis axis = Axis.NONE;
            double step = 1;
            int screenWidth = 60;
            int screenHeight = 60;
            SimpleCube cube = new SimpleCube(new Point3D(0,0,0), 40);

            Line3D beam;
            int pixelsCounter = 0;

            bool isParameterChanged = true;
            bool performRotate = false;
            bool isReset = true;

            

            Console.WindowHeight = 50;
            Console.WindowWidth = 123;

            do
            {
                while (! Console.KeyAvailable)
                {
                    if (isParameterChanged)
                    {
                        Console.Clear();

                        if (isReset)
                        {
                            camera = new MyVector(startCamera.X, startCamera.Y, startCamera.Z);
                            newOriginRelative = new MyVector(startNewOriginRelative.X, startNewOriginRelative.Y, startNewOriginRelative.Z);
                            zoom = startZoom;
                            rotation = 0;
                            axis = Axis.NONE;
                        }


                        if(performRotate)
                        {
                            if (axis == Axis.X) 
                            { 
                                MyQuaternion.SetRotateVector(new MyVector(1, 0, 0), rotation, ref camera);
                                MyQuaternion.SetRotateVector(new MyVector(1, 0, 0), rotation, ref newOriginRelative);
                            }
                            else if (axis == Axis.Y) 
                            { 
                                MyQuaternion.SetRotateVector(new MyVector(0, 1, 0), rotation, ref camera);
                                MyQuaternion.SetRotateVector(new MyVector(0, 1, 0), rotation, ref newOriginRelative);
                            }
                            else if (axis == Axis.Z) 
                            { 
                                MyQuaternion.SetRotateVector(new MyVector(0, 0, 1), rotation, ref camera);
                                MyQuaternion.SetRotateVector(new MyVector(0, 0, 1), rotation, ref newOriginRelative);
                            }
                        }

                        ArrayList screenPixelsPositions = generateScreenPixelsPositions(camera, newOriginRelative, zoom, step, screenWidth, screenHeight);


                        for (int i = 0; i < screenWidth * 2; i++)
                        {
                            Console.Write("_");
                        }

                        Console.WriteLine();
                        Console.WriteLine();

                        foreach (var pixel in screenPixelsPositions)
                        {
                            pixelsCounter++;
                            if (pixelsCounter % screenWidth == 1) Console.Write("|");
                            beam = ThreeDimensionOperations.CreateLineFrom2Points(new Point3D(camera.X, camera.Y, camera.Z), (Point3D)pixel);
                            if (cube.IsLineIntersectsCube(beam)) Console.Write("0 ");
                            else Console.Write(". ");

                            if (pixelsCounter % screenWidth == 0)
                            {
                                Console.Write("|");
                                Console.WriteLine();
                            }
                        }

                        for (int i = 0; i < screenWidth * 2 + 1; i++)
                        {
                            Console.Write("_");
                        }

                        Console.WriteLine();

                        Console.WriteLine("---------------------------------------");
                        Console.WriteLine($"ZOOM     : {zoom}");
                        Console.WriteLine("---------------------------------------");
                        Console.Write("ROTATION : ");

                        if (axis == Axis.X) Console.ForegroundColor = ConsoleColor.Red;
                        else if (axis == Axis.Y) Console.ForegroundColor = ConsoleColor.Green;
                        else if (axis == Axis.Z) Console.ForegroundColor = ConsoleColor.Blue;
                        else Console.ForegroundColor = ConsoleColor.White;
                        Console.WriteLine(rotation);
                        Console.ForegroundColor = ConsoleColor.White;

                        Console.WriteLine("---------------------------------------");

                        Console.WriteLine("SPACEBAR - Enter a new zoom value.");
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.Write("x");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.WriteLine("        - Rotate camera around X axis.");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.Write("y");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.WriteLine("        - Rotate camera around Y axis.");
                        Console.ForegroundColor = ConsoleColor.Blue;
                        Console.Write("z");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.WriteLine("        - Rotate camera around z axis.");
                        Console.WriteLine("r        - Reset program.");
                        Console.WriteLine("ESCAPE   - Exit program.");

                        Console.WriteLine("---------------------------------------");

                        pixelsCounter = 0;

                        isParameterChanged = false;
                        performRotate = false;
                        isReset = false;
                    }
                }

                KeyHandler(ref zoom , ref rotation, ref axis, ref performRotate, ref isParameterChanged, ref isReset);

            } while (Console.ReadKey(true).Key != ConsoleKey.Escape);

        }


        public static ArrayList generateScreenPixelsPositions(MyVector camera, MyVector newOriginRelative, double zoom, double step, int screenWidth, int screenHeight)
        {
            MyVector middleScreen = camera * zoom;
            MyVector newOriginX = camera * newOriginRelative;
            MyVector newOriginY = camera * newOriginX;
            double newX = -screenWidth * step / 2;
            double newY = screenHeight * step / 2;
            int rowCounter = 0, colCounter = 0;
            //Surface screen = new Surface(camera, new Point3D(middleScreen.X, middleScreen.Y, middleScreen.Z ));
            var pixels = new ArrayList();
            MyVector pixel;

            for(int i = 0; i < screenHeight * screenWidth; i++)
            {
                pixel = ((newX + colCounter * step) * newOriginX.Normalize() + (newY - rowCounter * step) * newOriginY.Normalize()) + middleScreen;

                pixels.Add(new Point3D(pixel.X, pixel.Y, pixel.Z));

                if (colCounter == screenWidth - 1)
                {
                    colCounter = 0;
                    rowCounter++;
                }
                else colCounter++;
            }

            return pixels;
        }

        public static void KeyHandler(ref double zoom, ref double rotation, ref Axis axis, ref bool performRotate, ref bool isParameterChanged, ref bool isReset)
        {
            ConsoleKeyInfo key = Console.ReadKey(true);

            switch(key.Key)
            {
                case ConsoleKey.X:
                    Console.Write("Enter X rotate: ");
                    double newRotateX;
                    bool parseRotateXSuccess = double.TryParse(Console.ReadLine(), out newRotateX);
                    if (parseRotateXSuccess && newRotateX != 0)
                    { 
                        rotation = newRotateX;
                        axis = Axis.X;
                        performRotate = true;
                    }
                    isParameterChanged = true;
                    break;
                case ConsoleKey.Y:
                    Console.Write("Enter Y rotate: ");
                    double newRotateY;
                    bool parseRotateYSuccess = double.TryParse(Console.ReadLine(), out newRotateY);
                    if (parseRotateYSuccess && newRotateY != 0)
                    {
                        rotation = newRotateY;
                        axis = Axis.Y;
                        performRotate = true;
                    }
                    isParameterChanged = true;
                    break;
                case ConsoleKey.Z:
                    Console.Write("Enter Z rotate: ");
                    double newRotateZ;
                    bool parseRotateZSuccess = double.TryParse(Console.ReadLine(), out newRotateZ);
                    if (parseRotateZSuccess && newRotateZ != 0)
                    {
                        rotation = newRotateZ;
                        axis = Axis.Z; 
                        performRotate = true;
                    }
                    isParameterChanged = true;
                    break;
                case ConsoleKey.R:
                    isReset = true;
                    isParameterChanged = true;
                    break;
                case ConsoleKey.Spacebar:
                    Console.Write("Enter new zoom: ");
                    double newZoom;
                    bool parseZoomSuccess = double.TryParse(Console.ReadLine(),out newZoom);
                    if (parseZoomSuccess) zoom = newZoom;
                    isParameterChanged = true;
                    break;

            }
        }
    }


}
