function RoI = findRoI(StripWidth,index,Lmt)

widthIndx = index - Lmt : index + Lmt;
remove = find(widthIndx <= 0);
widthIndx(remove) = [];
remove = find(widthIndx > StripWidth );
widthIndx(remove) = [];

RoI = zeros(StripWidth,1);
% RoI(widthIndx) = gausswin(length(widthIndx),20);
RoI(widthIndx) = 1;

end




