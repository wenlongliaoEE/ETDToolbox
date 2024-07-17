function Funcollect=GenerationFunc
Funcollect.GetType1=@GetType1;
Funcollect.GetType2=@GetType2;
Funcollect.GetType3=@GetType3;
Funcollect.GetType4=@GetType4;
Funcollect.GetType5=@GetType5;
Funcollect.GetType6=@GetType6;
Funcollect.GetType7=@GetType7;
Funcollect.GetType8=@GetType8;
end
function AttackX=GetType1(OriX,Xishumin,Xishumax)
%Xishumin=0.1;Xishumax=0.8;
AttackX=OriX;
AttackX=AttackX*(rand()*(Xishumax-Xishumin)+Xishumin);
end

function AttackX=GetType2(OriX,DurationTime)
Timelength=length(OriX);
AttackX=OriX;
%DurationTime=4
if DurationTime<4
   DurationTime=4
end
if Timelength==24 %time resolution=60min
   Ts=floor((24-DurationTime)*rand(1,1)+1); %Start time =[1,20]
   Duration=floor((24-DurationTime+1)*rand(1,1)+DurationTime); 
   Te=Ts+Duration;
elseif Timelength==48 %time resolution=30min
   Ts=floor((24-DurationTime)*2*rand(1,1)+1); %Start time =[1,40]
   Duration=floor(((24-DurationTime)*2+1)*rand(1,1)+DurationTime*2);  
   Te=Ts+Duration;
elseif Timelength==72 %time resolution=20min
   Ts=floor((24-DurationTime)*3*rand(1,1)+1); %Start time =[1,60]
   Duration=floor(((24-DurationTime)*3+1)*rand(1,1)+DurationTime*3);  
   Te=Ts+Duration;
elseif Timelength==144 %time resolution=10min
   Ts=floor((24-DurationTime)*6*rand(1,1)+1); %Start time =[1,120]
   Duration=floor(((24-DurationTime)*6+1)*rand(1,1)+DurationTime*6);  
   Te=Ts+Duration;  
end
for j=1:length(OriX)
    if (j>=Ts)&&(j<=Te)
       AttackX(j)=0;
    end
end
end


function AttackX=GetType3(OriX,Xishumin,Xishumax)
[MOriX,NOriX]=size(OriX);
%Xishumin=0.1;Xishumax=0.8;
AttackX=OriX;
AttackX=AttackX.*(rand(MOriX,NOriX)*(Xishumax-Xishumin)+Xishumin);
end

function AttackX=GetType4(OriX)
[MOriX,NOriX]=size(OriX);
AttackX=zeros(MOriX,NOriX)+mean(OriX);
end

function AttackX=GetType5(OriX,Xishumin,Xishumax)
%Xishumin=0.1;Xishumax=0.8;
[MOriX,NOriX]=size(OriX);
AttackX=zeros(MOriX,NOriX)+mean(OriX);
AttackX=AttackX.*(rand(MOriX,NOriX)*(Xishumax-Xishumin)+Xishumin);
end

function AttackX=GetType6(OriX)
AttackX=OriX(length(OriX):-1:1);
end

function AttackX=GetType7(OriX,Xishu)
%Xishu=0.7; 
AllMax=Xishu*max(OriX);
AttackX=OriX;
AttackX(find(AttackX>AllMax))=AllMax;
end

function AttackX=GetType8(OriX,Xishu)
%Xishu=0.4; 
JianValues=Xishu*max(OriX);
AttackX=OriX-JianValues;
AttackX(find(AttackX<0))=0;
end




