@echo off
:: 关闭应用服务器
tasklist|find /i "P210Server802.exe" && taskkill /f /im P210Server802.exe
tasklist|find /i "gnss2_srv.exe" && taskkill /f /im gnss2_srv.exe
tasklist|find /i "MonitorServer.exe" && taskkill /f /im MonitorServer.exe

:: 关闭客户端
tasklist|find /i "GNSS_2clnt.exe" && taskkill /f /im GNSS_2clnt.exe

:: 重启sql一系列服务
tasklist|find /i "SQLAGENT.exe" && net stop SQLSERVERAGENT
net start|findstr /i /c:"MSSQLSERVER" && net stop MSSQLSERVER
tasklist|find /i "SQLBrowser.exe" && net stop SQLBROWSER

net start MSSQLSERVER
net start SQLSERVERAGENT
net start SQLBROWSER

:: 启动应用服务器
start C:\SyncView\Server\MonitorServer.exe

:: 暂停5秒
choice /t 10 /d y /n >nul

:: 启动客户端
start C:\SyncView\client\GNSS_2clnt.exe

:: 暂停5秒
choice /t 5 /d y /n >nul

:: 关闭客户端
tasklist|find /i "GNSS_2clnt.exe" && taskkill /f /im GNSS_2clnt.exe