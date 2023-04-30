using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Kody.utility
{
    public class FileOperations
    {
        public string Path { get; set; } = null;
        public string FileData { get; set; }

        private FileOperations(string path, string fileData)
        {
            if (path == "") throw new ArgumentNullException(nameof(path)); 
            Path = path;
            FileData = fileData;
        }

        public static FileOperations CreateFileOperations()
        {
            var openFile = new OpenFileDialog();
            var sb = new StringBuilder();

            if (openFile.ShowDialog() == true)
            {
                openFile.Filter = "txt files (*.txt)|*.txt";
                string line = "";
                var sr = new StreamReader(openFile.FileName);
                while (line != null)
                {
                    line = sr.ReadLine();
                    if (line != null)
                    {
                        sb.Append(line);
                    }
                }
                sr.Close();    
            }
            return new FileOperations(openFile.FileName, sb.ToString());
        }

        private int EncodeLetter(char letter, int[,] matrixH)
        {
            int[,] matrixRow = MatrixOperations.MatrixToIntRow(matrixH);
            int[] sum = MatrixOperations.MultiplyCharWithIRow(letter, matrixRow);
            int encoded = (short)(letter << 8);
            for (int i = 0; i < sum.Length; i++)
            {
                if (sum[i] == 1)
                {
                    encoded |= 1 << (7 - i);
                }
            }
            return encoded;
        }

        private int DecodeInt(int encoded, int[,] matrixH)
        {
            int[] matrixRow = MatrixOperations.MatrixRowNumber(matrixH);

            int[] andOpMatrix = new int[matrixH.GetLength(0)];

            for (int i = 0; i < andOpMatrix.GetLength(0); i++)
            {
                andOpMatrix[i] = encoded & matrixRow[i];
            }
            int[] modBitSum = MatrixOperations.MatrixModBitSum(andOpMatrix);

            bool error = false;
            int decodedInt = 0;
            for (int i = 0; i < modBitSum.GetLength(0); i++)
            {
                if (modBitSum[i] != 0)
                    error = true;
            }

            if (!error)
            {
                decodedInt = (encoded >> 8);
                return decodedInt;
            }
            else
            {
                int matrixValue = 0;
                int position1;
                int position2;
                int[] matrixColumn = MatrixOperations.MatrixToIntColumn(matrixH);

                for (int i = 0; i < modBitSum.GetLength(0); i++)
                {
                    if (modBitSum[i] == 1)
                    {
                        matrixValue |= 1 << (7 - i);
                    }
                }

                for (int i = 0; i < matrixColumn.GetLength(0); i++)
                {
                    if (matrixValue == matrixColumn[i])
                    {
                        position1 = matrixColumn.GetLength(0) - i - 1;
                        encoded ^= 1 << position1;
                        decodedInt = (encoded >> 8);
                        return decodedInt;
                    }
                }
                int columnSum;
                for (int i = 0; i < matrixColumn.GetLength(0); i++)
                {
                    for (int j = 0; j < matrixColumn.GetLength(0); j++)
                    {
                        columnSum = (matrixColumn[i] ^ matrixColumn[j]);
                        if (columnSum == matrixValue)
                        {
                            position1 = matrixColumn.GetLength(0) - i - 1;
                            position2 = matrixColumn.GetLength(0) - j - 1;
                            encoded ^= 1 << position1;
                            encoded ^= 1 << position2;
                            decodedInt = (encoded >> 8);
                            return decodedInt;
                        }
                    }
                }
            }
            return -1;
        }

        public void Encode()
        {
            var sb = new StringBuilder();
            string dataBuff = FileData;
            for (int i = 0; i < dataBuff.Length; i++)
            {
                char value = (char)EncodeLetter(dataBuff[i], MatrixOperations.testMatrixH);
                sb.Append(Converters.ToBinary(value));
            }

            FileData = sb.ToString();
        }

        public void Decode()
        {
            var sb = new StringBuilder();
            int[] buff = new int[FileData.Length / 16];

            for (var i = 0; i < FileData.Length / 16; i++)
                buff[i] = Convert.ToInt32(FileData.Substring(i * 16, 16), 2);

            for (int i = 0; i < buff.Length; i++)
            {
                char value = (char)DecodeInt(buff[i], MatrixOperations.testMatrixH);
                sb.Append(value.ToString());
            }

            FileData = sb.ToString();
        }

    }
}
