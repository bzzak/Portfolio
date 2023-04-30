using System;
using System.Collections;
using SautinSoft.Document;

namespace Zadanie3MatGraf
{
    class Program
    {
        static void Main(string[] args)
        {
            MyQuaternion q1 = new MyQuaternion(3, 5, 1, 7);
            MyQuaternion q2 = new MyQuaternion(2, 4, 3, 2);

            MyVector p = new MyVector(1, 0, 0);
            MyVector point = new MyVector(-1, -1, -1);

            ArrayList results = new ArrayList();


            //Test Dodawania
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Addition Test");           
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion addResult = q1 + q2;
            results.Add(addResult);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  +  ");
            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(addResult.PrintAlgebraic());
            Console.WriteLine("\n");

            //Test Odejmowania
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Substraction Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion subResult = q1 - q2;
            results.Add(subResult);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  -  ");
            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(subResult.PrintAlgebraic());
            Console.WriteLine("\n");


            //Test Mnożenia przez skalar
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Multiplication by scalar Test");
            Console.Write("------------------------------");
            Console.Write("\n");
            
            MyQuaternion mulNumResult1 = q1 * 2;
            results.Add(mulNumResult1);
            MyQuaternion mulNumResult2 = 2 * q1;
            results.Add(mulNumResult2);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  *  ");
            Console.Write("2 ");
            Console.Write("  =  ");
            Console.Write(mulNumResult1.PrintAlgebraic());
            Console.WriteLine("\n");

            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("2 ");
            Console.Write(" *  ");
            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(mulNumResult2.PrintAlgebraic());
            Console.WriteLine("\n");


            //Test Dzielenia przez skalar
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Division by scalar Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion divNumResult1 = q1 / 2;
            results.Add(divNumResult1);
            MyQuaternion divNumResult2 = 2 / q1;
            results.Add(divNumResult2);


            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  /  ");
            Console.Write("2 ");
            Console.Write("  =  ");
            Console.Write(divNumResult1.PrintAlgebraic());
            Console.WriteLine("\n");

            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("2 ");
            Console.Write(" /  ");
            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(divNumResult2.PrintAlgebraic());
            Console.WriteLine("\n");

            //Test Mnożenia kwaternionów
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Quaternion Multiplication Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion mulResult1 = q1 * q2;
            results.Add(mulResult1);
            MyQuaternion mulResult2 = q2 * q1;
            results.Add(mulResult2);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  *  ");
            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(mulResult1.PrintAlgebraic());
            Console.WriteLine("\n");

            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  *  ");
            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(mulResult2.PrintAlgebraic());
            Console.WriteLine("\n");


            //Test Dzielenia kwaternionów
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Quaternion Division Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion divResult1 = q1 / q2;
            results.Add(divResult1);
            MyQuaternion divResult2 = q2 / q1;
            results.Add(divResult2);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  /  ");
            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(divResult1.PrintAlgebraic());
            Console.WriteLine("\n");

            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("( ");
            Console.Write(q2.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  /  ");
            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(divResult2.PrintAlgebraic());
            Console.WriteLine("\n");


            //Test Inwersji
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Inversion Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyQuaternion invResult = q1.Inverse();
            results.Add(invResult);
            MyQuaternion mulByInvResult = q1 * invResult;
            results.Add(mulByInvResult);

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  ^-1  ");
            Console.Write("  =  ");
            Console.Write(invResult.PrintAlgebraic());
            Console.WriteLine("\n");

            Console.Write("------------------------------");
            Console.Write("\n");

            Console.Write("( ");
            Console.Write(q1.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  *  ");
            Console.Write("( ");
            Console.Write(invResult.PrintAlgebraic());
            Console.Write(" )");
            Console.Write("  =  ");
            Console.Write(mulByInvResult.PrintAlgebraic());
            Console.WriteLine("\n");

            //Test Rotacji Wektora [-1, -1, -1] o 270 stopni wzdłuż osi [1, 0, 0]
            Console.Write("\n");
            Console.Write("------------------------------");
            Console.Write("\n");
            Console.WriteLine("Vector [-1, -1, -1] By 270 Degrees X Rotation Test");
            Console.Write("------------------------------");
            Console.Write("\n");

            MyVector rotatedVector = MyQuaternion.RotateVector(p, 270, point);
            results.Add(rotatedVector);

            Console.Write("Vector [  " + point.printString() + "] rotated by 270 degrees along pivot [  " + p.printString() + "] : [  " + rotatedVector.printString() + "]");
            Console.Write("\n\n");



            CreateDocxUsingDocumentBuilder(q1, q2, p, point, results);


        }


        public static void CreateDocxUsingDocumentBuilder(MyQuaternion q1, MyQuaternion q2, MyVector p, MyVector vec, ArrayList results)
        {
            String q1String = q1.PrintAlgebraic();
            String q2String = q2.PrintAlgebraic();
            String pString = "[  " + p.printString() + "]";
            String vecString = "[  " + vec.printString() + "]";

            String addResultString = ((MyQuaternion)results[0]).PrintAlgebraic();
            String subResultString = ((MyQuaternion)results[1]).PrintAlgebraic();
            String mulNumResult1String = ((MyQuaternion)results[2]).PrintAlgebraic();
            String mulNumResult2String = ((MyQuaternion)results[3]).PrintAlgebraic();
            String divNumResult1String = ((MyQuaternion)results[4]).PrintAlgebraic();
            String divNumResult2String = ((MyQuaternion)results[5]).PrintAlgebraic();
            String mulResult1String = ((MyQuaternion)results[6]).PrintAlgebraic();
            String mulResult2String = ((MyQuaternion)results[7]).PrintAlgebraic();
            String divResult1String = ((MyQuaternion)results[8]).PrintAlgebraic();
            String divResult2String = ((MyQuaternion)results[9]).PrintAlgebraic();
            String invResultString = ((MyQuaternion)results[10]).PrintAlgebraic();
            String mulByInvResultString = ((MyQuaternion)results[11]).PrintAlgebraic();
            String rotatedVectorString = "[  " + ((MyVector)results[12]).printString() + "]";


            String addTestStringContent = $@"( {q1String} ) + ( {q2String} ) = {addResultString}";
            String subTestStringContent = $@"( {q1String} ) - ( {q2String} ) = {subResultString}";
            String mulNumTestStringContent1 = $@"( {q1String} ) * 2 = {mulNumResult1String}";
            String mulNumTestStringContent2 = $@" 2 * ( {q1String} ) = {mulNumResult2String}";
            String divNumTestStringContent1 = $@"( {q1String} ) / 2 = {divNumResult1String}";
            String divNumTestStringContent2 = $@" 2 / ( {q1String} ) = {divNumResult2String}";
            String mulTestStringContent1 = $@"( {q1String} ) * ( {q2String} ) = {mulResult1String}";
            String mulTestStringContent2 = $@"( {q2String} ) * ( {q1String} ) = {mulResult2String}";
            String divTestStringContent1 = $@"( {q1String} ) / ( {q2String} ) = {divResult1String}";
            String divTestStringContent2 = $@"( {q2String} ) / ( {q1String} ) = {divResult2String}";
            String invTestStringContent1 = $@"( {q1String} ) ^-1 = {invResultString}";
            String invTestStringContent2 = $@"( {q1String} ) * ( {invResultString} ) = {mulByInvResultString}";
            String rotateTestStringContent = $@"Vector {vecString} rotated along pivot {pString} by 270 degrees: {rotatedVectorString}";




            // Set a path to our document.
            string docPath = @"Quqternion-Test-Result.docx";

            // Create a new document and DocumentBuilder.
            DocumentCore dc = new DocumentCore();
            DocumentBuilder db = new DocumentBuilder(dc);

            // Set page size A4.
            Section section = db.Document.Sections[0];
            section.PageSetup.PaperType = PaperType.A4;

            AddPara(db, "Quaternion Addition Test");

            SingleFillPara(db, addTestStringContent);

            AddPara(db, "Quaternion Substraction Test");

            SingleFillPara(db, subTestStringContent);

            AddPara(db, "Quaternion Scalar Multiplication Test");

            DoubleFillPara(db, mulNumTestStringContent1, mulNumTestStringContent2);

            AddPara(db, "Quaternion Scalar Division Test");

            DoubleFillPara(db, divNumTestStringContent1, divNumTestStringContent2);

            AddPara(db, "Quaternion  Multiplication Test");

            DoubleFillPara(db, mulTestStringContent1, mulTestStringContent2);

            AddPara(db, "Quaternion Division Test");

            DoubleFillPara(db, divTestStringContent1, divTestStringContent2);

            AddPara(db, "Quaternion Inversion Test");

            DoubleFillPara(db, invTestStringContent1, invTestStringContent2);


            AddPara(db, "Vector [-1, -1, -1] X Axis Rotation By 270 Degrees Test");

            SingleFillPara(db, rotateTestStringContent);

            // Save the document to the file in DOCX format.
            dc.Save(docPath, new DocxSaveOptions()
            { EmbeddedJpegQuality = 90 });

            // Open the result for demonstration purposes.
            System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo(docPath) { UseShellExecute = true });
        }

        public static void AddPara(DocumentBuilder db, string name)
        {
            // Add  paragraph with formatted text.
            db.CharacterFormat.FontName = "Source Code Pro Medium";
            db.CharacterFormat.Size = 16;
            db.CharacterFormat.Bold = true;

            //Add Test
            db.Write(name);

            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.CharacterFormat.Size = 10;
            db.CharacterFormat.Bold = false;
        }

        public static void SingleFillPara(DocumentBuilder db, string content)
        {         

            db.Write(content);

            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
        }

        public static void DoubleFillPara(DocumentBuilder db, string content1, string content2)
        {            

            db.Write(content1);

            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.Write("-------------------------------------");
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);

            db.Write(content2);

            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
            db.InsertSpecialCharacter(SpecialCharacterType.LineBreak);
        }
    }
}
