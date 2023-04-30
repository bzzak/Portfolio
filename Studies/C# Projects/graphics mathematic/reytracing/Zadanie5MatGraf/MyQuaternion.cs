using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zadanie5MatGraf
{
    class MyQuaternion
    {
        private float[] coefficients = new float[4];

        public MyQuaternion()
        {
            for (int i = 0; i < 4; i++)
            {
                coefficients[i] = 0;
            }
        }

        public MyQuaternion(float a, float b, float c, float d)
        {
            coefficients[0] = a;
            coefficients[1] = b;
            coefficients[2] = c;
            coefficients[3] = d;
        }

        public MyQuaternion(MyQuaternion q)
        {
            coefficients[0] = q.Coefficients[0];
            coefficients[1] = q.Coefficients[1];
            coefficients[2] = q.Coefficients[2];
            coefficients[3] = q.Coefficients[3];
        }

        public float[] Coefficients
        {
            get { return this.coefficients; }
        }


        public static MyQuaternion operator +(MyQuaternion x, MyQuaternion y)
        {
            return new MyQuaternion(
                x.Coefficients[0] + y.Coefficients[0],
                x.Coefficients[1] + y.Coefficients[1],
                x.Coefficients[2] + y.Coefficients[2],
                x.Coefficients[3] + y.Coefficients[3]
                                                    );
        }

        public static MyQuaternion operator -(MyQuaternion x, MyQuaternion y)
        {
            return new MyQuaternion(
                x.Coefficients[0] - y.Coefficients[0],
                x.Coefficients[1] - y.Coefficients[1],
                x.Coefficients[2] - y.Coefficients[2],
                x.Coefficients[3] - y.Coefficients[3]
                                                    );
        }

        public static MyQuaternion operator *(MyQuaternion x, MyQuaternion y)
        {
            return new MyQuaternion(
                x.Coefficients[0] * y.Coefficients[0] - x.Coefficients[1] * y.Coefficients[1] - x.Coefficients[2] * y.Coefficients[2] - x.Coefficients[3] * y.Coefficients[3],
                x.Coefficients[0] * y.Coefficients[1] + x.Coefficients[1] * y.Coefficients[0] + x.Coefficients[2] * y.Coefficients[3] - x.Coefficients[3] * y.Coefficients[2],
                x.Coefficients[0] * y.Coefficients[2] + x.Coefficients[2] * y.Coefficients[0] + x.Coefficients[3] * y.Coefficients[1] - x.Coefficients[1] * y.Coefficients[3],
                x.Coefficients[0] * y.Coefficients[3] + x.Coefficients[3] * y.Coefficients[0] + x.Coefficients[1] * y.Coefficients[2] - x.Coefficients[2] * y.Coefficients[1]
                                                                                                                                                                            );
        }

        public static MyQuaternion operator *(MyQuaternion x, float y)
        {
            return new MyQuaternion(
                x.Coefficients[0] * y,
                x.Coefficients[1] * y,
                x.Coefficients[2] * y,
                x.Coefficients[3] * y
                                );
        }

        public static MyQuaternion operator *(float x, MyQuaternion y)
        {
            return new MyQuaternion(
                x * y.Coefficients[0],
                x * y.Coefficients[1],
                x * y.Coefficients[2],
                x * y.Coefficients[3]
                                );
        }


        public static MyQuaternion operator /(MyQuaternion x, MyQuaternion y)
        {
            MyVector v1 = new MyVector(x.Coefficients[1], x.Coefficients[2], x.Coefficients[3]);
            MyVector v2 = new MyVector(y.Coefficients[1], y.Coefficients[2], y.Coefficients[3]);

            float dotV1V2 = (float)v1.DotProduct(v2);
            float dotV2V2 = (float)v2.DotProduct(v2);
            MyVector V1V2 = v1 * v2;

            float scalarPart = (x.Coefficients[0] * y.Coefficients[0] + dotV1V2) / (y.Coefficients[0] * y.Coefficients[0] + dotV2V2);
            float divisor = y.Coefficients[0] * y.Coefficients[0] + dotV2V2;
            MyVector vectorPart = null;
            try
            {
                if (divisor != 0)
                {
                    vectorPart = (v2 * (-x.Coefficients[0]) + v1 * y.Coefficients[0] - V1V2) / divisor;
                }
                else
                {
                    throw new DivideByZeroException();
                }
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Can't divide vector " + v1.printString() + " by vector " + v2.printString());
            }


            return new MyQuaternion(
                scalarPart,
                (float)vectorPart.X,
                (float)vectorPart.Y,
                (float)vectorPart.Z
                                );
        }

        public static MyQuaternion operator /(MyQuaternion x, float y)
        {
            try
            {
                if (y == 0) throw new DivideByZeroException();
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Can't divide by 0!");
            }


            return new MyQuaternion(
                x.Coefficients[0] / y,
                x.Coefficients[1] / y,
                x.Coefficients[2] / y,
                x.Coefficients[3] / y
                                );
        }

        public static MyQuaternion operator /(float x, MyQuaternion y)
        {
            try
            {
                if (y.Coefficients[0] == 0 && y.Coefficients[1] == 0 && y.Coefficients[2] == 0 && y.Coefficients[3] == 0) throw new DivideByZeroException();
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Can't divide by 0 quaternion!");
            }


            return x * y.Inverse();
        }

        public MyQuaternion Inverse()
        {
            MyVector v = new MyVector(Coefficients[1], Coefficients[2], Coefficients[3]);
            double dotVV = v.DotProduct(v);
            double divisor = Coefficients[0] * Coefficients[0] + dotVV;
            try
            {
                if (divisor == 0) throw new DivideByZeroException();
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Can't invert quaternion - 0 division!");
            }

            return new MyQuaternion((float)(Coefficients[0] / divisor), (float)(-v.X / divisor), (float)(-v.Y / divisor), (float)(-v.Z / divisor));
        }

        public void SetInverse()
        {
            MyQuaternion inverted = this.Inverse();
            coefficients[0] = inverted.Coefficients[0];
            coefficients[1] = inverted.Coefficients[1];
            coefficients[2] = inverted.Coefficients[2];
            coefficients[3] = inverted.Coefficients[3];
        }

        public static MyVector RotateVector(MyVector pivot, double angle, MyVector point)
        {
            double cosPart = Math.Cos(((Math.PI / 180) * angle) / 2);
            double sinPart = Math.Sin(((Math.PI / 180) * angle) / 2);
            double multiplyPart = sinPart / Math.Sqrt(pivot.X * pivot.X + pivot.Y * pivot.Y + pivot.Z * pivot.Z);

            MyQuaternion q1 = new MyQuaternion((float)cosPart, (float)(multiplyPart * pivot.X), (float)(multiplyPart * pivot.Y), (float)(multiplyPart * pivot.Z));
            MyQuaternion q2 = new MyQuaternion((float)cosPart, (float)(-multiplyPart * pivot.X), (float)(-multiplyPart * pivot.Y), (float)(-multiplyPart * pivot.Z));
            MyQuaternion pointQ = new MyQuaternion(0, (float)point.X, (float)point.Y, (float)point.Z);

            MyQuaternion result = q1 * pointQ * q2;

            return new MyVector(result.Coefficients[1], result.Coefficients[2], result.Coefficients[3]);
        }

        public static void SetRotateVector(MyVector pivot, double angle, ref MyVector vector)
        {
            MyVector rotated = MyQuaternion.RotateVector(pivot, angle, vector);
            vector.X = rotated.X;
            vector.Y = rotated.Y;
            vector.Z = rotated.Z;

        }

        public string PrintAlgebraic()
        {
            string output = "";
            string[] im = { "", "i", "j", "k" };
            for(int i = 0; i < 4; i++)
            {
                if(Coefficients[i] < 0) output +=  " - " + Math.Round(Math.Abs(Coefficients[i]),3) + im[i];
                else if(Coefficients[i] >= 0 && i != 0) output += " + " + Math.Round(Math.Abs(Coefficients[i]),3) + im[i];
                else output += Math.Round(Math.Abs(Coefficients[i]),3);
            }

            return output;
        }

    }
}
