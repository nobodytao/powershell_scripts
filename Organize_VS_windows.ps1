$WindowTitle = "Visual Studio Code"
$ColumnsCount = 2
$PixelsBetweenColsRows = 5


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

        [DllImport("user32.dll", SetLastError = true)]
        static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
        const uint SWP_NOSIZE = 0x0001;
        const uint SWP_NOMOVE = 0x0002;
        const uint SWP_NOACTIVATE = 0x0010;
        static readonly IntPtr HWND_BOTTOM = new IntPtr(1);
        
        public static void SendWindowToBack(IntPtr hWnd)
                {
                SetWindowPos(hWnd, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
                }
        }

        public struct RECT
        {
        public int Left;        // x position of upper-left corner
        public int Top;         // y position of upper-left corner
        public int Right;       // x position of lower-right corner
        public int Bottom;      // y position of lower-right corner
        }
"@

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


$firsthwnd = WinExist $WindowTitle

if ($firsthwnd -ne 0)
    {
    $hwnd = 0
    $hwnd_array = @()
    $hwnd_array_index = 0

    while ($hwnd -ne $firsthwnd)
        {
        $hwnd = WinExist $WindowTitle
        [void][Window]::SendWindowToBack($hwnd);
        #echo $hwnd

        $hwnd_array += $hwnd

        $hwnd = WinExist $WindowTitle
        }
 
    $WindowsCount = 0
    $WindowsCount = $hwnd_array.Count

    If([bool]!($WindowsCount%2))
    {
       #Write-Host "$WindowsCount is EVEN"

    }
    Else
    {
       #Write-Host "$WindowsCount is ODD"
       #$Сoeff=[math]::ceiling($WindowsCount/$ColumnsCount)
       $WindowsCount = $WindowsCount + 1
    }

    # Get the primary screen
    $primaryScreen = [System.Windows.Forms.Screen]::PrimaryScreen
    $WindowsCountInRow=[Math]::Floor($WindowsCount/$ColumnsCount)

    #Get the screen resolution
    $ScreenWidth = $primaryScreen.WorkingArea.Width - $PixelsBetweenColsRows*$ColumnsCount
    $ScreenHeight = $primaryScreen.WorkingArea.Height - $PixelsBetweenColsRows*$WindowsCountInRow

    #
    $WindowWidth = [Math]::Floor($ScreenWidth/$ColumnsCount)
    $WindowHeight = [Math]::Floor($ScreenHeight/$WindowsCountInRow)

    $hwnd = 0
    $X = 0
    $hwnd_array_index = 0

    for ($CountInRow=0;$CountInRow -lt $ColumnsCount;$CountInRow++)
        {
        $Y = 0
        for ($CountInColumn=0;$CountInColumn -lt $WindowsCountInRow;$CountInColumn++)
            {
            if ($hwnd_array_index -eq $hwnd_array.Count) 
                {
                Break
                }
            $hwnd =$hwnd_array[$hwnd_array_index]
            #echo $hwnd 
            [Void][Window]::MoveWindow($hwnd, $X, $Y, $WindowWidth, $WindowHeight, $True)
            $Y = $Y + $WindowHeight + $PixelsBetweenColsRows
            $hwnd_array_index++
            }
        $X = $X + $WindowWidth + $PixelsBetweenColsRows
        }
    }
