function varargout = SVM(varargin)
% SVM MATLAB code for SVM.fig
%      SVM, by itself, creates a new SVM or raises the existing
%      singleton*.
%
%      H = SVM returns the handle to a new SVM or the handle to
%      the existing singleton*.
%
%      SVM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVM.M with the given input arguments.
%
%      SVM('Property','Value',...) creates a new SVM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SVM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVM

% Last Modified by GUIDE v2.5 09-Apr-2018 09:41:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SVM_OpeningFcn, ...
                   'gui_OutputFcn',  @SVM_OutputFcn, ...
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


% --- Executes just before SVM is made visible.
function SVM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVM (see VARARGIN)

% Choose default command line output for SVM
handles.output = hObject;

% Delete the axis ticks
set(handles.axes1,'xtick',[],'ytick',[]);

% Initialize mouse position
handles.X = 0;
handles.Y = 0;

% Initialize pictures dimension
handles.width = 0;
handles.length = 0;

% Initialize relevent pictures
handles.Image = 0; % Original Image

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SVM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SVM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
set (gcf, 'WindowButtonMotionFcn', @Mouse_Move,'WindowButtonDownFcn',@Axes1_ButtonDownFcn,'DoubleBuffer', 'on');

function Mouse_Move(hObject, eventdata, handles)
% Get current mouse position
handles = guidata(hObject);
current_point = get(gca, 'CurrentPoint');
x = round(current_point(1,1)); 
y = round(current_point(1,2)); 
handles.X = x;
handles.Y = y;

% Return if exceed image dimension
if x < 1 || y < 1 || y > handles.width || x > handles.length
    guidata(hObject, handles);
    return
else
    % Update mouse information
    set(handles.X_loc, 'string', ['X: ' num2str(x)]);
    set(handles.Y_loc, 'string', ['Y: ' num2str(y)]);
end
guidata(hObject, handles);


function Axes1_ButtonDownFcn(hObject, eventdata, handles)
handles = guidata(hObject);
current_point = get(gca,'CurrentPoint');
AddDataPoint(double(current_point(1,1)),double(current_point(1,2)));
guidata(hObject, handles);


function OpenFile_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global picture;
% Get attributes of selected file
[filename,filepath] = uigetfile({'*.*','All Files'}, 'Select Image To Be Edited');
% Generate warning if no picture selected
if isequal(filename,0)||isequal(filepath,0)
    errordlg('No image selected','Error'); 
    return;  
else
    fullfile = [filepath filename];
    ImageFile = open(fullfile);
    ImageFile = struct2cell(ImageFile(1));
    ImageFile = cell2mat(ImageFile);
    handles.Image = ImageFile;
    picture = ImageFile;
    size(picture)
    [handles.width, handles.length, ~] = size(handles.Image);
    imshow(handles.Image);
    clear axes_scale
    axis off  

    % Initialize mouse position
    handles.X = 0;
    handles.Y = 0;
    
end
guidata(hObject, handles);


% --- Executes on button press in Load_VP.
function Load_VP_Callback(hObject, eventdata, handles)
% hObject    handle to Load_VP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vx vy vz;
global vlxy vlxz vlyz;
[FileName, PathName, FilterIndex] = uigetfile('.txt');
file = fullfile(PathName,FileName);
fid = fopen(file,'r');
stored = fscanf(fid,'%f');
vx = stored(1:3)';
vy = stored(4:6)';
vz = stored(7:9)';
vlxy = stored(10:12)';
vlxz = stored(13:15)';
vlyz = stored(16:18)';
disp(vx);disp(vy);disp(vz);disp(vlxy);disp(vlxz);disp(vlyz);
disp('Vanishing Points & Vanishing Line Loaded');
fclose(fid);

% --- Executes on button press in Save_VP.
function Save_VP_Callback(hObject, eventdata, handles)
% hObject    handle to Save_VP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vx vy vz;
global vlxy vlxz vlyz;
fid = fopen('vanishing.txt','w');
fprintf(fid,'%9.5f %9.5f %9.5f\n',vx(1),vx(2),vx(3));
fprintf(fid,'%9.5f %9.5f %9.5f\n',vy(1),vy(2),vy(3));
fprintf(fid,'%9.5f %9.5f %9.5f\n',vz(1),vz(2),vz(3));
fprintf(fid,'%9.8f %9.8f %9.8f\n',vlxy(1),vlxy(2),vlxy(3));
fprintf(fid,'%9.8f %9.8f %9.8f\n',vlxz(1),vlxz(2),vlxz(3));
fprintf(fid,'%9.8f %9.8f %9.8f\n',vlyz(1),vlyz(2),vlyz(3));
fclose(fid);
disp('Vanishing Points & Vanishing Line Saved');

% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DataType;
switch DataType
    case 'Parallel_Lines'
        Cal_VL();
        disp('Vanishing Point & Line Calculated');
    case 'Reference_Point'
        Cal();
        disp('Transformation Matrix Calculated');
end

% --- Executes on button press in Coplane.
function Coplane_Callback(hObject, eventdata, handles)
% hObject    handle to Coplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global setPlanes;

x = inputdlg('Enter space-separated numbers representing the points that are co-plane:');
data = str2num(x{:}); 
if (size(data,2)~=4)
   warndlg('Please enter 4 points','Error');
end
if (size(data,2) == 4)
   setPlanes = [setPlanes; data];
   disp(setPlanes);
end


% --- Executes on button press in Texture.
function Texture_Callback(hObject, eventdata, handles)
% hObject    handle to Texture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
GetTexture(handles.width,handles.length);
guidata(hObject, handles);


% --- Executes on button press in Model.
function Model_Callback(hObject, eventdata, handles)
% hObject    handle to Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveWRL()


% --- Executes on selection change in VariableType.
function VariableType_Callback(hObject, eventdata, handles)
% hObject    handle to VariableType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns VariableType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from VariableType
str=get(hObject,'String');
val=get(hObject,'Value');
global DataType;
% Parallel Lines
% Origin
% Reference Length
% Measuring Lines
% Texture Polygons
% Texture Path

switch str{val}
    case 'Parallel Lines'
       DataType = 'Parallel_Lines';
    case 'Origin'
       DataType = 'Origin';
    case 'Reference Point'
       DataType = 'Reference_Point';
    case 'Measuring Points'
        DataType = 'Measuring_Points'; 
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function VariableType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VariableType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Direction.
function Direction_Callback(hObject, eventdata, handles)
% hObject    handle to Direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Direction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Direction
global Direction;
str = get(hObject,'String');
val = get(hObject,'Value');
switch str{val}
    case 'X-Axis'
        Direction='X';
    case 'Y-Axis'
        Direction='Y';
    case 'Z-Axis'
        Direction='Z';
end

% --- Executes during object creation, after setting all properties.
function Direction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
