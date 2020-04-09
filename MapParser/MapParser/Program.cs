using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace MapParser
{
    class Program
    {
        static void Main(string[] args)
        {
            var mapCode = ReadMapCodeFromFile();
            var compressedMapCode = CompresseCode(mapCode);
            WriteCodeMapToFile(compressedMapCode);
        }

        private static void WriteCodeMapToFile(string compressedMapCode)
        {
            string pathToFile = @"..\HereIsCompressedCode.txt";
            StreamWriter sw = new StreamWriter(pathToFile);
            sw.WriteLine(compressedMapCode);
            sw.Close();
        }

        private static string CompresseCode(string mapCode)
        {
            var temp = "";
            for (int i = 0; i < mapCode.Length; i+=2)
            {

                var currentSymbol1 = mapCode[i];
                var currentSymbol2 = mapCode[i + 1];
                if (currentSymbol1 == '\r')
                {
                    temp += ", ";
                }
                else
                {
                    var amountOfRepSym = FindAmountOfRepSym(currentSymbol1, currentSymbol2, mapCode, i);
                    i += amountOfRepSym - 2;
                    var numInSx = currentSymbol1.ToString() + currentSymbol2.ToString();
                    int numInTn = Convert.ToInt32(numInSx, 16);
                    switch (amountOfRepSym)
                    {
                        
                        case 2:
                            temp += numInTn.ToString() + " ";
                            break;
                        default:
                            temp += numInTn.ToString() + "x" + (amountOfRepSym/2).ToString() + " ";
                            break;
                    }
                }
            }
            return temp;
        }

        private static int FindAmountOfRepSym(char currentSymbol1, char currentSymbol2, string mapCode, int startIndex)
        {
            int i = startIndex;
            while (mapCode.Length - 1 >= i && mapCode[i] == currentSymbol1 && mapCode[i+1] == currentSymbol2) i+=2;
            return i - startIndex;
        }

        private static string ReadMapCodeFromFile()
        {
            string pathToMapCode = @"..\putMapCodeHere.txt";
           
            StreamReader sr = new StreamReader(pathToMapCode);
            //var mapCode = sr.ReadToEnd(); 
            //return Regex.Replace(mapCode, @"[ \r\n\t]", "");
            return sr.ReadToEnd();
        }
    }
}
