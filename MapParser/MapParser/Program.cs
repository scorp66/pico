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
            var compressedMapCode = compresseCode(mapCode);
            WriteCodeMapToFile(compressedMapCode);
        }

        private static void WriteCodeMapToFile(string compressedMapCode)
        {
            string pathToFile = @"..\HereIsCompressedCode.txt";
            StreamWriter sw = new StreamWriter(pathToFile);
            sw.WriteLine(compressedMapCode);
            sw.Close();
        }

        private static string compresseCode(string mapCode)
        {
            var temp = "";
            for (int i = 0; i < mapCode.Length; i++)
            {

                var currentSymbol = mapCode[i];
                if (currentSymbol == '\r')
                {
                    temp += ", ";
                    i += 1;
                }
                else
                {
                    var amountOfRepSym = FindAmountOfRepSym(currentSymbol, mapCode, i);
                    i += amountOfRepSym - 1;
                    switch (amountOfRepSym)
                    {
                        case 1:
                            temp += currentSymbol.ToString() + " ";
                            break;
                        case 2:
                            temp += currentSymbol.ToString() + currentSymbol.ToString() + " ";
                            break;
                        default:
                            temp += currentSymbol.ToString() + "x" + amountOfRepSym.ToString() + " ";
                            break;
                    }
                }
            }
            return temp;
        }

        private static int FindAmountOfRepSym(char currentSymbol, string mapCode, int startIndex)
        {
            int i = startIndex;
            while (mapCode.Length - 1 >= i && mapCode[i] == currentSymbol) i++;
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
