function varargout = DetOfBloodType(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DetOfBloodType_OpeningFcn, ...
                   'gui_OutputFcn',  @DetOfBloodType_OutputFcn, ...
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
 
 
% --- Executes just before DetOfBloodType is made visible.
function DetOfBloodType_OpeningFcn(hObject, eventdata, handles, varargin)
 
handles.output = hObject;
 
 
guidata(hObject, handles);
 
function varargout = DetOfBloodType_OutputFcn(hObject, eventdata, handles) 
 
varargout{1} = handles.output;
 
 
% --- Executes on button press in InputImage.
function InputImage_Callback(hObject, eventdata, handles)
%Clear all axes.
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');
cla(handles.axes6,'reset');
cla(handles.axes7,'reset');
set(handles.Result,'String','');
[file,path,indx] = uigetfile('.png','Enter an image', "C:\Users\Karim's Laptop\Desktop\BloodImages");
s=append(path,file);
x=imread(s);
x=imresize(x,[120 320]); 
axes(handles.axes1);
imshow(x);
 
% --- Executes on button press in ToGrayscale.
function ToGrayscale_Callback(hObject, eventdata, handles)
x=getimage(handles.axes1);
axes(handles.axes2);
i1=0;
i2=0;
i3=0;
xR=x(:,:,1);%red color extraction.
[rows,cols]=size(xR);
 
for c=1:cols
    for r=1:rows 
    pixval = xR(r,c);
    if(pixval<50)
        i1=i1+1;
    end
    end
end
xG=x(:,:,2);%green color extraction.
for c=1:cols
    for r=1:rows 
    pixval = xG(r,c);
    if(pixval<50)
        i2=i2+1;
    end
    end
end
xB=x(:,:,3);%blue color extraction.
for c=1:cols
    for r=1:rows 
    pixval = xB(r,c);
    if(pixval<50)
        i3=i3+1;
    end
    end
end
I=[i1,i2,i3];
m=max(I);%get the darker image.
if m==i1
   imshow(xR);
else
    if m==i2
        imshow(xG);
    else
        imshow(xB);
    end
end
 
% --- Executes on button press in Threshold.
function Threshold_Callback(hObject, eventdata, handles)
z=getimage(handles.axes2);
axes(handles.axes3);
H=imhist(z);
TP=sum(H);
P=H/TP;
%Otsu Threshold
for k= 50:250
    wb=sum(P(1:k));
    wf=sum(P(k+1 : end));
    Ub=dot(0:k-1,P(1:k))/wb;
    Uf=dot(k:255,P(k+1:256))/wf;
    Var(k)=wb*wf*((Ub-Uf)^2);
end
Max_Variance=max(Var);
L=find(Var==Max_Variance);
Threshold=L-1;
imshow(z<Threshold);
 
% --- Executes on button press in DoErosion.
function DoErosion_Callback(hObject, eventdata, handles)
y=getimage(handles.axes3);
axes(handles.axes4);
se=strel('disk',4);
y=imerode(y,se);
imshow(y);
 
% --- Executes on button press in Segmentation.
function Segmentation_Callback(hObject, eventdata, handles)
s=getimage(handles.axes4);
axes(handles.axes5);
[rows,cols]=size(s);
 
%First crop.
count1=0;
for c=1:cols
    for r=1:rows
       if(s(r,c)==1)
           count1=count1+1;
       end
    end
        if(count1>2)
               c1=c-1;
               break;
        end
        count1=0;
end
 
x=c1+1;
count1=0;
for c=x:cols
    for r=1:rows
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        c2=c+1;
        if(c2>c1+60)
        break;
        end
    end
    count1=0;
end
 
count1=0;
for r=1:rows
    for c=c1:c2
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1>2)
        r1=r-1;
        break;
    end
end
 
count1=0;
x=r1+1;
for r=x:rows
    for c=c1:c2
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        r2=r+1;
        if(r2>r1+50)
        break;
        end
    end
    count1=0;
end
crop1=s([r1:r2],[c1:c2]);
imshow(crop1);
 
%Second crop
axes(handles.axes6);
count1=0;
for c=c2:cols
    for r=1:rows
       if(s(r,c)==1)
           count1=count1+1;
       end
    end
        if(count1>2)
               c3=c-1;
               break;
        end
        count1=0;
end
 
x=c3+1;
count1=0;
for c=x:cols
    for r=1:rows
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        c4=c+1;
        if(c4>c3+70)
        break;
        end
    end
    count1=0;
end
count1=0;
 
for r=1:rows
    for c=c3:c4
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1>2)
        r3=r-1;
        break;
    end
end
 
count1=0;
x=r3+1;
for r=x:rows
    for c=c3:c4
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        r4=r+1;
        if(r4>r3+40)
        break;
        end
    end
    count1=0;
end
crop2=s([r3:r4],[c3:c4]);
imshow(crop2);
 
%Third crop
axes(handles.axes7);
count1=0;
for c=c4:cols
    for r=1:rows
       if(s(r,c)==1)
           count1=count1+1;
       end
    end
        if(count1>2)
               c5=c-1;
               break;
        end
        count1=0;
end
 
x=c5+1;
count1=0;
for c=x:cols
    for r=1:rows
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        c6=c+1;
        if(c6>c5+40)
        break;
        end
    end
    count1=0;
end
count1=0;
 
for r=1:rows
    for c=c5:c6
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1>2)
        r5=r-1;
        break;
    end
end
 
count1=0;
x=r5+1;
for r=x:rows
    for c=c5:c6
        if(s(r,c)==1)
            count1=count1+1;
        end
    end
    if(count1==0)
        r6=r+1;
        if(r6>r5+40)
        break;
        end
    end
    count1=0;
end
crop3=s([r5:r6],[c5:c6]);
imshow(crop3);
 
% --- Executes on button press in GetResult.
function GetResult_Callback(hObject, eventdata, handles)
I1=getimage(handles.axes5);
[L,n1]=bwlabel(I1);
I2=getimage(handles.axes6);
[L,n2]=bwlabel(I2);
I3=getimage(handles.axes7);
[L,n3]=bwlabel(I3);
s1=sum(I1(:));%nb of white pixels
np1=numel(I1);%nb of pixels
p1=s1/np1;%percentage of white pixels in the first image
s2=sum(I2(:));
np2=numel(I2);
p2=s2/np2;
s3=sum(I3(:));
np3=numel(I3);
p3=s3/np3;
 
if(n1==0) || (n2==0) || (n3==0)
    set(handles.Result,'string','Error');
elseif((n1>=3) && (n2<3) && (n3<3)) || ((p1 <0.6) && (p2>0.6) && (p3>0.6))
    set(handles.Result,'string','A-');
elseif((n1<3) && (n2>=3) && (n3>=3)) || ((p1>0.6) && (p2<0.6) && (p3<0.6))
    set(handles.Result,'string','B+');
elseif((n1<3) && (n2>=3) && (n3<3)) || ((p1>0.6) && (p2<0.6) && (p3>0.6)) 
    set(handles.Result,'string','B-');
elseif((n1>=3) && (n2>=3) && (n3>=3)) || ((p1<0.6) && (p2<0.6) &&(p3<0.6))
    set(handles.Result,'string','AB+');
elseif((n1>=3) && (n2>=3) && (n3<3)) || ((p1<0.6) && (p2<0.6) &&(p3>0.6))
    set(handles.Result,'string','AB-');
elseif((n1<3) && (n2<3) && (n3>=3)) || ((p1>0.6) && (p2>0.6) &&(p3<0.6))
    set(handles.Result,'string','O+');
elseif((n1<3) && (n2<3) && (n3<3)) || ((p1>0.6) && (p2>0.6) &&(p3>0.6))
    set(handles.Result,'string','O-');
elseif((n1>=3) && (n2<3) && (n3>3)) || ((p1<0.6) && (p2>0.6) && (p3<0.6))
    set(handles.Result,'string','A+');
end
 
function Result_Callback(hObject, eventdata, handles)
 
function Result_CreateFcn(hObject, eventdata, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
