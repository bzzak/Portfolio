using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zadanie5MatGraf
{
    public class MyVector
    {
        private double x, y, z;

        public double X
        {
            get { return this.x; }
            set { this.x = value; }
        }

        public double Y
        {
            get { return this.y; }
            set { this.y = value; }
        }

        public double Z
        {
            get { return this.z; }
            set { this.z = value; }
        }

        public MyVector()
        {
            this.x = 1;
            this.y = 1;
            this.z = 1;
        }

        public MyVector(double a, double b, double c)
        {
            this.x = a;
            this.y = b;
            this.z = c;
        }


        //PRIVATE
        private MyVector AddVector(MyVector other)
        {
            MyVector result = new MyVector(this.x + other.x, this.y + other.y, this.z + other.z);
            return result;
        }

        private MyVector CrossProduct(MyVector other)
        {
            MyVector result = new MyVector(this.y * other.z - this.z * other.y,
                this.z * other.x - this.x * other.z, this.x * other.y - this.y * other.x);
            return result;
        }


        //PUBLIC
        public double Length()
        {
            return Math.Sqrt(x * x + y * y + z * z);
        }

        public MyVector Normalize()
        {
            return this / this.Length();
        }

        public double DotProduct(MyVector vector1)
        {
            return vector1.x * this.x + vector1.y * this.y + vector1.z * this.z;
        }

        public double FindAngle(MyVector vector1)
        {
            return Math.Round(Math.Acos(DotProduct(vector1) / (this.Length() * vector1.Length())) / 0.0174533, 6);
        }


        //OPERATORS
        public static MyVector operator +(MyVector vector1, MyVector vector2)
        {
            return vector1.AddVector(vector2);
        }

        public static MyVector operator -(MyVector vector1, MyVector vector2)
        {
            return new MyVector(vector1.x - vector2.x, vector1.y - vector2.y, vector1.z - vector2.z);
        }

        public static MyVector operator *(MyVector vector1, MyVector vector2)
        {
            return vector1.CrossProduct(vector2);
        }

        public static MyVector operator *(MyVector vector1, double number)
        {
            return new MyVector(vector1.x * number, vector1.y * number, vector1.z * number);
        }

        public static MyVector operator *(double number, MyVector vector)
        {
            return new MyVector(vector.x * number, vector.y * number, vector.z * number);
        }

        public static MyVector operator /(MyVector vector1, double number)
        {
            return vector1 * (1 / number);
        }

        public void print()
        {
            Console.Write((float)Math.Round(X * 1000f) / 1000f + "       ");
            Console.Write((float)Math.Round(Y * 1000f) / 1000f + "       ");
            Console.Write((float)Math.Round(Z * 1000f) / 1000f);
            Console.Write("\n");
               
            
        }

        public string printString()
        {
            string element = "";
            string line = "";
            double[] elements = { this.X, this.Y, this.Z };
            for (int i = 0; i < 3; i++)
            {
                element = string.Format("{0:N3}", elements[i]);
                for (int j = 0; j < 10 - element.Length; j++)
                {
                    element += " ";
                }
                line += element;
            }

            return line;
        }
    }
}

