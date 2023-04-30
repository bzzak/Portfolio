using System;
using System.Collections;
using SautinSoft.Document;
using SautinSoft.Document.Drawing;

namespace Zadanie2MatGraf
{
    class Program
    {
        static void Main(string[] args)
        {

            MyMatrix4x4 Op1 = new MyMatrix4x4(2, 3, 1, 0, 5, 2, 7, 0, 6, 3, 1, 0, 0, 0, 0, 1);
            MyMatrix4x4 Op2 = new MyMatrix4x4(3, 2, 6, 0, 1, 2, 8, 0, 9, 0, 2, 0, 0, 0, 0, 1);
            // MyMatrix4x4 identity = new MyMatrix4x4();
            ArrayList results = new ArrayList();
            MyVector vec1 = new MyVector(1, 0, 0);
            MyMatrix4x4 rotY90 = new MyMatrix4x4();
            MyMatrix4x4 transVec = new MyMatrix4x4();
            MyMatrix4x4 scalVec = new MyMatrix4x4();
            MyMatrix4x4 scalSca = new MyMatrix4x4();
            MyMatrix4x4 rotVec90 = new MyMatrix4x4();
            MyMatrix4x4 rotX90 = new MyMatrix4x4();
            MyMatrix4x4 rotZ90 = new MyMatrix4x4();

            //Test Dodawania
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Adding Test");           
            Console.Write("------------------------------");
            Console.Write("\n");

            MyMatrix4x4 addRes1 = Op1 + Op2;
            MyMatrix4x4 addRes2 = Op2 + Op1;
            results.Add(addRes1);
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("+");
            Console.Write("\n");
            Op2.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            addRes1.print();

            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("\n");
            Op2.print();
            Console.Write("\n");
            Console.WriteLine("+");
            Console.Write("\n");
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            addRes2.print();

            //Test Odejmowania
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Substract Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 subRes1 = Op1 - Op2;
            results.Add(subRes1);
            MyMatrix4x4 subRes2 = Op2 - Op1;
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("-");
            Console.Write("\n");
            Op2.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            subRes1.print();

            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("\n");
            Op2.print();
            Console.Write("\n");
            Console.WriteLine("-");
            Console.Write("\n");
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            subRes2.print();


            //Test Mnożenia przez skalar
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Multiply by scalar Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 mulNumRes1 = Op1 * 2;
            results.Add(mulNumRes1);
            MyMatrix4x4 mulNumRes2 = 2 * Op1;
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            Console.Write("2");
            Console.Write("\n\n");
            Console.WriteLine("=");
            Console.Write("\n");
            mulNumRes1.print();

            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("\n");
            Console.Write("2\n\n");
            Console.WriteLine("*");
            Console.Write("\n");
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            mulNumRes2.print();


            //Test Dzielenia przez skalar
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Divide by scalar Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 divNumRes1 = Op1 / 2;
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("/");
            Console.Write("\n");
            Console.Write("2");
            Console.Write("\n\n");
            Console.WriteLine("=");
            Console.Write("\n");
            divNumRes1.print();


            //Test Mnożenia macierzy
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Multiply by matrix Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 mulRes1 = Op1 * Op2;
            results.Add(mulRes1);
            MyMatrix4x4 mulRes2 = Op2 * Op1;
            results.Add(mulRes2);
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            Op2.print();
            Console.Write("\n\n");
            Console.WriteLine("=");
            Console.Write("\n");
            mulRes1.print();

            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("\n");
            Op2.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            mulRes2.print();


            //Test transpozycji
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Transposition Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 transOp1 = Op1.GetTransposeOfMatrix();
            results.Add(transOp1);
            
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("^T");
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            transOp1.print();

            //Test Inwersji
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Inverse Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            MyMatrix4x4 invOp1 = Op1.GetInverseOfMatrix();
            results.Add(invOp1);
            MyMatrix4x4 newOp1 = Op1 * invOp1; ;
            results.Add(newOp1);

            Op1.print();
            Console.Write("\n");
            Console.WriteLine("^-1");
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            invOp1.print();

            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("\n");
            Op1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            invOp1.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            newOp1.print();

            //Test Translacji Wektora
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Translate [1,3,6] Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            transVec.SetTranslationPart(new MyVector(1,3,6));
            MyVector transVec1 = vec1 * transVec;
            results.Add(transVec1);

            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            transVec.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            transVec1.print();

            //Test Skalowania Wektora Współczynnik Wektorowy
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Scale [1,3,6] Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            scalVec.SetScale(new MyVector(1, 3, 6));
            MyVector scalVec1 = vec1 * scalVec;
            results.Add(scalVec1);

            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            scalVec.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            scalVec1.print();

            //Test Skalowania Wektora przez Skalar
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Scale 3 Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            scalSca.SetUniformScale(3);
            MyVector scalSca1 = vec1 * scalSca;
            results.Add(scalSca1);

            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            scalSca.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            scalSca1.print();

            //Test Obrotu Wektora oś X
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Rotate90 X Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            rotX90.SetRotationX(90);
            MyVector rotX90_1 = vec1 * rotX90;
            results.Add(rotX90_1);


            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            rotX90.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            rotX90_1.print();


            //Test Obrotu Wektora oś Y
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Rotate90 Y Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
           
            rotY90.SetRotationY(90);
            MyVector rotY90_1 = vec1 * rotY90;
            results.Add(rotY90_1);


            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            rotY90.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            rotY90_1.print();

            //Test Obrotu Wektora oś Z
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Rotate90 Z Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            rotZ90.SetRotationZ(90);
            MyVector rotZ90_1 = vec1 * rotZ90;
            results.Add(rotZ90_1);


            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            rotZ90.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            rotZ90_1.print();

            //Test Obrotu Wektora oś [1,1,1]
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector Rotate90 [1,1,1] Test");
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");

            rotVec90.SetRotationAxis(90, new MyVector(1,1,1));
            MyVector rotVec90_1 = vec1 * rotVec90;
            results.Add(rotVec90_1);


            Console.Write("\n");
            vec1.print();
            Console.Write("\n");
            Console.WriteLine("*");
            Console.Write("\n");
            rotVec90.print();
            Console.Write("\n");
            Console.WriteLine("=");
            Console.Write("\n");
            rotVec90_1.print();

            CreateDocxUsingDocumentBuilder(Op1, Op2, vec1, transVec, scalVec, scalSca, rotX90, rotY90, rotZ90, rotVec90, results);

        }


        public static void CreateDocxUsingDocumentBuilder(MyMatrix4x4 op1, MyMatrix4x4 op2, MyVector vec1, MyMatrix4x4 transVec, MyMatrix4x4 scalVec, MyMatrix4x4 scalSca, MyMatrix4x4 rotX90, MyMatrix4x4 rotY90, MyMatrix4x4 rotZ90, MyMatrix4x4 rotVec90, ArrayList results)
        {
            ArrayList op1String = op1.prettyLineSeparatePrint();
            ArrayList op2String = op2.prettyLineSeparatePrint();
            String vec1String = vec1.printString();
            ArrayList transVecString = transVec.prettyLineSeparatePrint();
            ArrayList scalVecString = scalVec.prettyLineSeparatePrint();
            ArrayList scalScaString = scalSca.prettyLineSeparatePrint();
            ArrayList rotX90String = rotX90.prettyLineSeparatePrint();
            ArrayList rotY90String = rotY90.prettyLineSeparatePrint();
            ArrayList rotZ90String = rotZ90.prettyLineSeparatePrint();
            ArrayList rotVec90String = rotVec90.prettyLineSeparatePrint();
            MyMatrix4x4 addResult = (MyMatrix4x4)results[0];
            MyMatrix4x4 subResult = (MyMatrix4x4)results[1];
            MyMatrix4x4 mulScalarResult = (MyMatrix4x4)results[2];
            MyMatrix4x4 mulMatrix1Result = (MyMatrix4x4)results[3];
            MyMatrix4x4 mulMatrix2Result = (MyMatrix4x4)results[4];
            MyMatrix4x4 transposeMatrixResult = (MyMatrix4x4)results[5];
            MyMatrix4x4 inverseMatrixResult = (MyMatrix4x4)results[6];
            MyMatrix4x4 testInverseMatrixResult = (MyMatrix4x4)results[7];
            MyVector transVectorResult = (MyVector)results[8];
            MyVector scaleVectorResult = (MyVector)results[9];
            MyVector uniformScaleVectorResult = (MyVector)results[10];
            MyVector rotateX90VectorResult = (MyVector)results[11];
            MyVector rotateY90VectorResult = (MyVector)results[12];
            MyVector rotateZ90VectorResult = (MyVector)results[13];
            MyVector rotate90VectorResult = (MyVector)results[14];
            ArrayList addResultString = addResult.prettyLineSeparatePrint();
            ArrayList subResultString = subResult.prettyLineSeparatePrint();
            ArrayList mulScalarResultString = mulScalarResult.prettyLineSeparatePrint();
            ArrayList mulMatrix1ResultString = mulMatrix1Result.prettyLineSeparatePrint();
            ArrayList mulMatrix2ResultString = mulMatrix2Result.prettyLineSeparatePrint();
            ArrayList transposeMatrixResultString = transposeMatrixResult.prettyLineSeparatePrint();
            ArrayList inverseMatrixResultString = inverseMatrixResult.prettyLineSeparatePrint();
            ArrayList testInverseMatrixResultString = testInverseMatrixResult.prettyLineSeparatePrint();
            String transVectorResultString = transVectorResult.printString();
            String scaleVectorResultString = scaleVectorResult.printString();
            String uniformScaleVectorResultString = uniformScaleVectorResult.printString();
            String rotateX90VectorResultString = rotateX90VectorResult.printString();
            String rotateY90VectorResultString = rotateY90VectorResult.printString();
            String rotateZ90VectorResultString = rotateZ90VectorResult.printString();
            String rotate90VectorResultString = rotate90VectorResult.printString();


            // Set a path to our document.
            string docPath = @"Result-DocumentBuilder.docx";

            // Create a new document and DocumentBuilder.
            DocumentCore dc = new DocumentCore();
            DocumentBuilder db = new DocumentBuilder(dc);

            // Set page size A4.
            Section section = db.Document.Sections[0];
            section.PageSetup.PaperType = PaperType.A4;

            // Add 1st paragraph with formatted text.
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            db.CharacterFormat.Bold = true;
            //db.CharacterFormat.FontColor = Color.Orange;

            //Add Matrix Test
            db.Write("Add Matrix Test");
            
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;
            
            for (int i = 0; i < op1String.Count; i++) 
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("+");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op2String.Count; i++)
            {
                db.Writeln((string)op2String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < addResultString.Count; i++)
            {
                db.Writeln((string)addResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            
            // Add text into the 2nd paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Substract Matrix Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;

            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("-");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op2String.Count; i++)
            {
                db.Writeln((string)op2String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < subResultString.Count; i++)
            {
                db.Writeln((string)subResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 3rd paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Scalar Multiply Matrix Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;

            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("2");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < mulScalarResultString.Count; i++)
            {
                db.Writeln((string)mulScalarResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 4th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Matrix Multiply Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;

            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op2String.Count; i++)
            {
                db.Writeln((string)op2String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < mulMatrix1ResultString.Count; i++)
            {
                db.Writeln((string)mulMatrix1ResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("--------------------------------------------------------------------------");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op2String.Count; i++)
            {
                db.Writeln((string)op2String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < mulMatrix2ResultString.Count; i++)
            {
                db.Writeln((string)mulMatrix2ResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);



            // Add text into the 5th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Matrix Transposition Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;

            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("^T");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < transposeMatrixResultString.Count; i++)
            {
                db.Writeln((string)transposeMatrixResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 6th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Inverse Matrix Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;

            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("^-1");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < inverseMatrixResultString.Count; i++)
            {
                db.Writeln((string)inverseMatrixResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("--------------------------------------------------------------------------");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < op1String.Count; i++)
            {
                db.Writeln((string)op1String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < inverseMatrixResultString.Count; i++)
            {
                db.Writeln((string)inverseMatrixResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < testInverseMatrixResultString.Count; i++)
            {
                db.Writeln((string)testInverseMatrixResultString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 7th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Translate Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < transVecString.Count; i++)
            {
                db.Writeln((string)transVecString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(transVectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 8th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Scale Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < scalVecString.Count; i++)
            {
                db.Writeln((string)scalVecString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(scaleVectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 9th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Uniform Scale Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < scalScaString.Count; i++)
            {
                db.Writeln((string)scalScaString[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(uniformScaleVectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 10th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Rotate X 90 Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < rotX90String.Count; i++)
            {
                db.Writeln((string)rotX90String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(rotateX90VectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 11th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Rotate Y 90 Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < rotY90String.Count; i++)
            {
                db.Writeln((string)rotY90String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(rotateY90VectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 12th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Rotate Z 90 Vector Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < rotZ90String.Count; i++)
            {
                db.Writeln((string)rotZ90String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(rotateZ90VectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);


            // Add text into the 13th paragraph.
            db.CharacterFormat.ClearFormatting();
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            //db.CharacterFormat.FontColor = Color.Blue;
            db.CharacterFormat.Bold = true;


            db.Write("Rotate 90 Vector [1,1,1] Test");
            // Insert a line break into the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            // Insert 2nd line with own formatting to the 2nd paragraph.
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;


            db.Writeln(vec1String);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("*");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            for (int i = 0; i < rotVec90String.Count; i++)
            {
                db.Writeln((string)rotVec90String[i]);
                db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            }
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln("=");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Writeln(rotate90VectorResultString);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);





            // Save the document to the file in DOCX format.
            dc.Save(docPath, new DocxSaveOptions()
            { EmbeddedJpegQuality = 90 });

            // Open the result for demonstration purposes.
            System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo(docPath) { UseShellExecute = true });
        }
    }
}
