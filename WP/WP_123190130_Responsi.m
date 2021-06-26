function varargout = WP_123190130_Responsi(varargin)
% WP_123190130_RESPONSI MATLAB code for WP_123190130_Responsi.fig
%      WP_123190130_RESPONSI, by itself, creates a new WP_123190130_RESPONSI or raises the existing
%      singleton*.
%
%      H = WP_123190130_RESPONSI returns the handle to a new WP_123190130_RESPONSI or the handle to
%      the existing singleton*.
%
%      WP_123190130_RESPONSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WP_123190130_RESPONSI.M with the given input arguments.
%
%      WP_123190130_RESPONSI('Property','Value',...) creates a new WP_123190130_RESPONSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WP_123190130_Responsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WP_123190130_Responsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WP_123190130_Responsi

% Last Modified by GUIDE v2.5 26-Jun-2021 09:45:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WP_123190130_Responsi_OpeningFcn, ...
                   'gui_OutputFcn',  @WP_123190130_Responsi_OutputFcn, ...
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


% --- Executes just before WP_123190130_Responsi is made visible.
function WP_123190130_Responsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WP_123190130_Responsi (see VARARGIN)

% Choose default command line output for WP_123190130_Responsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WP_123190130_Responsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WP_123190130_Responsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Realestate.xlsx') %memanggil file exel
opts.SelectedVariableNames =(2:5); %memilih baris yang akan digunakan
data = readmatrix('Realestate.xlsx', opts); %membaca file 
set(handles.table1,'data',data,'visible','on'); % menampilkan pada tabel

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Realestate.xlsx'); %memanggil data pada exel
opts.SelectedVariableNames = (2:5); %memilih variable yang ditampilkan
data = readmatrix('Realestate.xlsx', opts); 

x = [data];
%rating kecocokan dari masing-masing alternatif
k = [0,0,1,0];
%Nilai bobot tiap kriteria
w = [3,5,4,1];

%inisialisasi ukuran x
[m n]=size (x); 
%membagi bobot per kriteria dengan jumlah total seluruh bobot
w=w./sum(w); 

%melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%proses perangkingan
[Ssort] = sort(S, 'descend');
V= S/sum(S);
k=Ssort.';
disp(k(1:5,:));
disp(sum(S));
[peringkat, index] = sort(V, 'descend');

B = peringkat.'; %mentranpos hasil perangkingan agar menjadi vertikal
C = index.';%mentranpos index nomor real estate agar menjadi vertikal
hasil = [ C(1:20,:) B(1:20,:)]; %menjadikannya array


%hasil
set(handles.uitable4,'data',hasil); %menampilkan data di uitable 4
set(handles.text2,'string',("Real Estate Terbaik ada di baris ke- " +index+ " yang nilai wp nya : "+ peringkat));



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


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
