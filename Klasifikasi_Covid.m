function varargout = Klasifikasi_Covid(varargin)
% KLASIFIKASI_COVID MATLAB code for Klasifikasi_Covid.fig
%      KLASIFIKASI_COVID, by itself, creates a new KLASIFIKASI_COVID or raises the existing
%      singleton*.
%
%      H = KLASIFIKASI_COVID returns the handle to a new KLASIFIKASI_COVID or the handle to
%      the existing singleton*.
%
%      KLASIFIKASI_COVID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KLASIFIKASI_COVID.M with the given input arguments.
%
%      KLASIFIKASI_COVID('Property','Value',...) creates a new KLASIFIKASI_COVID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Klasifikasi_Covid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Klasifikasi_Covid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Klasifikasi_Covid

% Last Modified by GUIDE v2.5 23-May-2024 17:10:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Klasifikasi_Covid_OpeningFcn, ...
                   'gui_OutputFcn',  @Klasifikasi_Covid_OutputFcn, ...
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


% --- Executes just before Klasifikasi_Covid is made visible.
function Klasifikasi_Covid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Klasifikasi_Covid (see VARARGIN)

% Choose default command line output for Klasifikasi_Covid
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Klasifikasi_Covid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Klasifikasi_Covid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in showTables.
function showTables_Callback(hObject, eventdata, handles)
% hObject    handle to showTables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Covid_Data.csv');
opts.SelectedVariableNames=(1:20);
data = readmatrix('Covid_Data.csv', opts);
set(handles.tableData, 'data', data);

% --- Executes on button press in resetData.
function resetData_Callback(hObject, eventdata, handles)
% hObject    handle to resetData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = cell(0);
set(handles.tableData, 'Data', data);

% --- Executes on button press in klasifikasi.
function klasifikasi_Callback(hObject, eventdata, handles)
% hObject    handle to klasifikasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% "1. dapatkan input"

batuk    = str2double(get(handles.batuk , 'string'));
nyo      = str2double(get(handles.nyo , 'string'));
kllh     = str2double(get(handles.kllh , 'string'));
sktg     = str2double(get(handles.sktg , 'string'));
plk      = str2double(get(handles.plk , 'string'));
 
htst     = str2double(get(handles.htst , 'string'));
mual     = str2double(get(handles.mual , 'string'));
muntah   = str2double(get(handles.muntah , 'string'));
diare    = str2double(get(handles.diare , 'string'));
sesaknps = str2double(get(handles.sesaknps , 'string'));
 
sulitnps = str2double(get(handles.sulitnps , 'string'));
hlpr     = str2double(get(handles.hlpr , 'string'));
hlpb     = str2double(get(handles.hlpb , 'string'));
mtgt     = str2double(get(handles.mtgt , 'string'));
htgt     = str2double(get(handles.htgt , 'string'));
 
mulgt    = str2double(get(handles.mulgt , 'string'));
tlgt     = str2double(get(handles.tlgt , 'string'));
bersin   = str2double(get(handles.bersin , 'string'));
mtpk     = str2double(get(handles.mtpk , 'string'));

samples = [ batuk nyo kllh sktg plk htst mual muntah diare sesaknps sulitnps hlpr hlpb mtgt htgt mulgt tlgt bersin mtpk ];

k_val = 3;

% "training"
opts = detectImportOptions('Covid_Data.csv');
opts.SelectedVariableNames=(1:19);
training = readmatrix('Covid_Data.csv', opts);

% "target"
opts = detectImportOptions('Covid_Data.csv');
opts.SelectedVariableNames=(21);
target = readmatrix('Covid_Data.csv', opts);

train = fitcknn(training, target, 'NumNeighbors', k_val);
klasifikasi = predict(train, samples);

set(handles.hasil_kl, 'string', klasifikasi);

function batuk_Callback(hObject, eventdata, handles)
% hObject    handle to batuk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of batuk as text
%        str2double(get(hObject,'String')) returns contents of batuk as a double


% --- Executes during object creation, after setting all properties.
function batuk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to batuk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nyo_Callback(hObject, eventdata, handles)
% hObject    handle to nyo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nyo as text
%        str2double(get(hObject,'String')) returns contents of nyo as a double


% --- Executes during object creation, after setting all properties.
function nyo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nyo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kllh_Callback(hObject, eventdata, handles)
% hObject    handle to kllh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kllh as text
%        str2double(get(hObject,'String')) returns contents of kllh as a double


% --- Executes during object creation, after setting all properties.
function kllh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kllh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sktg_Callback(hObject, eventdata, handles)
% hObject    handle to sktg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sktg as text
%        str2double(get(hObject,'String')) returns contents of sktg as a double


% --- Executes during object creation, after setting all properties.
function sktg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sktg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plk_Callback(hObject, eventdata, handles)
% hObject    handle to plk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plk as text
%        str2double(get(hObject,'String')) returns contents of plk as a double


% --- Executes during object creation, after setting all properties.
function plk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function htst_Callback(hObject, eventdata, handles)
% hObject    handle to htst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of htst as text
%        str2double(get(hObject,'String')) returns contents of htst as a double


% --- Executes during object creation, after setting all properties.
function htst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to htst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mual_Callback(hObject, eventdata, handles)
% hObject    handle to mual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mual as text
%        str2double(get(hObject,'String')) returns contents of mual as a double


% --- Executes during object creation, after setting all properties.
function mual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function muntah_Callback(hObject, eventdata, handles)
% hObject    handle to muntah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of muntah as text
%        str2double(get(hObject,'String')) returns contents of muntah as a double


% --- Executes during object creation, after setting all properties.
function muntah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to muntah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diare_Callback(hObject, eventdata, handles)
% hObject    handle to diare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diare as text
%        str2double(get(hObject,'String')) returns contents of diare as a double


% --- Executes during object creation, after setting all properties.
function diare_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sesaknps_Callback(hObject, eventdata, handles)
% hObject    handle to sesaknps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sesaknps as text
%        str2double(get(hObject,'String')) returns contents of sesaknps as a double


% --- Executes during object creation, after setting all properties.
function sesaknps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sesaknps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sulitnps_Callback(hObject, eventdata, handles)
% hObject    handle to sulitnps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sulitnps as text
%        str2double(get(hObject,'String')) returns contents of sulitnps as a double


% --- Executes during object creation, after setting all properties.
function sulitnps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sulitnps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hlpr_Callback(hObject, eventdata, handles)
% hObject    handle to hlpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hlpr as text
%        str2double(get(hObject,'String')) returns contents of hlpr as a double


% --- Executes during object creation, after setting all properties.
function hlpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hlpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hlpb_Callback(hObject, eventdata, handles)
% hObject    handle to hlpb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hlpb as text
%        str2double(get(hObject,'String')) returns contents of hlpb as a double


% --- Executes during object creation, after setting all properties.
function hlpb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hlpb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function htgt_Callback(hObject, eventdata, handles)
% hObject    handle to htgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of htgt as text
%        str2double(get(hObject,'String')) returns contents of htgt as a double


% --- Executes during object creation, after setting all properties.
function htgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to htgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mtgt_Callback(hObject, eventdata, handles)
% hObject    handle to mtgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mtgt as text
%        str2double(get(hObject,'String')) returns contents of mtgt as a double


% --- Executes during object creation, after setting all properties.
function mtgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mtgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mulgt_Callback(hObject, eventdata, handles)
% hObject    handle to mulgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mulgt as text
%        str2double(get(hObject,'String')) returns contents of mulgt as a double


% --- Executes during object creation, after setting all properties.
function mulgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mulgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tlgt_Callback(hObject, eventdata, handles)
% hObject    handle to tlgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tlgt as text
%        str2double(get(hObject,'String')) returns contents of tlgt as a double


% --- Executes during object creation, after setting all properties.
function tlgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tlgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bersin_Callback(hObject, eventdata, handles)
% hObject    handle to bersin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bersin as text
%        str2double(get(hObject,'String')) returns contents of bersin as a double


% --- Executes during object creation, after setting all properties.
function bersin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bersin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mtpk_Callback(hObject, eventdata, handles)
% hObject    handle to mtpk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mtpk as text
%        str2double(get(hObject,'String')) returns contents of mtpk as a double


% --- Executes during object creation, after setting all properties.
function mtpk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mtpk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetInput.
function resetInput_Callback(hObject, eventdata, handles)
% hObject    handle to resetInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.batuk, 'string', " ");
set(handles.nyo, 'string', " ");
set(handles.kllh, 'string', " ");
set(handles.sktg, 'string', " ");
set(handles.plk, 'string', " ");

set(handles.htst, 'string', " ");
set(handles.mual, 'string', " ");
set(handles.muntah, 'string', " ");
set(handles.diare, 'string', " ");
set(handles.sesaknps, 'string', " ");

set(handles.sulitnps, 'string', " ");
set(handles.hlpr, 'string', " ");
set(handles.hlpb, 'string', " ");
set(handles.htgt, 'string', " ");
set(handles.mtgt, 'string', " ");

set(handles.mulgt, 'string', " ");
set(handles.tlgt, 'string', " ");
set(handles.bersin, 'string', " ");
set(handles.mtpk, 'string', " ");



function hasil_kl_Callback(hObject, eventdata, handles)
% hObject    handle to hasil_kl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hasil_kl as text
%        str2double(get(hObject,'String')) returns contents of hasil_kl as a double



% --- Executes during object creation, after setting all properties.
function hasil_kl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hasil_kl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
