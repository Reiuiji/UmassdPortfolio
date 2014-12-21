%ECE 335 Project
%(c) Daniel Noyes, MIT License
function varargout = projectgui(varargin)
% PROJECTGUI MATLAB code for projectgui.fig
%      PROJECTGUI, by itself, creates a new PROJECTGUI or raises the existing
%      singleton*.
%
%      H = PROJECTGUI returns the handle to a new PROJECTGUI or the handle to
%      the existing singleton*.
%
%      PROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTGUI.M with the given input arguments.
%
%      PROJECTGUI('Property','Value',...) creates a new PROJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projectgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projectgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projectgui

% Last Modified by GUIDE v2.5 10-Dec-2014 10:39:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projectgui_OpeningFcn, ...
                   'gui_OutputFcn',  @projectgui_OutputFcn, ...
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


% --- Executes just before projectgui is made visible.
function projectgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projectgui (see VARARGIN)

% Choose default command line output for projectgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes projectgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projectgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Process Input
V1 = str2double(get(handles.V1, 'String'));
V2 = str2double(get(handles.V2, 'String'));
Height = str2double(get(handles.Height, 'String'));
Width = str2double(get(handles.Width, 'String'));
Scale = str2double(get(handles.Scale, 'String'));
SumInt = int16(str2double(get(handles.SumInt, 'String')));

%Run the routine
handles.x= 0:Scale:Width;
handles.y= 0:Scale:Height;
x = handles.x;
y = handles.y;

handles.V = zeros(length(y),length(x));

%Run Based on the Calculated method
Calculate_index = get(handles.CalculateMenu, 'Value');
switch Calculate_index
    case 1 %Calculate With Solution I
        
        for yy = 1:length(y)
            for xx = 1:length(x)
                sum = 0.0;
                for k = 1:SumInt
                    m = double(2*k -1);
                    gm = 4*V2/(m*pi);
                    hm = ( 4*V1/(m*pi) - 4*V2/(m*pi)*cosh(m*pi*Height/Width))/sinh(m*pi*Height/Width);
                    v = sin(m*pi*x(xx)/Width)*(gm*cosh(m*pi*y(yy)/Width) + hm*sinh(m*pi*y(yy)/Width));
                    sum = sum + v;
                end
                handles.V(yy,xx) = sum;
            end
        end
        
    case 2 %Calculate With Solution II
        for yy = 1:length(y)
            for xx = 1:length(x)
                %Part 1:
                sum = 0.0;
                for k = 1:SumInt
                    n = double(2*k -1);
                    v = sin(n*pi*x(xx)/Width)*cosh(n*pi*y(yy)/Width)/n;
                    sum = sum + v;
                end
                sum1 = (4*V2/pi)*sum;
                %Part 2:
                sum = 0.0;
                for k = 1:SumInt
                    n = double(2*k -1);
                    v = (sin(n*pi*x(xx)/Width)*sinh(n*pi*y(yy)/Width)/(n*sinh(n*pi*Height/Width)))*(1-(V2/V1)*cosh(n*pi*Height/Width));
                    sum = sum + v;
                end
                sum2 = (4*V1/pi)*sum;
                %Sum of Part 1 and Part 2
                sum = sum2;% + sum2;
                handles.V(yy,xx) = sum;
            end
        end
end


axes(handles.OutputImage);
cla;
imagesc(handles.x,handles.y,handles.V)
set(gca,'YDir','normal')

%Enable all buttons
EnableAllButtons(handles)
%Update handles
guidata(hObject, handles);

function V1_input_Callback(hObject, eventdata, handles)
% hObject    handle to V1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V1_input as text
%        str2double(get(hObject,'String')) returns contents of V1_input as a double


% --- Executes during object creation, after setting all properties.
function V1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V1_Callback(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V1 as text
%        str2double(get(hObject,'String')) returns contents of V1 as a double


% --- Executes during object creation, after setting all properties.
function V1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V2_Callback(hObject, eventdata, handles)
% hObject    handle to V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V2 as text
%        str2double(get(hObject,'String')) returns contents of V2 as a double


% --- Executes during object creation, after setting all properties.
function V2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Height_Callback(hObject, eventdata, handles)
% hObject    handle to Height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Height as text
%        str2double(get(hObject,'String')) returns contents of Height as a double


% --- Executes during object creation, after setting all properties.
function Height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Width_Callback(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Width as text
%        str2double(get(hObject,'String')) returns contents of Width as a double


% --- Executes during object creation, after setting all properties.
function Width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Scale_Callback(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Scale as text
%        str2double(get(hObject,'String')) returns contents of Scale as a double


% --- Executes during object creation, after setting all properties.
function Scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SumInt_Callback(hObject, eventdata, handles)
% hObject    handle to SumInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SumInt as text
%        str2double(get(hObject,'String')) returns contents of SumInt as a double


% --- Executes during object creation, after setting all properties.
function SumInt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SumInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function VecScale_Callback(hObject, eventdata, handles)
% hObject    handle to VecScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VecScale as text
%        str2double(get(hObject,'String')) returns contents of VecScale as a double

% --- Executes during object creation, after setting all properties.

function VecScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VecScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ButtonA.
function ButtonA_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.OutputImage);
cla;
imagesc(handles.x,handles.y,handles.V)
set(gca,'YDir','normal')
EnableAllButtons(handles)
set(handles.ButtonA,'Enable','off')


% --- Executes on button press in ButtonB.
function ButtonB_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y] = gradient(handles.V);
axes(handles.OutputImage);
cla;
contour(handles.V)
EnableAllButtons(handles)
set(handles.ButtonB,'Enable','off')


% --- Executes on button press in ButtonC.
function ButtonC_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y] = gradient(handles.V);
z = sqrt(x.^2 + y.^2);
axes(handles.OutputImage);
cla;
imagesc(log(abs(z + 0.0001)))
EnableAllButtons(handles)
set(handles.ButtonC,'Enable','off')


% --- Executes on button press in ButtonD.
function ButtonD_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VectorScale = str2double(get(handles.VecScale, 'String'));

[x y] = gradient(handles.V);
axes(handles.OutputImage);
cla;
quiver(handles.x,handles.y,x,y,VectorScale)
EnableAllButtons(handles)
set(handles.ButtonD,'Enable','off')


% --- Executes on button press in ButtonE.
function ButtonE_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VectorScale = str2double(get(handles.VecScale, 'String'));
[x y] = gradient(handles.V);
axes(handles.OutputImage);
cla;
contour(handles.V), hold on, quiver(x,y,VectorScale), hold off
EnableAllButtons(handles)
set(handles.ButtonE,'Enable','off')


% --- Executes on button press in ButtonF.
function ButtonF_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.OutputImage);
cla;
DisableAllButtons(handles)


% --- Executes during object creation, after setting all properties.
function OutputImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate OutputImage

function EnableAllButtons(handles)
set(handles.ButtonA,'Enable','on')
set(handles.ButtonB,'Enable','on')
set(handles.ButtonC,'Enable','on')
set(handles.ButtonD,'Enable','on')
set(handles.ButtonE,'Enable','on')
set(handles.ButtonF,'Enable','on')

function DisableAllButtons(handles)
set(handles.ButtonA,'Enable','off')
set(handles.ButtonB,'Enable','off')
set(handles.ButtonC,'Enable','off')
set(handles.ButtonD,'Enable','off')
set(handles.ButtonE,'Enable','off')
set(handles.ButtonF,'Enable','off')


% --- Executes on selection change in CalculateMenu.
function CalculateMenu_Callback(hObject, eventdata, handles)
% hObject    handle to CalculateMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CalculateMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CalculateMenu


% --- Executes during object creation, after setting all properties.
function CalculateMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CalculateMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
