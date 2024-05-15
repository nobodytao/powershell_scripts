
########################################################################
#   Settings:
########################################################################
# Path to Visual Studio Code   
$VSPath = "C:\Users\LV\AppData\Local\Programs\Microsoft VS Code\Code.exe"
# Name or part of the name Visual Studio Code window 
$WindowTitle = "Visual Studio Code"
# How much windows do you want
$WindowsCount = 6
#How much columns with windows do you want
$ColumnsCount = 2
# How much pixels will be between windows
$PixelsBetweenColsRows=5

########################################################################
#   Adding new type to manage windows
########################################################################
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class Window {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool GetWindowRect(
            IntPtr hWnd, out RECT lpRect);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public extern static bool MoveWindow( 
            IntPtr handle, int x, int y, int width, int height, bool redraw);

        [DllImport("user32.dll")] 
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool ShowWindow(
            IntPtr handle, int state);
        }
        public struct RECT
        {
        public int Left;        // x position of upper-left corner
        public int Top;         // y position of upper-left corner
        public int Right;       // x position of lower-right corner
        public int Bottom;      // y position of lower-right corner
        }
"@

########################################################################
#   Adding function to find out the handles of the new Visual Studio Code instances
########################################################################
Function WinExist($winTitle, $instance = 0)
{
    $h = Get-Process | Where-Object { $_.MainWindowTitle -like "*$winTitle*" } | ForEach-Object { $_.MainWindowHandle }
    if ( $h -eq $null )
    {
        return 0
    }
    else
    {
        if ( $h -is [System.Array] )
        {

            $h = $h[$instance]
        }
        return $h
    }
}

########################################################################
#   Run the windows with 
########################################################################

# Get the primary screen
$primaryScreen = [System.Windows.Forms.Screen]::PrimaryScreen
$WindowsCountInRow=[Math]::Floor($WindowsCount/$ColumnsCount)

#Get the screen resolution
$ScreenWidth = $primaryScreen.WorkingArea.Width - $PixelsBetweenColsRows*$ColumnsCount
$ScreenHeight = $primaryScreen.WorkingArea.Height - $PixelsBetweenColsRows*$WindowsCountInRow

#
$WindowWidth = [Math]::Floor($ScreenWidth/$ColumnsCount)
$WindowHeight = [Math]::Floor($ScreenHeight/$WindowsCountInRow)


#Move and resize windows
$X = 0
for ($CountInRow=0;$CountInRow -lt $ColumnsCount;$CountInRow++)
    {
    $Y = 0
    for ($CountInColumn=0;$CountInColumn -lt $WindowsCountInRow;$CountInColumn++)
        {
        #Run VS Code
        [System.Diagnostics.Process]::Start($VSPath)
        sleep 5

        #Take the handler of VS instance
        $hwnd = WinExist $WindowTitle 

        [Void][Window]::MoveWindow($hwnd, $X, $Y, $WindowWidth, $WindowHeight, $True)

        $Y = $Y + $WindowHeight + $PixelsBetweenColsRows
        }
    $X = $X + $WindowWidth + $PixelsBetweenColsRows
    }

