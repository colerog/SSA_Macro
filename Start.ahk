/*
SSA v0.3.0

Created by colerog & InformationDenier
Repository: https://github.com/colerog/SSA_Macro
*/

#Requires AutoHotkey v1.0
#SingleInstance Force

; Libraries and data
#Include %A_ScriptDir%\libraries
#Include %A_ScriptDir%\data

; Makes sure a settings file exists, if it doesnt it creates one
if (FileExist(A_ScriptDir . "\data\Settings.txt")){
    MsgBox, "FILE EXISTS"
} else {
    MsgBox, "FILE DOES NOT EXIST"
    FileAppend, Please do not manually change anything if you do not know what you are doing. `n Theme:-+-:Dark:-+-:Optimized:-+-:No:-+-:AutoInstall:-+-:No:-+-:AutoStart:-+-:No`nDiscord:-+-:No:-+-:DiscordWebhook:-+-:N/A:-+-:SendScreenShots:-+-:No:-+-:SendHPH:-+-:No:-+-:SendHourly:-+-:No, %A_WorkingDir%\data\Settings.txt
}

; Implements the settings into the code
goto, GetSettings
MsgBox, "Made it here"
goto, RewriteSettings

GetSettings:
    MsgBox, "Made it here1"
    FileReadLine, baseSettings, %A_ScriptDir%\data\Settings.txt, 2
    MsgBox, "Made it here2"
    FileReadLine, discordSettings, %A_ScriptDir%\data\Settings.txt, 3
    MsgBox, "Made it here3"
    BaseSettings := StrSplit(baseSettings, ":-+-:")
    theme := BaseSettings[2]
    optimized := BaseSettings[4]
    autoInstall := BaseSettings[6]
    autoStart := BaseSettings[8]

    DiscordSettings := StrSplit(discordSettings, ":-+-:")
    discord := DiscordSettings[2]
    discordWebhook := DiscordSettings[4]
    if (discordWebhook not contains "https://discord.com/api/webhooks/"){
        MsgBox, Does not contain
        discordWebhook := "N/A"
    }
    sendSS := DiscordSettings[6]
    sendHPH := DiscordSettings[8]
    sendHourly := DiscordSettings[10]
    MsgBox, "Made it here5"
    goto, RewriteSettings
return

; Write current settings into the settings file to update it
RewriteSettings:
MsgBox, "Made it here Delete"
FileDelete, %A_ScriptDir%\data\Settings.txt
MsgBox, %discordWebhook%
if (!InStr(discordWebhook, "https://discord.com/api/webhooks/")) {
    MsgBox, Changing it
    discordWebhook := "N/A"
}
FileAppend, Please do not manually change anything if you do not know what you are doing.`nTheme:-+-:%theme%:-+-:Optimized:-+-:%optimized%:-+-:AutoInstall:-+-:%autoInstall%:-+-:AutoStart:-+-:%autoStart%`nDiscord:-+-:%discord%:-+-:DiscordWebhook:-+-:%discordWebhook%:-+-:SendScreenShots:-+-:%sendSS%:-+-:SendHPH:-+-:%sendHPH%:-+-:SendHourly:-+-:%sendHourly%, %A_ScriptDir%\data\Settings.txt
MsgBox, "Made it here post append"
goto Setup
return

; Checking dependencies if not optimized
Setup:
depen = -1
if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey32.exe"){
    if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey64.exe") {
    depen = 3
    } else {
    depen = 1
    }
} else if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey64.exe") {
    depen = 2
} else {
    depen = 0
}
MsgBox, %depen%

if (optimized == "No"){
    if (depen == 3){
        ; All dependencies acounted for
    } else if (depen == 2){
        ; Missing Ahk 32
        Msgbox, "You are missing AHK 32 in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 32 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey32.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey32.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                MsgBox, "Restarting SSA now"
                Reload
            } else{
                MsgBox, "Failed to install AHK 32 into your dependencies folder"
                MsgBox, "Please manually download AHK 32 and restart SSA to continue"
                ExitApp
            }
        } else {
            MsgBox, "Please manually download AHK 32 and restart SSA to continue"
            ExitApp
        }
    } else if (depen == 1){
        ; Missing Ahk 64
        Msgbox, "You are missing AHK 64 in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 64 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey64.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey64.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey64.exe")){
                MsgBox, "Succesfully installed AHK 64 into your dependencies folder"
                MsgBox, "Restarting SSA now"
                Reload
            } else{
                MsgBox, "Failed to install AHK 64 into your dependencies folder"
                MsgBox, "Please manually download AHK 64 and restart SSA to continue"
                ExitApp
            }
        } else {
            MsgBox, "Please manually download AHK 64 and restart SSA to continue"
            ExitApp
        }
    } else {
        ; Missing both
        Msgbox, "You are missing both versions of AHK in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 64 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey64.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey64.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            MsgBox, "Attempting to download AHK 32 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey32.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey32.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey64.exe")){
                MsgBox, "Succesfully installed AHK 64 into your dependencies folder"
                if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                    MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                    MsgBox, "Restarting SSA now"
                    Reload
                } else {
                    MsgBox, "Failed to install AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download AHK 32 and restart SSA to continue"
                    ExitApp
                }
            } else{
                if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                    MsgBox, "Failed to install AHK 64 into your dependencies folder"
                    MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download AHK 64 and restart SSA to continue"
                    ExitApp
                } else {
                    MsgBox, "Failed to install both AHK 64 and AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download both AHK 64 and AHK 32 and restart SSA to continue"
                }
            }
        } else {
            MsgBox, "Please manually download both AHK 32 and AHK 64 and restart SSA to continue"
        }
    }
}

MsgBox, "Made it here pre discord"
MsgBox, %discord%
MsgBox, %discordWebhook%
; Discord Integration
checkDiscord := False
if (discord = "Yes") and (discordWebhook != "N/A") and (InStr(discordWebhook, "https://discord.com/api/webhooks/")){
    MsgBox, "DISCORD"
    ; Check for wifi connection here
    if (optimized == "No"){
        While (checkDiscord != True){
            random, numberCheck, 1000000,9999999


            ; Add in sending message here
            postdata=
                (
                {
                    "embeds": [
                    {
                    "title": "SSA",
                    "description": "Your code: \n %numberCheck% ",
                    "color": 550619
                    }
                ]
            }
            )

            WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
            WebRequest.Open("POST", discordWebhook, false)
            WebRequest.SetRequestHeader("Content-Type", "application/json")
            WebRequest.Send(postdata) 
            
            MsgBox, 4, "Discord Integration","Does the code below line up with the discord code:" . `n %numberCheck% 

            IfMsgBox, Yes
                checkDiscord := True
            else{
                InputBox, newWebhook, "Discord Integration", "Please enter a new webhook url here:",
                if ErrorLevel
                    checkDiscord := True
                else {
                    discordWebhook := newWebhook
                    goto, RewriteSettings
                }
            }
        }
    } else {

        ; Send a message in discord saying connected
    }
}

; Gui Creation
SysGet, monitorCount, MonitorCount
SysGet, mainMonitor, MonitorPrimary
SysGet, primMon, Monitor, mainMonitor
screenLeft := primMonLeft
screenRight := primMonRight
screenBottom := primMonBottom
screenTop := primMonTop
screenWidthMiddle := (primMonRight - primMonLeft)/2
screenHeightMiddle := (primMonBottom - primMonTop)/2
guiWidth := (primMonBottom - primMonTop)/2.5
guiHeight := (primMonRight - primMonLeft)/8

Gui, SSA:New, AlwaysOnTop -Caption, SSA

; Adds in theme colors
FileReadLine, themeMainColor, %A_ScriptDir%\assets\themes\ . %theme% . .txt, 4
Gui, Color, %themeMainColor%
titleLoadWidth := guiWidth/1.5
titleLoadHeight := guiHeight/1.5
Gui, Show,w%guiWidth% h%guiHeight%


return

^x::ExitApp