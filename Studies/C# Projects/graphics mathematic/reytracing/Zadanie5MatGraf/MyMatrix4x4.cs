using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zadanie5MatGraf
{
    class MyMatrix4x4
    {
        public float[] entries = new float[16];

        //Macierz po podaniu wartosci
        public MyMatrix4x4(float e0, float e1, float e2, float e3,
            float e4, float e5, float e6, float e7,
            float e8, float e9, float e10, float e11,
            float e12, float e13, float e14, float e15)
        {
            entries[0] = e0;
            entries[1] = e1;
            entries[2] = e2;
            entries[3] = e3;
            entries[4] = e4;
            entries[5] = e5;
            entries[6] = e6;
            entries[7] = e7;
            entries[8] = e8;
            entries[9] = e9;
            entries[10] = e10;
            entries[11] = e11;
            entries[12] = e12;
            entries[13] = e13;
            entries[14] = e14;
            entries[15] = e15;
        }

        //Macierz jednostkowa
        public MyMatrix4x4()
        {
            entries[0] = 1;
            entries[1] = 0;
            entries[2] = 0;
            entries[3] = 0;
            entries[4] = 0;
            entries[5] = 1;
            entries[6] = 0;
            entries[7] = 0;
            entries[8] = 0;
            entries[9] = 0;
            entries[10] = 1;
            entries[11] = 0;
            entries[12] = 0;
            entries[13] = 0;
            entries[14] = 0;
            entries[15] = 1;
        }

        //Macierz jednostkowa jako osobna metoda

        public void LoadIdentity()
        {
            entries[0] = 1;
            entries[1] = 0;
            entries[2] = 0;
            entries[3] = 0;
            entries[4] = 0;
            entries[5] = 1;
            entries[6] = 0;
            entries[7] = 0;
            entries[8] = 0;
            entries[9] = 0;
            entries[10] = 1;
            entries[11] = 0;
            entries[12] = 0;
            entries[13] = 0;
            entries[14] = 0;
            entries[15] = 1;
        }

        //Macierz bedaca kopia innej macierzy
        public MyMatrix4x4(MyMatrix4x4 other)
        {
            this.entries = other.entries;
        }

        //Dodawanie macierzy
        public static MyMatrix4x4 operator +(MyMatrix4x4 matrix1, MyMatrix4x4 matrix2)
        {
            return new MyMatrix4x4(
                matrix1.entries[0] + matrix2.entries[0],
                matrix1.entries[1] + matrix2.entries[1],
                matrix1.entries[2] + matrix2.entries[2],
                matrix1.entries[3] + matrix2.entries[3],
                matrix1.entries[4] + matrix2.entries[4],
                matrix1.entries[5] + matrix2.entries[5],
                matrix1.entries[6] + matrix2.entries[6],
                matrix1.entries[7] + matrix2.entries[7],
                matrix1.entries[8] + matrix2.entries[8],
                matrix1.entries[9] + matrix2.entries[9],
                matrix1.entries[10] + matrix2.entries[10],
                matrix1.entries[11] + matrix2.entries[11],
                matrix1.entries[12] + matrix2.entries[12],
                matrix1.entries[13] + matrix2.entries[13],
                matrix1.entries[14] + matrix2.entries[14],
                matrix1.entries[15] + matrix2.entries[15]);
        }

        //Odejmowanie macierzy
        public static MyMatrix4x4 operator -(MyMatrix4x4 matrix1, MyMatrix4x4 matrix2)
        {
            return new MyMatrix4x4(
                matrix1.entries[0] - matrix2.entries[0],
                matrix1.entries[1] - matrix2.entries[1],
                matrix1.entries[2] - matrix2.entries[2],
                matrix1.entries[3] - matrix2.entries[3],
                matrix1.entries[4] - matrix2.entries[4],
                matrix1.entries[5] - matrix2.entries[5],
                matrix1.entries[6] - matrix2.entries[6],
                matrix1.entries[7] - matrix2.entries[7],
                matrix1.entries[8] - matrix2.entries[8],
                matrix1.entries[9] - matrix2.entries[9],
                matrix1.entries[10] - matrix2.entries[10],
                matrix1.entries[11] - matrix2.entries[11],
                matrix1.entries[12] - matrix2.entries[12],
                matrix1.entries[13] - matrix2.entries[13],
                matrix1.entries[14] - matrix2.entries[14],
                matrix1.entries[15] - matrix2.entries[15]);
        }

        //Mnozenie macierzy przez skalar
        public static MyMatrix4x4 operator *(MyMatrix4x4 matrix, float n)
        {
            return new MyMatrix4x4(
                matrix.entries[0] * n,
                matrix.entries[1] * n,
                matrix.entries[2] * n,
                matrix.entries[3] * n,
                matrix.entries[4] * n,
                matrix.entries[5] * n,
                matrix.entries[6] * n,
                matrix.entries[7] * n,
                matrix.entries[8] * n,
                matrix.entries[9] * n,
                matrix.entries[10] * n,
                matrix.entries[11] * n,
                matrix.entries[12] * n,
                matrix.entries[13] * n,
                matrix.entries[14] * n,
                matrix.entries[15] * n);
        }

        public static MyMatrix4x4 operator *(float n, MyMatrix4x4 matrix)
        {
            return new MyMatrix4x4(
                matrix.entries[0] * n,
                matrix.entries[1] * n,
                matrix.entries[2] * n,
                matrix.entries[3] * n,
                matrix.entries[4] * n,
                matrix.entries[5] * n,
                matrix.entries[6] * n,
                matrix.entries[7] * n,
                matrix.entries[8] * n,
                matrix.entries[9] * n,
                matrix.entries[10] * n,
                matrix.entries[11] * n,
                matrix.entries[12] * n,
                matrix.entries[13] * n,
                matrix.entries[14] * n,
                matrix.entries[15] * n);
        }

        //Dzielenie macierzy przez skalar
        public static MyMatrix4x4 operator /(MyMatrix4x4 matrix, float n)
        {
            return new MyMatrix4x4(
                matrix.entries[0] / n,
                matrix.entries[1] / n,
                matrix.entries[2] / n,
                matrix.entries[3] / n,
                matrix.entries[4] / n,
                matrix.entries[5] / n,
                matrix.entries[6] / n,
                matrix.entries[7] / n,
                matrix.entries[8] / n,
                matrix.entries[9] / n,
                matrix.entries[10] / n,
                matrix.entries[11] / n,
                matrix.entries[12] / n,
                matrix.entries[13] / n,
                matrix.entries[14] / n,
                matrix.entries[15] / n);
        }

        //Mnozenie macierzy przez macierz
        public static MyMatrix4x4 operator *(MyMatrix4x4 matrix1, MyMatrix4x4 matrix2)
        {
            if (matrix1.entries[3] == 0.0f && matrix1.entries[7] == 0.0f &&
                matrix1.entries[11] == 0.0f && matrix1.entries[15] == 1.0f &&
                matrix2.entries[3] == 0.0f && matrix2.entries[7] == 0.0f &&
                matrix2.entries[11] == 0.0f && matrix2.entries[15] == 1.0f)
            {
                return new MyMatrix4x4(

                    matrix1.entries[0] * matrix2.entries[0] + matrix1.entries[4] * matrix2.entries[1] + matrix1.entries[8] * matrix2.entries[2],
                    matrix1.entries[1] * matrix2.entries[0] + matrix1.entries[5] * matrix2.entries[1] + matrix1.entries[9] * matrix2.entries[2],
                    matrix1.entries[2] * matrix2.entries[0] + matrix1.entries[6] * matrix2.entries[1] + matrix1.entries[10] * matrix2.entries[2],
                    0.0f,

                    matrix1.entries[0] * matrix2.entries[4] + matrix1.entries[4] * matrix2.entries[5] + matrix1.entries[8] * matrix2.entries[6],
                    matrix1.entries[1] * matrix2.entries[4] + matrix1.entries[5] * matrix2.entries[5] + matrix1.entries[9] * matrix2.entries[6],
                    matrix1.entries[2] * matrix2.entries[4] + matrix1.entries[6] * matrix2.entries[5] + matrix1.entries[10] * matrix2.entries[6],
                    0.0f,

                    matrix1.entries[0] * matrix2.entries[8] + matrix1.entries[4] * matrix2.entries[9] + matrix1.entries[8] * matrix2.entries[10],
                    matrix1.entries[1] * matrix2.entries[8] + matrix1.entries[5] * matrix2.entries[9] + matrix1.entries[9] * matrix2.entries[10],
                    matrix1.entries[2] * matrix2.entries[8] + matrix1.entries[6] * matrix2.entries[9] + matrix1.entries[10] * matrix2.entries[10],
                    0.0f,

                    matrix1.entries[0] * matrix2.entries[12] + matrix1.entries[4] * matrix2.entries[13] + matrix1.entries[8] * matrix2.entries[14] + matrix1.entries[12],
                    matrix1.entries[1] * matrix2.entries[12] + matrix1.entries[5] * matrix2.entries[13] + matrix1.entries[9] * matrix2.entries[14] + matrix1.entries[13],
                    matrix1.entries[2] * matrix2.entries[12] + matrix1.entries[6] * matrix2.entries[13] + matrix1.entries[10] * matrix2.entries[14] + matrix1.entries[14],
                    1.0f);
            }
            else
            {
                throw new Exception("Podane macierze nie moga zostac pomnozone.");
            }
        }


        //Odwrócenie przekazanej macierzy
        private void SetMatrixAsInverseOfGivenMatrix(MyMatrix4x4 m)
        {
            //float t1 = m.entries[0] * m.entries[5];
            //float t2 = m.entries[0] * m.entries[8];
            //float t3 = m.entries[4] * m.entries[1];
            //float t4 = m.entries[7] * m.entries[1];
            //float t5 = m.entries[4] * m.entries[2];
            //float t6 = m.entries[7] * m.entries[2];

            //determinant

            //float det = (t1 * m.entries[9] - t2 * m.entries[6] - t3 * m.entries[9] + t4 * entries[6] + t5 * entries[8] - t6 * m.entries[5]);

            //sprawdzenie warunku odwrotności macierzy

            //if (det == 0.0) return;

            //float invd = 1.0f / det;

            //float m0 = (m.entries[5] * m.entries[9] - m.entries[8] * m.entries[6]) * invd;

            //float m4 = -(m.entries[4] * m.entries[9] - m.entries[7] * m.entries[6]) * invd;

            //float m8 = (m.entries[4] * m.entries[8] - m.entries[7] * m.entries[5]) * invd;

            //float m12 = 0;

            //float m1 = -(m.entries[1] * m.entries[9] - m.entries[8] * m.entries[2]) * invd;

            //float m5 = (m.entries[0] * m.entries[9] - t6) * invd;

            //float m9 = -(t2 - t4) * invd;

            //float m13 = 0;

            //float m2 = (m.entries[1] * m.entries[6] - m.entries[5] * m.entries[2]) * invd;

            //float m6 = -(m.entries[0] * m.entries[6] - t5) * invd;

            //float m10 = (t1 - t3) * invd;

            //float m14 = 0;

            //float m3 = -(m.entries[4] * m.entries[9] * m.entries[14] + m.entries[8] * m.entries[13] * m.entries[6] + 
            //           m.entries[12] * m.entries[5] * m.entries[10] - m.entries[6] * m.entries[9] * m.entries[12] -
            //           m.entries[10] * m.entries[13] * m.entries[4] - m.entries[14] * m.entries[5] * m.entries[8]) * invd ;

            //float m7 = (m.entries[0] * m.entries[9] * m.entries[14] + m.entries[8] * m.entries[13] * m.entries[2] +
            //           m.entries[12] * m.entries[1] * m.entries[10] - m.entries[2] * m.entries[9] * m.entries[12] -
            //           m.entries[10] * m.entries[13] * m.entries[0] - m.entries[14] * m.entries[1] * m.entries[8]) * invd;

            //float m11 = -(m.entries[0] * m.entries[5] * m.entries[14] + m.entries[4] * m.entries[13] * m.entries[2] +
            //            m.entries[12] * m.entries[1] * m.entries[6] - m.entries[2] * m.entries[5] * m.entries[12] -
            //            m.entries[6] * m.entries[13] * m.entries[0] - m.entries[14] * m.entries[1] * m.entries[4]) * invd;

            //float m15 = 1;


            //entries[0] = m0;
            //entries[4] = m4;
            //entries[8] = m8;
            //entries[12] = m12;

            //entries[1] = m1;
            //entries[5] = m5;
            //entries[9] = m9;
            //entries[13] = m13;

            //entries[2] = m2;
            //entries[6] = m6;
            //entries[10] = m10;
            //entries[14] = m14;

            //entries[3] = m3;
            //entries[7] = m7;
            //entries[11] = m11;
            //entries[15] = m15;
            //-----------------------------------------------------------------------------

            float[] inv = new float[16];
            float det;

            inv[0] = m.entries[5] * m.entries[10] * m.entries[15] -
                     m.entries[5] * m.entries[11] * m.entries[14] -
                    m.entries[9] * m.entries[6] * m.entries[15] +
                     m.entries[9] * m.entries[7] * m.entries[14] +
                     m.entries[13] * m.entries[6] * m.entries[11] -
                      m.entries[13] * m.entries[7] * m.entries[10];

            inv[4] = -m.entries[4] * m.entries[10] * m.entries[15] +
                      m.entries[4] * m.entries[11] * m.entries[14] +
                      m.entries[8] * m.entries[6] * m.entries[15] -
                      m.entries[8] * m.entries[7] * m.entries[14] -
                      m.entries[12] * m.entries[6] * m.entries[11] +
                      m.entries[12] * m.entries[7] * m.entries[10];

            inv[8] = m.entries[4] * m.entries[9] * m.entries[15] -
                     m.entries[4] * m.entries[11] * m.entries[13] -
                     m.entries[8] * m.entries[5] * m.entries[15] +
                     m.entries[8] * m.entries[7] * m.entries[13] +
                     m.entries[12] * m.entries[5] * m.entries[11] -
                     m.entries[12] * m.entries[7] * m.entries[9];

            inv[12] = -m.entries[4] * m.entries[9] * m.entries[14] +
                       m.entries[4] * m.entries[10] * m.entries[13] +
                       m.entries[8] * m.entries[5] * m.entries[14] -
                       m.entries[8] * m.entries[6] * m.entries[13] -
                       m.entries[12] * m.entries[5] * m.entries[10] +
                       m.entries[12] * m.entries[6] * m.entries[9];

            inv[1] = -m.entries[1] * m.entries[10] * m.entries[15] +
                      m.entries[1] * m.entries[11] * m.entries[14] +
                      m.entries[9] * m.entries[2] * m.entries[15] -
                      m.entries[9] * m.entries[3] * m.entries[14] -
                      m.entries[13] * m.entries[2] * m.entries[11] +
                      m.entries[13] * m.entries[3] * m.entries[10];

            inv[5] = m.entries[0] * m.entries[10] * m.entries[15] -
                     m.entries[0] * m.entries[11] * m.entries[14] -
                     m.entries[8] * m.entries[2] * m.entries[15] +
                     m.entries[8] * m.entries[3] * m.entries[14] +
                     m.entries[12] * m.entries[2] * m.entries[11] -
                     m.entries[12] * m.entries[3] * m.entries[10];

            inv[9] = -m.entries[0] * m.entries[9] * m.entries[15] +
                      m.entries[0] * m.entries[11] * m.entries[13] +
                      m.entries[8] * m.entries[1] * m.entries[15] -
                      m.entries[8] * m.entries[3] * m.entries[13] -
                      m.entries[12] * m.entries[1] * m.entries[11] +
                      m.entries[12] * m.entries[3] * m.entries[9];

            inv[13] = m.entries[0] * m.entries[9] * m.entries[14] -
                      m.entries[0] * m.entries[10] * m.entries[13] -
                      m.entries[8] * m.entries[1] * m.entries[14] +
                      m.entries[8] * m.entries[2] * m.entries[13] +
                      m.entries[12] * m.entries[1] * m.entries[10] -
                      m.entries[12] * m.entries[2] * m.entries[9];

            inv[2] = m.entries[1] * m.entries[6] * m.entries[15] -
                     m.entries[1] * m.entries[7] * m.entries[14] -
                     m.entries[5] * m.entries[2] * m.entries[15] +
                     m.entries[5] * m.entries[3] * m.entries[14] +
                     m.entries[13] * m.entries[2] * m.entries[7] -
                     m.entries[13] * m.entries[3] * m.entries[6];

            inv[6] = -m.entries[0] * m.entries[6] * m.entries[15] +
                      m.entries[0] * m.entries[7] * m.entries[14] +
                      m.entries[4] * m.entries[2] * m.entries[15] -
                      m.entries[4] * m.entries[3] * m.entries[14] -
                      m.entries[12] * m.entries[2] * m.entries[7] +
                      m.entries[12] * m.entries[3] * m.entries[6];

            inv[10] = m.entries[0] * m.entries[5] * m.entries[15] -
                      m.entries[0] * m.entries[7] * m.entries[13] -
                      m.entries[4] * m.entries[1] * m.entries[15] +
                      m.entries[4] * m.entries[3] * m.entries[13] +
                      m.entries[12] * m.entries[1] * m.entries[7] -
                      m.entries[12] * m.entries[3] * m.entries[5];

            inv[14] = -m.entries[0] * m.entries[5] * m.entries[14] +
                       m.entries[0] * m.entries[6] * m.entries[13] +
                       m.entries[4] * m.entries[1] * m.entries[14] -
                       m.entries[4] * m.entries[2] * m.entries[13] -
                       m.entries[12] * m.entries[1] * m.entries[6] +
                       m.entries[12] * m.entries[2] * m.entries[5];

            inv[3] = -m.entries[1] * m.entries[6] * m.entries[11] +
                      m.entries[1] * m.entries[7] * m.entries[10] +
                      m.entries[5] * m.entries[2] * m.entries[11] -
                      m.entries[5] * m.entries[3] * m.entries[10] -
                      m.entries[9] * m.entries[2] * m.entries[7] +
                      m.entries[9] * m.entries[3] * m.entries[6];

            inv[7] = m.entries[0] * m.entries[6] * m.entries[11] -
                     m.entries[0] * m.entries[7] * m.entries[10] -
                     m.entries[4] * m.entries[2] * m.entries[11] +
                     m.entries[4] * m.entries[3] * m.entries[10] +
                     m.entries[8] * m.entries[2] * m.entries[7] -
                     m.entries[8] * m.entries[3] * m.entries[6];

            inv[11] = -m.entries[0] * m.entries[5] * m.entries[11] +
                       m.entries[0] * m.entries[7] * m.entries[9] +
                       m.entries[4] * m.entries[1] * m.entries[11] -
                       m.entries[4] * m.entries[3] * m.entries[9] -
                       m.entries[8] * m.entries[1] * m.entries[7] +
                       m.entries[8] * m.entries[3] * m.entries[5];

            inv[15] = m.entries[0] * m.entries[5] * m.entries[10] -
                      m.entries[0] * m.entries[6] * m.entries[9] -
                      m.entries[4] * m.entries[1] * m.entries[10] +
                      m.entries[4] * m.entries[2] * m.entries[9] +
                      m.entries[8] * m.entries[1] * m.entries[6] -
                      m.entries[8] * m.entries[2] * m.entries[5];

            det = m.entries[0] * inv[0] + m.entries[1] * inv[4] + m.entries[2] * inv[8] + m.entries[3] * inv[12];

            if (det == 0)
                return;

            det = 1.0f / det;

            for (int i = 0; i < 16; i++)
                entries[i] = inv[i] * det;

        }

        //Zwrócenie odwróconej macierzy
        public MyMatrix4x4 GetInverseOfMatrix()
        {
            MyMatrix4x4 result = new MyMatrix4x4();
            result.SetMatrixAsInverseOfGivenMatrix(this);
            return result;
        }


        //Odwrócenie macierzy
        public void InvertMatrix()
        {
            SetMatrixAsInverseOfGivenMatrix(this);
        }

        //Transpozycja przekazanej macierzy
        private void SetMatrixAsTransposeOfGivenMatrix(MyMatrix4x4 m)
        {
            entries[0] = m.entries[0];
            entries[4] = m.entries[1];
            entries[8] = m.entries[2];
            entries[12] = m.entries[3];

            entries[1] = m.entries[4];
            entries[5] = m.entries[5];
            entries[9] = m.entries[6];
            entries[13] = m.entries[7];

            entries[2] = m.entries[8];
            entries[6] = m.entries[9];
            entries[10] = m.entries[10];
            entries[14] = m.entries[11];

            entries[3] = m.entries[12];
            entries[7] = m.entries[13];
            entries[11] = m.entries[14];
            entries[15] = m.entries[15];
        }

        //Zwrócenie przetransponowanej macierzy
        public MyMatrix4x4 GetTransposeOfMatrix()
        {
            MyMatrix4x4 result = new MyMatrix4x4();
            result.SetMatrixAsTransposeOfGivenMatrix(this);
            return result;
        }

        //Transpozycja macierzy
        public void TransposeMatrix()
        {
            SetMatrixAsTransposeOfGivenMatrix(this);
        }

        //Ustawienie translacji
        public void SetTranslationPart(MyVector translation)
        {
            entries[12] = (float)translation.X;
            entries[13] = (float)translation.Y;
            entries[14] = (float)translation.Z;
        }

        //Ustawienie skalowania za pomocą podanego wektora trójwymiarowego
        public void SetScale(MyVector scaleFactor)
        {
            LoadIdentity();

            entries[0] = (float)scaleFactor.X;
            entries[5] = (float)scaleFactor.Y;
            entries[10] = (float)scaleFactor.Z;
        }

        //Ustawienie skalowania za pomocą podanego współczynnika
        public void SetUniformScale(float scaleFactor)
        {
            LoadIdentity();

            entries[0] = entries[5] = entries[10] = scaleFactor;
        }


        public void SetRotationAxis(double angle, MyVector axis)
        {
            MyVector u = axis.Normalize();

            float sinAngle = (float)Math.Sin(Math.PI * angle / 180);
            float cosAngle = (float)Math.Cos(Math.PI * angle / 180);
            float oneMinusCosAngle = 1.0f - cosAngle;

            LoadIdentity();

            entries[0] = (float)(u.X) * (float)(u.X) + cosAngle * (1 - (float)(u.X) * (float)(u.X));
            entries[4] = (float)(u.X) * (float)(u.Y) * (oneMinusCosAngle) - sinAngle * (float)(u.Z);
            entries[8] = (float)(u.X) * (float)(u.Z) * (oneMinusCosAngle) + sinAngle * (float)(u.Y);

            entries[1] = (float)(u.X) * (float)(u.Y) * (oneMinusCosAngle) + sinAngle * (float)(u.Z);
            entries[5] = (float)(u.Y) * (float)(u.Y) + cosAngle * (1 - (float)(u.Y) * (float)(u.Y));
            entries[9] = (float)(u.Y) * (float)(u.Z) * (oneMinusCosAngle) - sinAngle * (float)(u.X);

            entries[2] = (float)(u.X) * (float)(u.Z) * (oneMinusCosAngle) - sinAngle * (float)(u.Y);
            entries[6] = (float)(u.Y) * (float)(u.Z) * (oneMinusCosAngle) + sinAngle * (float)(u.X);
            entries[10] = (float)(u.Z) * (float)(u.Z) + cosAngle * (1 - (float)(u.Z) * (float)(u.Z));

        }

        //Ustawienie rotacji na osi X
        public void SetRotationX(double angle)
        {
            LoadIdentity();

            entries[5] = (float)Math.Cos(Math.PI * angle / 180);
            entries[6] = (float)Math.Sin(Math.PI * angle / 180);

            entries[9] = -entries[6];
            entries[10] = entries[5];
        }

        //Ustawienie rotacji na osi Y
        public void SetRotationY(double angle)
        {
            LoadIdentity();

            entries[0] = (float)Math.Cos(Math.PI * angle / 180);
            entries[2] = -(float)Math.Sin(Math.PI * angle / 180);

            entries[8] = -entries[2];
            entries[10] = entries[0];
        }

        //Ustawienie rotacji na osi Z
        public void SetRotationZ(double angle)
        {
            LoadIdentity();

            entries[0] = (float)Math.Cos(Math.PI * angle / 180);
            entries[1] = (float)Math.Sin(Math.PI * angle / 180);

            entries[4] = entries[1];
            entries[5] = entries[0];
        }


        public static MyVector operator *(MyVector vector, MyMatrix4x4 matrix)
        {
            return new MyVector(vector.X * matrix.entries[0] + vector.Y * matrix.entries[4] + vector.Z * matrix.entries[8] + matrix.entries[12],
                                vector.X * matrix.entries[1] + vector.Y * matrix.entries[5] + vector.Z * matrix.entries[9] + matrix.entries[13],
                                vector.X * matrix.entries[2] + vector.Y * matrix.entries[6] + vector.Z * matrix.entries[10] + matrix.entries[14]);

        }


        public void print()
        {
            //Console.Write("\n");
            for (int i = 0; i < entries.Length; i++)
            {
                Console.Write((float)Math.Round(entries[i] * 1000f) / 1000f + "       ");
                if(i != 0 && i%4 == 3)
                {
                    Console.Write("\n");
                }
            }
        }

        public ArrayList prettyLineSeparatePrint()
        {
            var result = new ArrayList();
            string line = "";
            string element = "";
            int elementSize = 0;

            for (int i = 0; i < entries.Length/4; i++)
            {
                
                for (int j = 0; j < entries.Length/4; j++) 
                {
                    element = string.Format("{0:N3}", entries[i * 4 + j]);
                    elementSize = element.Length;
                    for (int k = 0; k < 10 - elementSize; k++)
                    {
                        element += " ";
                    }
                    line += element;
                }
                result.Add(line);
                line = "";
            }

            return result;
        }

    }
}
