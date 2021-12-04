#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Blue Fire_101.ico
#AutoIt3Wrapper_Outfile=BlueFire_Patch_5.0.5X86.exe
#AutoIt3Wrapper_Outfile_x64=BlueFire_Patch_5.0.5X64.exe
#AutoIt3Wrapper_Compile_Both=n
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=Mod developed by William112792
#AutoIt3Wrapper_Res_Description=Amazon and DRM Patch to 5.0.5
#AutoIt3Wrapper_Res_Fileversion=4.25.4.0
#AutoIt3Wrapper_Res_ProductName=BootstrapPackagedGame
#AutoIt3Wrapper_Res_ProductVersion=4.25.4.0
#AutoIt3Wrapper_Res_CompanyName=Robi Studios
#AutoIt3Wrapper_Res_LegalCopyright=Fill out your copyright in the Description page of Project Settings.
#AutoIt3Wrapper_Res_LegalTradeMarks=Robi Studios
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ### Included Scripts ###
#include <Array.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <Inet.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <WinApi.au3>
#EndRegion ### Finished Inclusions ###

; Export Script used to create Patch
If(FileExists(@ScriptDir & "\export.txt") = 1) Then
	FileInstall("W:\Blue Fire\Blue Fire_101.ico", @ScriptDir & "\Blue Fire_101.ico", 1)
	FileInstall("W:\Blue Fire\BlueFirePatch_5.0.5.au3", @ScriptDir & "\BlueFirePatch_5.0.5.au3", 1)
EndIf

; Find and Set Blue Fire Location
If(FileExists(@ScriptDir & "\PROA34.exe") = 1) Then
	$sBlueFireLocation = @ScriptDir & "\PROA34.exe"
ElseIf(FileExists(@ScriptDir & "\Blue Fire.exe") = 1) Then
	$sBlueFireLocation = @ScriptDir & "\Blue Fire.exe"
ElseIf(FileExists(@ProgramFilesDir & "\Amazon Games\Library\Blue Fire\Blue Fire.exe") = 1) Then
	$sBlueFireLocation = @ProgramFilesDir & "\Amazon Games\Library\Blue Fire\Blue Fire.exe"
ElseIf(FileExists("C:\Program Files (x86)\Amazon Games\Library\Blue Fire\Blue Fire.exe") = 1) Then
	$sBlueFireLocation = "C:\Program Files (x86)\Amazon Games\Library\Blue Fire\Blue Fire.exe"
ElseIf(FileExists("D:\Program Files (x86)\Amazon Games\Library\Blue Fire\Blue Fire.exe") = 1) Then
	$sBlueFireLocation = "D:\Program Files (x86)\Amazon Games\Library\Blue Fire\Blue Fire.exe"
Else
	MsgBox($MB_SYSTEMMODAL, "", "Error: Unable to locate Blue Fire.")
	Exit
EndIf

; Determine the Directory of Blue Fire from location
$sBlueFireDir = _SBfpsplit($sBlueFireLocation, 2)

; Verify the Directory of Blue Fire is set as a Directory
If(StringRight($sBlueFireDir,1) = "\") Then
	Local $sLocalPath = $sBlueFireDir
Else
	Local $sLocalPath = $sBlueFireDir & "\"
EndIf

; Check for Package file
If(FileExists(@ScriptDir & "\PROA34-WindowsNoEditor.pak") = 0) Then
	MsgBox($MB_SYSTEMMODAL, "", "Error: Missing Package file for Blue Fire.")
	Exit
EndIf

; Check the current version of UE Engine for Blue Fire
If(FileExists($sLocalPath & "PROA34.exe") = 1) Then $sInstalledVers = FileGetVersion($sLocalPath & "PROA34.exe")
If(FileExists($sLocalPath & "Blue Fire.exe") = 1) Then $sInstalledVers = FileGetVersion($sLocalPath & "Blue Fire.exe")

; Check Version of Patch
$sPatchVers = FileGetVersion(@ScriptName)

If($sInstalledVers >= $sPatchVers) Then
	; Abort if version is equal to or higher
	MsgBox($MB_SYSTEMMODAL, "", "Abort: Version of Blue Fire already Patched.")
	Exit
EndIf

; Clean up existing archives from old patch attempt
If(FileExists($sLocalPath & "Engine.zip") = 1) Then FileDelete($sLocalPath & "Engine.zip")
If(FileExists($sLocalPath & "PROA34.zip") = 1) Then FileDelete($sLocalPath & "PROA34.zip")

; Install Patched Engine files
If(FileExists($sLocalPath & "Engine") = 1) Then DirRemove($sLocalPath & "Engine", 1)
If(FileExists($sLocalPath & "Engine.zip") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\Engine.zip", $sLocalPath & "Engine.zip", 1)
_Shell_UnZipFile($sLocalPath & "Engine.zip", $sLocalPath)
If(FileExists($sLocalPath & "Engine.zip") = 1) Then FileDelete($sLocalPath & "Engine.zip")

; Install Patched Game files
If(FileExists($sLocalPath & "PROA34") = 1) Then DirRemove($sLocalPath & "PROA34", 1)
If(FileExists($sLocalPath & "PROA34.zip") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\PROA34.zip", $sLocalPath & "PROA34.zip", 1)
_Shell_UnZipFile($sLocalPath & "PROA34.zip", $sLocalPath)
If(FileExists($sLocalPath & "PROA34.zip") = 1) Then FileDelete($sLocalPath & "PROA34.zip")

; Install Patched Manifest files
If(FileExists($sLocalPath & "Manifest_DebugFiles_Win64.txt") = 1) Then FileDelete($sLocalPath & "Manifest_DebugFiles_Win64.txt")
If(FileExists($sLocalPath & "Manifest_DebugFiles_Win64.txt") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\Manifest_DebugFiles_Win64.txt", $sLocalPath & "Manifest_DebugFiles_Win64.txt", 1)
If(FileExists($sLocalPath & "Manifest_NonUFSFiles_Win64.txt") = 1) Then FileDelete($sLocalPath & "Manifest_NonUFSFiles_Win64.txt")
If(FileExists($sLocalPath & "Manifest_NonUFSFiles_Win64.txt") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\Manifest_NonUFSFiles_Win64.txt", $sLocalPath & "Manifest_NonUFSFiles_Win64.txt", 1)

; Install Patched Game Package file
If(FileExists($sLocalPath & "PROA34\Content\Paks\PROA34-WindowsNoEditor.pak") = 1) Then FileDelete($sLocalPath & "PROA34\Content\Paks\PROA34-WindowsNoEditor.pak")
;~ If(FileExists($sLocalPath & "PROA34\Content\Paks\PROA34-WindowsNoEditor.pak") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\PROA34-WindowsNoEditor.pak", $sLocalPath & "PROA34\Content\Paks\PROA34-WindowsNoEditor.pak", 1)
FileMove(@ScriptDir & "\PROA34-WindowsNoEditor.pak", $sLocalPath & "PROA34\Content\Paks\PROA34-WindowsNoEditor.pak", 1)

; Install Patched Game Executable file
If(FileExists($sLocalPath & "PROA34.exe") = 1) Then FileDelete($sLocalPath & "PROA34.exe")
If(FileExists($sLocalPath & "Blue Fire.exe") = 1) Then FileDelete($sLocalPath & "Blue Fire.exe")
If(FileExists($sLocalPath & "Blue Fire.exe") = 0) Then FileInstall("D:\BlueFire-Content\Game\Amazon\5.0.5_Blue_Fire_Amazon\Blue Fire.exe", $sLocalPath & "Blue Fire.exe", 1)

MsgBox($MB_SYSTEMMODAL, "", "Success: Blue Fire has been patched.", 15)

Func _SBfpsplit($SBPath, $SBType);$SBpath = file path to evaluate , $SBType = 1 for Drive, 2 for Path, 3 for File name, 4 for extension, 5 for drive letter only
    Local $SBfile, $SBSplit, $SBdrive, $SBfilepath, $SBnumber
    $SBSplit = StringSplit($SBPath, "\"); split into array
    $SBnumber = $SBSplit[0]; the number of strings returned
    $SBfilepath = ""
    for $1 = 1 to $SBnumber -1
        $SBfilepath = $SBfilepath & $SBSplit[$1] & "\"; path
    Next
    $SBfile = $SBSplit[($SBsplit[0])]; file
    $SBdrive = $SBSplit[1]; drive
    $SBfs = StringSplit($SBPath, "."); split into array
    if $SBfs[0] = 1 then
        $SBExt = ""; no extension found
    Else
        $SBExt = $SBfs[($SBfs[0])]; last . extentsion
    EndIf

    If $SBType = 1 then Return $SBdrive
    If $SBType = 2 then Return $SBfilepath
    If $SBType = 3 then Return $SBfile
    If $SBType = 4 then Return $SBExt
    If $SBType = 5 then Return StringLeft($SBdrive, 1)
EndFunc

Func _Shell_UnZipFile($sZipFile, $sDestFolder)
  If Not FileExists($sZipFile) Then Return SetError (1) ; source file does not exists
  If Not FileExists($sDestFolder) Then
    If Not DirCreate($sDestFolder) Then Return SetError (2) ; unable to create destination
  Else
    If Not StringInStr(FileGetAttrib($sDestFolder), "D") Then Return SetError (3) ; destination not folder
  EndIf
  Local $oShell = ObjCreate("shell.application")
  Local $oZip = $oShell.NameSpace($sZipFile)
  Local $iZipFileCount = $oZip.items.Count
  If Not $iZipFileCount Then Return SetError (4) ; zip file empty
  For $oFile In $oZip.items
	$oShell.NameSpace($sDestFolder).copyhere($oFile)
  Next
EndFunc
