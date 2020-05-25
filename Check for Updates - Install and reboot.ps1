<#
.SYNOPSIS
    Check for a specific scheduled task if does not exist the script will register a new one 
    Gets all available updates and install them using PSWindowsUpdate Module
.DESCRIPTION
    #PSWindowsUpdate Module installed, If you have an older Windows version Windows 7/8.1/ Windows Server 2008 R2/ 2012 R2 you will have to install it manually for Windows 10 Windows server 2016 and above the script will attempt to install it. 
    #PowerShell Min Version : 3.0
.NOTES
    Author:  Erick A. Moreno
    Email:   erickyruz@live.com.mx
    Date:    19 July 2019    
PowerShell
#>
$TaskExists? = $null
$TaskName    = "001_CheckAndInstallUpdates"
$TaskExists? = $($($(Get-ScheduledTask -TaskName $TaskName).Triggers).enabled)  -eq "True"

If(!$TaskExists?)
 {
  Write-Host "Scheduled Task Does not Exist, Attempting to Register new Job" -ForegroundColor DarkRed -BackgroundColor Yellow
  $ScriptName = "$PSCommandPath"
  $Duration   = (New-TimeSpan -Days (9999))
  $Repeat     = (New-TimeSpan -hours 6) #Change it to match your desired time lapse
  $Settings   = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd 
  $Argument   = $("-ExecutionPolicy Bypass -File ") + "`"" + $ScriptName + "`""
  $Action     = New-ScheduledTaskAction -Execute "$pshome\powershell.exe" -Argument  $Argument
  $Trigger    = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval $Repeat -RepetitionDuration $Duration
  $Principal  = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest 
  $Object     = New-ScheduledTask -Action $Action -Principal $Principal -Trigger $Trigger -Settings $Settings 
 
  Register-ScheduledTask $TaskName -InputObject $Object 
 }
Else
 { 
  Write-Host "Task/Job Already Registered:" -ForegroundColor Cyan
  Get-ScheduledTask -TaskName $TaskName
  Write-Host "Starting Update Process..." -ForegroundColor Cyan
 }

$PSVer       = $PSVersionTable.PSVersion.Major
$PSWUModule  = Get-Module -ListAvailable -Name PSWindowsUpdate
$timestamp   = $(Get-Date -Format 'yyyyMMdd_HHmmss_fff')
$ServerName  = $env:COMPUTERNAME


Function _Test-Versions($PSWUModule, $PSVer)
 {
  write-host "Checking Preriquisites:" -ForegroundColor Cyan
  
  If($PSVer -lt '3')
   {
    Write-Host "   PS Version: $PSVer" "(Fail)" -ForegroundColor DarkRed -BackgroundColor Yellow  
    Write-Host "   Please Install At Least PS Version 3 to Run this Script" -ForegroundColor DarkRed -BackgroundColor Yellow
   }
   else
   {
    Write-Host "   PS Version: $PSVer" "(Pass)" -ForegroundColor Green
   }

  If($PSWUModule)
   {
    Write-Host "   PSWindowsUpdate Module (Pass)" -ForegroundColor Green
   } 
  Else 
   {
    Try
     {
       Write-Host "Required Module Not Installed: PSWindowsUpdate Module" -ForegroundColor DarkRed -BackgroundColor Yellow
       Write-Host "    Attepmting to Install PSWindowsUpdate Module" -ForegroundColor DarkRed -BackgroundColor Yellow
       
       $PSGalleryIsTrusted? = Get-PSRepository -Name PSGallery 
        
        If($PSGalleryIsTrusted?.InstallationPolicy -ne "Trusted")
         {
          $OriginalTrustValue = $PSGalleryIsTrusted?.InstallationPolicy
          Write-host "Changing Installation Policy to 'Trusted'" -ForegroundColor Gray
          Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
         }
       Install-Module -Name PSWindowsUpdate -Confirm:$False  #-WhatIf
       Start-Sleep -m 2000
       
       Write-host "Changing Installation Policy to 'Original Value': $OriginalTrustValue" -ForegroundColor Gray
       Set-PSRepository -Name 'PSGallery' -InstallationPolicy $OriginalTrustValue 
       
       $ModuleInstalled? = Get-Module -ListAvailable -Name PSWindowsUpdate
        If(!$ModuleInstalled?)
         {
          Throw "   Unable to Install PSWindowsUpdate Module, Try Manual Installation from: 'https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc'" 
         }
        Else
         {
          Write-Host "PSWindowsUpdate Module Installed Successfully" -ForegroundColor Green
         }
     }
    Catch
     {
       Write-Host $Error[0] -ForegroundColor DarkRed -BackgroundColor Yellow
     }
   }

 }

 _Test-Versions $PSWUModule $PSVer 

#Check for Updates
Write-Host "Checking For Avaliable Updates:" -ForegroundColor Cyan
$AvailableUpdates = Get-WindowsUpdate
Write-Host   "   Updates Found:" -ForegroundColor Green

$Object2 = @()
Foreach($Update in $AvailableUpdates)
 {
  $HT = $null
        $HT = [ordered]@{
                         ComputerName         = $Update.ComputerName
                         Status               = $Update.Status
                         KB_ID                = $Update.KB
                         Size                 = $Update.Size
                         Title                = $Update.Title
                         RebootRequired       = $Update.RebootRequired
                         SupportUrl           = $Update.SupportUrl
                         EulaAccepted         = $Update.EulaAccepted
                         IsDownloaded         = $Update.IsDownloaded
                        }
        $Object2 += New-Object PSObject -Property $HT
  }

$Object2Str = $Object2 | FT | Out-String 
Write-Host  "$Object2Str" -ForegroundColor Gray
 
#Download / Install / Reboot
Write-Host "Downloading / Installing($($Object2.count)) Update(s)" -ForegroundColor DarkRed -BackgroundColor Yellow
$Object2Str | Out-File "$PSScriptRoot\UpdatesLogFile_$timestamp.log" -Encoding utf8

Get-WindowsUpdate -install -acceptall -autoreboot
