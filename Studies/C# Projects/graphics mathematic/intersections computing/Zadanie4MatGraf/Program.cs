using System;

namespace Zadanie4MatGraf
{
    class Program
    {
        static void Main(string[] args)
        {
            // 1
            Line3D line1 = new Line3D(new Point3D(-2, 4, 0), new MyVector(3, 1, 5));
            Line3D line2 = new Line3D(new Point3D(-2, 4, 0), new MyVector(1, -5, 3));

            Point3D ans1;
            string ans1String = "";

            try
            {
                ans1 = ThreeDimensionOperations.Find3DIntersection(line1, line2);
                ans1String = ans1.ToString();
            }
            catch(Exception e)
            {
                ans1String = e.Message;
            }

            //3
            Line3D line3 = new Line3D(new Point3D(-2, 2, -1), new MyVector(3, -1, 2));

            Point3D ans2;
            string ans2String = "";

            try
            {
                ans2 = ThreeDimensionOperations.Find3DIntersectionWithSurface(line3, new MyVector(2, 3, 3), -8);
                ans2String = ans2.ToString();
            } 
            catch (Exception e)
            {
                ans2String = "Line is parallel to plane!";
            }

            //4          
            double ans3 = ThreeDimensionOperations.FindAngleBeetwenLineAndPlane(new MyVector(3, -1, 2), new MyVector(2, 3, 3));

            //5
            Line3D ans4;
            string ans4String = "";

           try
            {
                ans4 = ThreeDimensionOperations.FindIntersectionLineBeetwen2Planes(new MyVector(2, -1, 1), -8, new MyVector(4, 3, 1), 14);
                ans4String = ans4.PrintVector();
            }
            catch(Exception e)
            {
                ans4String = "Planes are parallel!";
            }

            //6
            MyVector n1 = new MyVector(2, -1, 1);
            MyVector n2 = new MyVector(4, 3, 1);

            //7
            Point3D ans5;
            string ans5String = "";

            try
            {
                ans5 = ThreeDimensionOperations.FindIntersectionOf2Divisions(new Point3D(5, 5, 4), new Point3D(10, 10, 6), new Point3D(5, 5, 5), new Point3D(10, 10, 3));
                ans5String = ans5.ToString();
            }
            catch(Exception e)
            {
                ans5String = e.Message;
            }

            //8
            Point3D[] ans6; 
            string ans6String = "";

            try
            {
                ans6 = ThreeDimensionOperations.FindIntersectionsOfLineAndSphere(new Point3D(0,0,0), Math.Sqrt(26), ThreeDimensionOperations.CreateLineFrom2Points(new Point3D(3,-1,-2), new Point3D(5,3,-4)));
                for (int i = 0; i < ans6.Length; i++)
                {
                    ans6String += ans6[i];
                    ans6String += "  ";
                }
            }
            catch(Exception e)
            {
                ans6String = "There are no intersection points beetwen given line and sphere!";
            }

            Console.WriteLine("Zad1: " + ans1String);
            Console.WriteLine("Zad2: " + line1.D.FindAngle(line2.D) + " (stopnie)");
            Console.WriteLine("Zad3: " + ans2String);
            Console.WriteLine("Zad4: " + ans3 + " (stopnie)");
            Console.WriteLine("Zad5: " + ans4String);
            Console.WriteLine("Zad6: " + n1.FindAngle(n2) + " (stopnie)");
            Console.WriteLine("Zad7: " + ans5String);
            Console.WriteLine("Zad8: " + ans6String);
        }
    }
}
