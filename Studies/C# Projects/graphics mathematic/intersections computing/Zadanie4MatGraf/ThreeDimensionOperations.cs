using System;


namespace Zadanie4MatGraf
{
    public struct Point3D {
        
        public Point3D(double x, double y, double z)
        {
            X = x;
            Y = y;
            Z = z;
        }

        public double X { get; set; }
        public double Y { get; set; }
        public double Z { get; set; }
        public override string ToString() => $"({X}, {Y}, {Z})";

    }

    public struct Line3D
    {
        public Line3D(Point3D point, MyVector direction)
        {
            P = point;
            D = direction;
        }

        public Point3D P { get; }

        public MyVector D { get; }

        public string PrintVectorOneline()
        {
            string total = "";
            total += $"r = {P.X}i";
            total += (P.Y < 0) ? " - " : " + ";
            total += $"{Math.Abs(P.Y)}j";
            total += (P.Z < 0) ? " - " : " + ";
            total += $"{Math.Abs(P.Z)}k + p( {D.X}l";
            total += (D.Y < 0) ? " - " : " + ";
            total += $"{Math.Abs(D.Y)}m";
            total += (D.Z < 0) ? " - " : " + ";
            total += $"{Math.Abs(D.Z)}n )";

            return total;
        }

        public string PrintVector() 
        {
            string total = "";
            total += $"x = {P.X}";
            total += (D.X < 0) ? " - " : " + ";
            total += $"{Math.Abs(D.X)}t , ";

            total += $"y = {P.Y}";
            total += (D.Y < 0) ? " - " : " + ";
            total += $"{Math.Abs(D.Y)}t , ";

            total += $"z = {P.Z}";
            total += (D.Z < 0) ? " - " : " + ";
            total += $"{Math.Abs(D.Z)}t";

            return total;
        }

        public string PrintParametric() 
        {
            string total = "";
            total += "( x";
            total += (P.X > 0) ? " - " : " + ";
            total += $"{Math.Abs(P.X)} ) / {D.X} = ";

            total += "( y";
            total += (P.Y > 0) ? " - " : " + ";
            total += $"{Math.Abs(P.Y)} ) / {D.Y} = ";

            total += "( z";
            total += (P.Z > 0) ? " - " : " + ";
            total += $"{Math.Abs(P.Z)} ) / {D.Z} = ";

            return total;
        }
    }



    public static class ThreeDimensionOperations
    {
        public static Line3D CreateLineFrom2Points(Point3D p1, Point3D p2) => new Line3D(p1, new MyVector(p2.X - p1.X, p2.Y - p1.Y, p2.Z - p1.Z));
        

        public static Point3D Find3DIntersection(Line3D l1, Line3D l2)
        {
            double[,] equations = { { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 } };
            double[] p1Val = { l1.P.X, l1.P.Y, l1.P.Z };
            double[] p2Val = { l2.P.X, l2.P.Y, l2.P.Z };
            double[] dir1Val = { l1.D.X, l1.D.Y, l1.D.Z };
            double[] dir2Val = { l2.D.X, l2.D.Y, l2.D.Z };
            double mul;

            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    if (j == 0) equations[i, j] = dir1Val[i];
                    else if (j == 1) equations[i, j] = -dir2Val[i];
                    else equations[i, j] = p2Val[i] - p1Val[i];
                }
            }

            for (int i = 0; i < 2; i++)
            {
                if (equations[i, i] == 0)
                {
                    double temp1 = equations[i, 0];
                    double temp2 = equations[i, 1];
                    double temp3 = equations[i, 2];
                    equations[i, 0] = equations[i + 1, 0];
                    equations[i, 1] = equations[i + 1, 1];
                    equations[i, 2] = equations[i + 1, 2];
                    equations[i + 1, 0] = temp1;
                    equations[i + 1, 1] = temp2;
                    equations[i + 1, 2] = temp3;
                }

                if(equations[i,i] != 1 && equations[i, i] != 0)
                {
                    mul = 1 / equations[i, i];
                    for (int j = 0; j < 3; j++)
                    {
                        equations[i, j] *= mul;
                    }
                }

                for (int j = 0; j < 3; j++)
                {
                    if (i == j) j++;
                    if (equations[j, i] != 0)
                    {
                        mul = -equations[j, i];
                        for (int k = 0; k < 3; k++)
                        {
                            equations[j, k] += mul * equations[i, k];
                        }
                    }
                }

            }

            if (equations[2, 2] != 0) throw new Exception("There is no intersection point beetwen these lines!");

            return new Point3D(l1.P.X + l1.D.X * equations[0,2], l1.P.Y + l1.D.Y * equations[0, 2], l1.P.Z + l1.D.Z * equations[0, 2]);
        }

        public static Point3D Find3DIntersectionWithSurface(Line3D l, MyVector n, double w)
        {
            Point3D newP = new Point3D(l.P.X * n.X, l.P.Y * n.Y, l.P.Z * n.Z);
            MyVector newDir = new MyVector(l.D.X * n.X, l.D.Y * n.Y, l.D.Z * n.Z);
            double t = -(newP.X + newP.Y + newP.Z + w) / (newDir.X + newDir.Y + newDir.Z);


            return new Point3D(l.P.X + l.D.X * t, l.P.Y + l.D.Y * t, l.P.Z + l.D.Z * t);
        }

        public static double FindAngleBeetwenLineAndPlane(MyVector dir, MyVector n) => 90 - dir.FindAngle(n);

        public static Line3D FindIntersectionLineBeetwen2Planes(MyVector n1, double w1, MyVector n2, double w2)
        {
            MyVector direction = n1 * n2;
            if (direction.X == 0 && direction.Y == 0 && direction.Z == 0) throw new Exception("Zero vector detected!");

            double[,] equations = { { 0 , 0 , 0 } , { 0 , 0 , 0 } };
            MyVector[] vectors = { n1 , n2 };
            double[] values = { w1, w2 };
            double mul;

            for (int i = 0; i < 2; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    if (j == 0) equations[i, j] = vectors[i].X;
                    else if (j == 1) equations[i, j] = vectors[i].Y;
                    else equations[i, j] = -values[i];
                }
            }

            for (int i = 0; i < 2; i++)
            {
                if (equations[i, i] == 0)
                {
                    double temp1 = equations[i, 0];
                    double temp2 = equations[i, 1];
                    double temp3 = equations[i, 2];
                    equations[i, 0] = equations[i + 1, 0];
                    equations[i, 1] = equations[i + 1, 1];
                    equations[i, 2] = equations[i + 1, 2];
                    equations[i + 1, 0] = temp1;
                    equations[i + 1, 1] = temp2;
                    equations[i + 1, 2] = temp3;
                }

                if (equations[i, i] != 1 && equations[i, i] != 0)
                {
                    mul = 1 / equations[i, i];
                    for (int j = 0; j < 3; j++)
                    {
                        equations[i, j] *= mul;
                    }
                }

                for (int j = 0; j < 2; j++)
                {
                    if (i == j) j++;
                    if (j == 2) break;
                    if (equations[j, i] != 0)
                    {
                        mul = -equations[j, i];
                        for (int k = 0; k < 3; k++)
                        {
                            equations[j, k] += mul * equations[i, k];
                        }
                    }
                }

            }

            return new Line3D(new Point3D(equations[0,2],equations[1,2],0), direction);
        }


        public static Point3D FindIntersectionOf2Divisions(Point3D p1, Point3D p2, Point3D q1, Point3D q2)
        {
            Line3D l1 = CreateLineFrom2Points(p1,p2);
            Line3D l2 = CreateLineFrom2Points(q1,q2);

            Point3D possibleAnswear;

            try
            {
                possibleAnswear = ThreeDimensionOperations.Find3DIntersection(l1, l2);
            }
            catch(Exception e)
            {
                throw new Exception("There are no intersection point beetwen these two divides!");
            }

            if(p1.X >= p2.X)
            {
                if (!(p2.X <= possibleAnswear.X && possibleAnswear.X <= p1.X)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(p1.X <= possibleAnswear.X && possibleAnswear.X <= p2.X)) throw new Exception("There are no intersection point beetwen these two divides!");
            }

            if (p1.Y >= p2.Y)
            {
                if (!(p2.Y <= possibleAnswear.Y && possibleAnswear.Y <= p1.Y)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(p1.Y <= possibleAnswear.Y && possibleAnswear.Y <= p2.Y)) throw new Exception("There are no intersection point beetwen these two divides!");
            }

            if (p1.Z >= p2.Z)
            {
                if (!(p2.Z <= possibleAnswear.Z && possibleAnswear.Z <= p1.Z)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(p1.Z <= possibleAnswear.Z && possibleAnswear.Z <= p2.Z)) throw new Exception("There are no intersection point beetwen these two divides!");
            }



            if (q1.X >= q2.X)
            {
                if (!(q2.X <= possibleAnswear.X && possibleAnswear.X <= q1.X)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(q1.X <= possibleAnswear.X && possibleAnswear.X <= q2.X)) throw new Exception("There are no intersection point beetwen these two divides!");
            }

            if (q1.Y >= q2.Y)
            {
                if (!(q2.Y <= possibleAnswear.Y && possibleAnswear.Y <= q1.Y)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(q1.Y <= possibleAnswear.Y && possibleAnswear.Y <= q2.Y)) throw new Exception("There are no intersection point beetwen these two divides!");
            }

            if (q1.Z >= q2.Z)
            {
                if (!(q2.Z <= possibleAnswear.Z && possibleAnswear.Z <= q1.Z)) throw new Exception("There are no intersection point beetwen these two divides!");
            }
            else
            {
                if (!(q1.Z <= possibleAnswear.Z && possibleAnswear.Z <= q2.Z)) throw new Exception("There are no intersection point beetwen these two divides!");
            }

            return possibleAnswear; ;
        }

        public static Point3D[] FindIntersectionsOfLineAndSphere(Point3D c, double r, Line3D l)
        {
            Point3D[] ans;
            double t1, t2;
            double tempx = l.P.X - c.X;
            double tempy = l.P.Y - c.Y;
            double tempz = l.P.Z - c.Z;

            double[] coefficients = { l.D.X * l.D.X + l.D.Y * l.D.Y + l.D.Z * l.D.Z, 
                                      2 * l.D.X * tempx + 2 * l.D.Y * tempy + 2 * l.D.Z * tempz,
                                      tempx * tempx + tempy * tempy + tempz * tempz - (r * r)};

            double delta = coefficients[1] * coefficients[1] - 4 * coefficients[0] * coefficients[2];

            if (delta > 0)
            {
                t1 = (-coefficients[1] + Math.Sqrt(delta))/ (2 * coefficients[0]);
                t2 = (-coefficients[1] - Math.Sqrt(delta)) / (2 * coefficients[0]);
                ans = new Point3D[] { new Point3D(Math.Round(l.P.X + l.D.X * t1, 5), Math.Round(l.P.Y + l.D.Y * t1, 5), Math.Round(l.P.Z + l.D.Z * t1, 5)), new Point3D(Math.Round(l.P.X + l.D.X * t2, 5), Math.Round(l.P.Y + l.D.Y * t2, 5), Math.Round(l.P.Z + l.D.Z * t2, 5)) };
            }
            else if (delta == 0)
            {
                t1 = -coefficients[1] / (2 * coefficients[0]);
                ans = new Point3D[] { new Point3D(Math.Round(l.P.X + l.D.X * t1, 5), Math.Round(l.P.Y + l.D.Y * t1, 5), Math.Round(l.P.Z + l.D.Z * t1, 5)) };
            }
            else
            {
                throw new Exception("There is no intersection beetwen these sphere and line!");
            }

            return ans;
        }


    }
}
