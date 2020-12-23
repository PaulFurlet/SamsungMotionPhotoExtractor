#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <String.au3>

$searchdata = StringTrimLeft(StringToBinary("MotionPhoto_Data"),2)
$title = 'Samsung Motion Photo Converter by AntidotE'
$version = '0.0.0.1'
Split()

Func Split()
    if $CmdLine[0] = 0 Then
		MsgBox($MB_SYSTEMMODAL,$title,'You need to specify input jpg file')
		Exit
	EndIf
	Local $sFilePath = $CmdLine[1]
	if StringRight($sFilePath,4) <> '.jpg' Then
        MsgBox($MB_SYSTEMMODAL, $title, "Only jpg files supported.")
        Return False
	EndIf
	Local $sFilemp4 = StringLeft($sFilePath,StringLen($sFilePath)-4) & "_cut.mp4"
	Local $sFilejpg = StringLeft($sFilePath,StringLen($sFilePath)-4) & "_cut.jpg"

    ; Open the file for reading and store the handle to a variable.
	Local $hFileOpen = FileOpen($sFilePath, $FO_READ + $FO_BINARY + $FO_ANSI)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, $title, "An error occurred when reading the file.")
        Return False
    EndIf

	; Read the contents of the file using the handle returned by FileOpen.
    Local $sFileRead = FileRead($hFileOpen)
	$sData = StringTrimLeft($sFileRead,2)
	Local $pos = StringInStr($sData,$searchdata)
	if $pos = 0 Then
        MsgBox($MB_SYSTEMMODAL, $title, "File does not contain required marker.")
		FileClose($hFileOpen)
        Return False
	EndIf
    FileClose($hFileOpen)
	Local $bData = Binary("")

	$bData = BinaryToString("0x" & StringMid($sData,1,$pos - 7)) ; -4 bytes
	Local $hFilejpg = FileOpen($sFilejpg, $FO_CREATEPATH + $FO_OVERWRITE + $FO_BINARY + $FO_ANSI)
	FileWrite($hFilejpg,$bData)
    FileClose($hFilejpg)
	$bData = BinaryToString("0x" & StringMid($sData,$pos + StringLen($searchdata)))
	Local $hFilemp4 = FileOpen($sFilemp4, $FO_CREATEPATH + $FO_OVERWRITE + $FO_BINARY + $FO_ANSI)
	FileWrite($hFilemp4,$bData)
    FileClose($hFilemp4)

EndFunc   ;==>Split