using Kody.utility;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Kody
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        private string fileName = "Please choose a file!";
        private string dataBoxInfo = "Text representation of file content:";
        public FileOperations ChosenFile { get; set; } = null;
        public event PropertyChangedEventHandler PropertyChanged;

        public string FileName 
        {
            get
            {
                return fileName;
            }
            set
            {
                fileName = value;
                OnPropertyChanged(nameof(FileName));
            } 
        } 
        public string DataBoxInfo
        {
            get
            {
                return dataBoxInfo;
            }
            set
            {
                dataBoxInfo = value;
                OnPropertyChanged(nameof(DataBoxInfo));
            }
        }

        public MainWindow()
        {
            InitializeComponent();
            EncodeFileButton.IsEnabled = false;
            DecodeFileButton.IsEnabled = false;
            SaveFileButton.IsEnabled = false;
        }

        

        private void DecodeFileButton_Click(object sender, RoutedEventArgs e)
        {
            ChosenFile.FileData = DataBox.Text;
            ChosenFile.Decode();
            DataBoxInfo = "Text representation of decoded file:";
            DataBox.Text = ChosenFile.FileData;
            DataBox.IsReadOnly = true;
            EncodeFileButton.IsEnabled = true;
            DecodeFileButton.IsEnabled = false;
        }

        private void ExitButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void EncodeFileButton_Click(object sender, RoutedEventArgs e)
        {
            ChosenFile.Encode();
            DataBoxInfo = "Text representation of binary encoded file:";
            DataBox.Text = ChosenFile.FileData;
            DataBox.IsReadOnly = false;
            EncodeFileButton.IsEnabled = false;
            DecodeFileButton.IsEnabled = true;
        }

        private void ChooseFileButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                ChosenFile = FileOperations.CreateFileOperations();
            }
            catch(ArgumentNullException)
            {
                return;
            }
            FileName = ChosenFile.Path;
            DataBoxInfo = "Text representation of file content:";
            DataBox.Text = ChosenFile.FileData;
            DataBox.IsReadOnly = true;
            EncodeFileButton.IsEnabled = true;
            DecodeFileButton.IsEnabled = false;
            SaveFileButton.IsEnabled = true;
        }

        private void OnPropertyChanged(string propertyName)
        {
            if(PropertyChanged != null) PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

        private void OpenEncodedFileButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                ChosenFile = FileOperations.CreateFileOperations();
            }
            catch (ArgumentNullException)
            {
                return;
            }
            FileName = ChosenFile.Path;
            DataBoxInfo = "Text representation of binary encoded file:";
            ChosenFile.FileData = Converters.StringToBinary(ChosenFile.FileData);
            DataBox.Text = ChosenFile.FileData;
            DataBox.IsReadOnly = false;
            EncodeFileButton.IsEnabled = false;
            DecodeFileButton.IsEnabled = true;
            SaveFileButton.IsEnabled = true;
        }

        private void SaveFileButton_Click(object sender, RoutedEventArgs e)
        {
            var button = (Button)sender;

            if (button != null)
            {
                var tt = new SaveFileDialog();
                tt.RestoreDirectory = true;

                if (DataBoxInfo == "Text representation of file content:" 
                    || DataBoxInfo == "Text representation of decoded file:")
                {
                    tt.DefaultExt = "txt";
                    tt.Filter = "txt files (*.txt)|*.txt";
                    if (tt.ShowDialog() == true)
                    {
                        Stream fileStream = tt.OpenFile();
                        var sw = new StreamWriter(fileStream);
                        sw.Write(DataBox.Text);
                        sw.Close();
                        fileStream.Close();
                    }
                }
                else
                {
                    tt.DefaultExt = "txt";
                    tt.Filter = "txt files (*.txt)|*.txt";
                    if (tt.ShowDialog() == true)
                    {
                        Stream fileStream = tt.OpenFile();
                        var sw = new StreamWriter(fileStream);

                        byte[] buff = new byte[DataBox.Text.Length / 8];
                        for (var i = 0; i < DataBox.Text.Length / 8; i++)
                        {
                            buff[i] = Convert.ToByte(DataBox.Text.Substring(i * 8, 8), 2);
                            sw.Write((char)buff[i]);
                        }
                        sw.Close();
                        fileStream.Close();
                    }
                }
            }
        }
    }
}
