function varargout = ImportFolder(varargin)
% IMPORTFOLDER MATLAB code for ImportFolder.fig
%      IMPORTFOLDER, by itself, creates a new IMPORTFOLDER or raises the existing
%      singleton*.
%
%      H = IMPORTFOLDER returns the handle to a new IMPORTFOLDER or the handle to
%      the existing singleton*.
%
%      IMPORTFOLDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORTFOLDER.M with the given input arguments.
%
%      IMPORTFOLDER('Property','Value',...) creates a new IMPORTFOLDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImportFolder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImportFolder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImportFolder

% Last Modified by GUIDE v2.5 30-Jul-2012 17:23:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImportFolder_OpeningFcn, ...
                   'gui_OutputFcn',  @ImportFolder_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ImportFolder is made visible.
function ImportFolder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImportFolder (see VARARGIN)
userData.sourceFileName = [];
userData.mobiDataDirectory= [];
set(handles.figure1,'UserData',userData);
handles.output = hObject;
guidata(hObject, handles);
if isempty(varargin), return;end
mobilab = varargin{1};
set(handles.figure1,'Color',mobilab.preferences.gui.backgroundColor);
set(handles.uipanel1,'BackgroundColor',mobilab.preferences.gui.backgroundColor);
set(handles.uipanel2,'BackgroundColor',mobilab.preferences.gui.backgroundColor);
set(handles.uipanel2,'BackgroundColor',mobilab.preferences.gui.backgroundColor);
set(handles.text2,'BackgroundColor',mobilab.preferences.gui.backgroundColor);
set(handles.text3,'BackgroundColor',mobilab.preferences.gui.backgroundColor);
set(handles.text6,'BackgroundColor',mobilab.preferences.gui.backgroundColor);

% UIWAIT makes ImportFolder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImportFolder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% OK
function pushbutton1_Callback(hObject, eventdata, handles)
sourceFileName = get(handles.edit1,'string');
rootDir        = get(handles.edit4,'string');
dataSourceName = get(handles.edit3,'string');
ind = strfind(dataSourceName,'_MoBI');
if ~isempty(ind), 
    dataSourceName(ind:ind+4) = [];
    set(handles.edit3,'string',dataSourceName);
end

mobiDataDirectory = fullfile(rootDir,[dataSourceName '_MoBI']);
if ~exist([rootDir filesep dataSourceName '_MoBI'],'dir')
    try
        mkdir(mobiDataDirectory);
    catch ME
        mobiDataDirectory = [];
        uiresume;
        errordlg(ME.message);
    end
elseif exist([mobiDataDirectory filesep 'descriptor.MoBI'],'file') 
    choice = questdlg2(...
        sprintf('This folder contains a dataSource.\nAll the previous data will be removed.\n Would you like to continue?'),...
        'Warning!!!','Yes','No','No');
    switch choice
        case 'Yes'
            warning off %#ok
            try rmdir(mobiDataDirectory,'s');end %#ok
            try mkdir(mobiDataDirectory);end     %#ok
            warning on %#ok
        case 'No'
            mobiDataDirectory = [];
            return
        otherwise
            mobiDataDirectory = [];
            return
    end
end
userData.source = sourceFileName;
userData.mobiDataDirectory = mobiDataDirectory;
set(handles.figure1,'UserData',userData);
uiresume


% Cancel
function pushbutton2_Callback(hObject, eventdata, handles)
userData = []; 
set(handles.figure1,'UserData',userData);
uiresume
%close(handles.figure1);

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Enter the DataRiver (.drf) file:
function pushbutton3_Callback(hObject, eventdata, handles)
source = uigetdir2('Select folder');
if isnumeric(source), return;end
[pathName,name,ext] = fileparts(source);
set(handles.edit1,'string',source);
set(handles.edit4,'string',pathName);
set(handles.edit3,'string',name);



% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Provide the directory where save the MoBI dataSource:
function pushbutton6_Callback(hObject, eventdata, handles)
rootDir = uigetdir2('Select the root directory for the memory-mapped dataSource files');
if isnumeric(rootDir), return;end
if isempty(rootDir), return;end
set(handles.edit4,'string',rootDir);



% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% Help
function pushbutton7_Callback(hObject, eventdata, handles)
web http://sccn.ucsd.edu/wiki/Mobilab_software/MoBILAB_toolbox_tutorial


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
uiresume


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
