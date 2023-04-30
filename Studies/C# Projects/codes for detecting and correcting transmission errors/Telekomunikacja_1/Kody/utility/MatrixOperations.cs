using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kody.utility
{
    internal static class MatrixOperations
    {

        internal static readonly int[,] testMatrixH = new int[8, 16] {
        { 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        { 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
        { 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0},
        { 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        { 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0},
        { 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
        { 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0},
        { 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1}
        };

        internal static int[,] MatrixToIntRow(int[,] matrix)
        {

            int[,] newMatrix = new int[matrix.GetLength(0), matrix.GetLength(1) / 8];
            int number1 = 0;
            int number2 = 0;
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                number1 = 0;
                number2 = 0;
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    if (matrix[i, j] == 1 && j < 8)
                    {
                        number1 |= 1 << (7 - j);
                    }
                    else if (matrix[i, j] == 1 && j >= 8)
                    {
                        number2 |= 1 << (15 - j);
                    }
                }
                newMatrix[i, 0] = number1;
                newMatrix[i, 1] = number2;
            }
            return newMatrix;
        }

        internal static int[] MatrixToIntColumn(int[,] matrixH)
        {

            int[] newMatrix = new int[matrixH.GetLength(1)];
            int number = 0;
            for (int i = 0; i < matrixH.GetLength(1); i++)
            {
                number = 0;

                for (int j = 0; j < matrixH.GetLength(0); j++)
                {
                    if (matrixH[j, i] == 1)
                    {
                        number |= 1 << (7 - j);
                    }
                }
                newMatrix[i] = number;
            }
            return newMatrix;
        }

        internal static int[] MultiplyCharWithIRow(int c, int[,] matrixRow)
        {
            int count = 0;
            int[] sum = new int[matrixRow.GetLength(0)];
            for (int i = 0; i < sum.GetLength(0); i++)
            {
                count = 0;
                sum[i] = c & matrixRow[i, 0];
                while (sum[i] > 0)
                {
                    count += (sum[i] & 1);
                    sum[i] = sum[i] >> 1;
                }
                sum[i] = count % 2;
            }
            return sum;
        }

        internal static int[] MatrixModBitSum(int[] andOpMatrix)
        {
            int count = 0;

            for (int i = 0; i < andOpMatrix.GetLength(0); i++)
            {
                count = 0;
                while (andOpMatrix[i] > 0)
                {
                    count = count + (andOpMatrix[i] & 1);
                    andOpMatrix[i] = andOpMatrix[i] >> 1;
                }
                andOpMatrix[i] = count % 2;
            }
            return andOpMatrix;
        }

        internal static int[] MatrixRowNumber(int[,] matrixH)
        {
            int[,] doubleMatrixRow = MatrixToIntRow(matrixH);
            int[] matrixRow = new int[matrixH.GetLength(0)];
            int number;

            for (int i = 0; i < matrixRow.GetLength(0); i++)
            {
                number = 0;
                number = doubleMatrixRow[i, 0];
                number <<= (8);
                number |= doubleMatrixRow[i, 1];
                matrixRow[i] = number;
            }
            return matrixRow;
        }
    }
}
