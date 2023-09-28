function varargout = modulador1(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modulador1_OpeningFcn, ...
                   'gui_OutputFcn',  @modulador1_OutputFcn, ...
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


% --- Executes just before modulador1 is made visible.
function modulador1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = modulador1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press graph.
function pushbutton1_Callback(hObject, eventdata, handles)

clc; 
%lets define some fun variables 
index=str2num(get(handles.edit1,'string'));
A1=str2num(get(handles.edit2,'string'));
A2=str2num(get(handles.edit4,'string'));
f=str2num(get(handles.edit3,'string'));
f2=str2num(get(handles.edit5,'string'));
opc= get(handles.popupmenu1,'value');%señal 1
opc2= get(handles.popupmenu2,'value');%señal 2
AM= get(handles.radiobutton1,'Value');
FM= get(handles.radiobutton2,'Value');
PM= get(handles.radiobutton3,'Value');
SGN= get(handles.radiobutton7,'Value');
opc4= get(handles.checkbox1,'Value');
span2=str2num(get(handles.edit7,'string'));
span3=str2num(get(handles.edit8,'string'));
span1=str2num(get(handles.edit9,'string'));
%extra variables for more fun
fc=f;% f de portadora y 
fm=f2;% f de moduladora s
Fs=8000;
L=1500;T=1/Fs;
tt=1:4*T;
S=(0:L-1)*T;
t=(0:L-1)*T;

% definiendo señales
switch (opc) %portadora
    case 1
        s_c=A1*sin(2*pi*fc.*t) %Portadora Y
    case 2
        s_c=A1*cos(2*pi*fc*t);;
    case 3 
        s_c=A1*sawtooth(2*pi*fc*t);
    case 4  
        s_c=A1*square(2*pi*fc*t);
end
switch (opc2) %moduladora
    case 1
        s_i=A2*sin(2*pi*fm*t); %moduladora & señal
    case 2
        s_i=A2*cos(2*pi*fm*t);
    case 3 
        s_i=A2*sawtooth(2*pi*fm*t);
    case 4  
        s_i=A2*square(2*pi*fm*t);
end
y1=s_c;%operaciones y modulacions
Smondulada=s_c;%señal original
if AM==1;
 
Smondulada=(index+s_i).*s_c;% AM
env=index+s_i;
y1=Smondulada;
end  
%%$% PM
if PM==1 && opc ==1  
Smondulada = A1*sin(2*pi*fc* t +index+s_i);
y1=Smondulada;
env=index+s_i;
elseif PM==1 && opc ==2  
Smondulada = A1*cos(2*pi*fc* t +index+s_i);
y1=Smondulada;
env=index+s_i;
elseif PM==1 && opc ==3  
Smondulada = A1*sawtooth(2*pi*fc* t +index+s_i);
y1=Smondulada;
env=index+s_i;
elseif PM==1 && opc ==4  
Smondulada = A1*square(2*pi*fc* t +index+s_i);
y1=Smondulada;
env=index+s_i;
end
% señal
if SGN==1
    
   Smondulada=s_c;
  y1=Smondulada;
  env=y1;
end
%%f,
if FM==1 && opc ==1  
    fr=index*s_i;
Smondulada = A1*sin(2*pi*(fc+s_i).*t);
y1=Smondulada;
env=index*s_i;
elseif FM==1 && opc ==2 
    fr=index*s_i;
Smondulada = A1*cos(2*pi*(fc+s_i).*t);
y1=Smondulada;
env=index*s_i;
elseif FM==1 && opc ==3  
    fr=index*s_i;
Smondulada = A1*sawtooth(2*pi*(fc+s_i).*t);
y1=Smondulada;
env=index*s_i;
elseif FM==1 && opc ==4  
    fr=index*s_i;
Smondulada = A1*square(2*pi*(fc+s_i).*t);
y1=Smondulada;
env=index*s_i;
end


if opc4==1
     xlim([0 span1]);
   
plot(handles.axes1,t,Smondulada,'r',t,env,'--b')
elseif opc4==0
    span1=1/span1;
     xlim([0 span1]);
   plot(handles.axes1,t,Smondulada,'r')

end
Y = fft(y1);
 P2=abs(Y/L); 
P1=P2(1:L/2+1);  
P1(2:end-1)=2*P1(2:end-1); 
ft=Fs*(0:(L/2))/L; 
plot(handles.axes2,ft,P1,'r')
xlim([span2 span3]);












function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)


function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)

function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)

