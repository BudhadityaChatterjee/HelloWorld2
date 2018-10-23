
load('VALS.mat');
load('NEMOABH.mat');
load('NIKABH.mat');
    Xnemo=[];
    Ynemo=[];
    Xnik=[];
    Ynik=[];

for rr=1:3.3/.1
NEMONIKsy=[];
  for NIKrwise=1:size(Vals,1)
    for NEMOcwise=1:size(Vals,2)
        sy=Vals(NIKrwise,NEMOcwise);
       if sy<(rr/10)+1
           if sy>(rr/10)
        NEMONIKsy=[NEMONIKsy;TP1(NEMOcwise,:) TK1(NIKrwise,:) sy];
           end
       end
    end
   end
si=size(NEMONIKsy,1);

    
    ANemo=sum(NEMONIKsy(:,1))/si;
    ABNemo=sum(NEMONIKsy(:,3))/si;
    HNemo=sum(NEMONIKsy(:,4))/si;
    ANik=sum(NEMONIKsy(:,5))/si;
    ABNik=sum(NEMONIKsy(:,7))/si;
    HNik=sum(NEMONIKsy(:,8))/si;
    
    Xnemo=[Xnemo;0 ANemo ABNemo];
    Ynemo=[Ynemo;0 HNemo*100 0];
    Xnik=[Xnik;0 ANik ABNik];
    Ynik=[Ynik;0 HNik 0];
end

cmap=colormap('summer');
figure, set(gcf, 'Color','white')
axis([0 1400 0 60])
set(gca, 'nextplot','replacechildren', 'Visible','off');

%# create AVI object
nFrames = 33;
aviobj = avifile('master_curves_movie.avi', 'fps',2);

%# create movie
for k=1:nFrames
   plot(Xnemo(k,:),Ynemo(k,:),'r','linewidth',5)
   hold on
   axis([0 1400 0 60])
   d=ceil((k*.1/3.3)*64);
   if d>64
       d=64;
   end
   disp(d)
   set(gca,'Color',cmap(d,:))
   plot(Xnik(k,:),Ynik(k,:),'b','linewidth',5)
   text(1150,57,['Above' num2str(k/10)],'fontsize',15,'fontweight','bold')
   text(1150,53,['Below' num2str((k+1)/10)],'fontsize',15,'fontweight','bold')
   hold off
   aviobj = addframe(aviobj, getframe(gca));
end
close(gcf)

%# save as AVI file, and open it using system video player
aviobj = close(aviobj);
winopen('master_curves_movie.avi')

