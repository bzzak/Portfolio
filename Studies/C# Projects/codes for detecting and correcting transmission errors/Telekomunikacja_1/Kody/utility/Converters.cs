using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kody.utility
{
    internal static class Converters
    {
        internal static string StringToBinary(string data)
        {
            var sb = new StringBuilder();

            foreach (char c in data)
            {
                sb.Append(Convert.ToString(c, 2).PadLeft(8, '0'));

            }
            return sb.ToString();
        }

        internal static string ToBinary(char x)
        {
            char[] buff = new char[16];

            for (int i = 15; i >= 0; i--)
            {
                int mask = 1 << i;
                buff[15 - i] = (x & mask) != 0 ? '1' : '0';
            }

            return new string(buff);
        }
    }
}
