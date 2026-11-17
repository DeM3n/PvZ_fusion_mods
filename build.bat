@echo off
echo ====================================================
echo   Building CharmatronAutoFeedMetalObject (.NET 6)
echo ====================================================

powershell -Command "$refs = Get-ChildItem 'C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\System*.dll' | Where-Object { $_.Name -notmatch 'Native' } | ForEach-Object { '/r:\"\"' + $_.FullName + '\"\"' }; $extra = @('/r:\"\"C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\netstandard.dll\"\"', '/r:\"\"C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.36\mscorlib.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\net6\MelonLoader.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\net6\0Harmony.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\net6\Il2CppInterop.Runtime.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\Il2CppAssemblies\Il2Cppmscorlib.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\Il2CppAssemblies\Assembly-CSharp.dll\"\"', '/r:\"\"D:\Games\Game Files\MelonLoader\Il2CppAssemblies\UnityEngine.CoreModule.dll\"\"'); $args = @('/noconfig', '/target:library', '/out:bin\Release\net6.0\CharmatronAutoFeedMetalObject.dll') + $refs + $extra + @('Class1.cs'); & 'dotnet' 'C:\Program Files\dotnet\sdk\9.0.309\Roslyn\bincore\csc.dll' $args"

if exist "bin\Release\net6.0\CharmatronAutoFeedMetalObject.dll" (
    echo.
    echo [BUILD SUCCESSFUL] File built: bin\Release\net6.0\CharmatronAutoFeedMetalObject.dll
) else (
    echo.
    echo [BUILD FAILED] Could not build CharmatronAutoFeedMetalObject.dll
)
pause
