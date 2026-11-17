@echo off
echo ====================================================
echo   Building PvZ Fusion Mods (.NET 6)
echo ====================================================

powershell -Command "$refs = Get-ChildItem 'C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\System*.dll' | Where-Object { $_.Name -notmatch 'Native' } | ForEach-Object { '/r:\"\"' + $_.FullName + '\"\"' }; $extra = @('/r:\"\"C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\netstandard.dll\"\"', '/r:\"\"C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\mscorlib.dll\"\"'); $lib = Get-ChildItem 'lib\*.dll' -Recurse | ForEach-Object { '/r:\"\"' + $_.FullName + '\"\"' }; New-Item -ItemType Directory -Path 'src\CharmatronAutoFeed\bin\Release' -Force | Out-Null; $args = @('/noconfig', '/target:library', '/out:src\CharmatronAutoFeed\bin\Release\CharmatronAutoFeedMetalObject.dll') + $refs + $extra + $lib + @('src\CharmatronAutoFeed\CharmatronAutoFeed.cs'); & 'dotnet' 'C:\Program Files\dotnet\sdk\9.0.309\Roslyn\bincore\csc.dll' $args"

if exist "src\CharmatronAutoFeed\bin\Release\CharmatronAutoFeedMetalObject.dll" (
    echo.
    echo [BUILD SUCCESSFUL] File built: src\CharmatronAutoFeed\bin\Release\CharmatronAutoFeedMetalObject.dll
) else (
    echo.
    echo [BUILD FAILED] Could not build CharmatronAutoFeedMetalObject.dll
)
pause
