; 翻译 - 安装程序脚本 (Inno Setup)
; 用法: ISCC.exe 翻译.iss

#define MyAppName "翻译"
#define MyAppVersion "1.0.0"
#define MyAppExeName "翻译.exe"

[Setup]
AppId={{8F4C9B2E-3D6A-4E5B-9C21-7A0B6F4E8D2C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=本地翻译工具
AppVerName={#MyAppName} {#MyAppVersion}
; 默认安装到用户目录（无需管理员权限），安装时可自由选择任意路径
DefaultDirName={userpf}\{#MyAppName}
DisableDirPage=no
DisableProgramGroupPage=yes
OutputDir=installer
OutputBaseFilename=翻译-安装程序
SetupIconFile=app.ico
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; 允许用户自选安装路径（包括非管理员可写目录）
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加任务："

[Files]
; Nuitka 编译产物（翻译.exe + 依赖）
Source: "nuitka_out\translator_app.dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Dirs]
; 安装时创建空的模型文件夹（模型由用户自行放入）
Name: "{app}\models"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "立即运行 {#MyAppName}"; Flags: nowait postinstall skipifsilent
