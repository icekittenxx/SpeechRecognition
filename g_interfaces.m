function varargout = g_interfaces(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g_interfaces_OpeningFcn, ...
                   'gui_OutputFcn',  @g_interfaces_OutputFcn, ...
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



% --- Executes just before g_interfaces is made visible.
function g_interfaces_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

hmm = load('C:\Users\ICE\Desktop\speech recognition\testhmm.mat');
% hmm = load('C:\Users\ICE\Desktop\speech recognition\testm\testhmm2.mat');

[ans length] = size(hmm.hmm);
test_len = num2str(length);

text = {'ģ�������16�����ʣ�', '��ʼ', '����', '����', '��ע', '�ʵ�', '��', ...
    '����', '����', '¼��', '����', '����', '��ѧ', '���', '����', 'ѵ��', ...
    '��ת'};
set(handles.edit1, 'string', text);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = g_interfaces_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tag1_1_Callback(hObject, eventdata, handles)
[FileName,PathName]= uigetfile('*.wav');
if ~isequal(FileName, 0)
%     open(file);
[y fs] = wavread([PathName FileName]);
end
handles.data = y;
handles.sample = fs;
t = length(handles.data)/fs;
tt = 0: t/length(handles.data): t;
handles.t = tt(1:length(tt) - 1);
guidata(hObject, handles);    
axes(handles.axes1);   
plot(handles.t,y);
ylabel('signal Magnitude ');
xlabel('time(s)');

text = '';
set(handles.edit2, 'string', text);



function axes1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
hmm = load('C:\Users\ICE\Desktop\speech recognition\testhmm.mat');
% hmm = load('C:\Users\ICE\Desktop\speech recognition\testm\testhmm2.mat');

[ans length] = size(hmm.hmm);
x = handles.data;
[x1 x2] = vad(x);
m = mfcc(x);
% m = m(x1-2:x2-2,:);   
% m = m(x1+2:x2-2,:);
m = m(x1:x2,:);
for j=1:length
	pout(j) = viterbi(hmm.hmm{j}, m);
end
[d,n] = max(pout);
text = num2str(n);

word = {'��ʼ', '����', '����', '��ע', '�ʵ�', '��', '����', '����', '¼��', ...
    '����', '����', '��ѧ', '���', '����', 'ѵ��', '��ת'};

% word = {'��ʼ', '����', '����', '��ע', '�ʵ�', '��', '����', '����', '¼��', ...
%    '����', '����', '��ѧ', '���', '����', 'ѵ��', '��ת', '����ֱ����ǧ��', ...
%    '�����ԹҶ���֦'};
set(handles.edit2, 'string', word{n});



function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)



function pushbutton2_Callback(hObject, eventdata, handles)
x = handles.data;
wavplay(x);


function tag1_Callback(hObject, eventdata, handles)
