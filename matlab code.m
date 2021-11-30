function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 03-Jan-2021 22:52:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function mag_Callback(hObject, eventdata, handles)
% hObject    handle to mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mag as text
%        str2double(get(hObject,'String')) returns contents of mag as a double


% --- Executes during object creation, after setting all properties.
function mag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function flap_Callback(hObject, eventdata, handles)
% hObject    handle to flap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flap as text
%        str2double(get(hObject,'String')) returns contents of flap as a double


% --- Executes during object creation, after setting all properties.
function flap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in Left.
function Left_Callback(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','2'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end


% --- Executes on button press in Foward.
function Foward_Callback(hObject, eventdata, handles)
% hObject    handle to Foward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','1'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end


% --- Executes on button press in Right.
function Right_Callback(hObject, eventdata, handles)
% hObject    handle to Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','3'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end

% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','4'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end

% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','6'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end


% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
magnitude = str2double(get(handles.mag, 'String'));
flapdeg = str2double(get(handles.flap, 'String'));
d = ['a', '0', '0', 'b', '0', '0','c','5'];

num2 = floor(magnitude/10);
num3 = magnitude-num2*10;
num5 = floor(flapdeg/10);
num6 = flapdeg-num5*10;

d(2) = int2str(num2);
d(3) = int2str(num3);
d(5) = int2str(num5);
d(6) = int2str(num6);
global bt;
for i = 1 : 8
    fwrite(bt,d(i),'char');
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bt;
delete(instrfindall);
fopen(bt);


% --- Executes on button press in cut.
function cut_Callback(hObject, eventdata, handles)
% hObject    handle to cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bt;
fclose(bt);
delete(instrfindall);bt = Bluetooth('HC-05', 1);
