function n = persdia(varargin)
% n = number of persistence intervals
% inputs: mandatory filename = name of file containing 
% birth and death info in column form, and a number plot-type.
% if plot type = 0, we plot ALL intervals, otherwise only the
% ones that actually die.

if nargin==0
    retutn -1;
else
    filename = varargin{1};
end    

plot_type = 0;
if nargin == 2 
    plot_type = varargin{2};
end

dot_th = 0;
if nargin == 3
    dot_th = varargin{3};
end
dot_th;



% extract birth and death indices
ints = load(filename);
if (length(ints) == 0)
    return
end
births = ints(:,1);
deaths = ints(:,2);

minb = min(births);

% extract maximum death time encountered:
maxd = max(deaths);
if (maxd < 0) 
    maxd = 255%max(births)+1;
end

if (minb == maxd)
    maxd = maxd+1;
end

%Added by Yu-Min
%maxd=255
%minb=1
%===============
% extract indices of those intervals which die
normal_ints = find(deaths ~= -1);

%figure;

% we always plot these:
%plot(births(normal_ints),deaths(normal_ints),'bd', 'MarkerSize',10);
plot(births(normal_ints),deaths(normal_ints), 'bd');
hold on;
axis([minb,maxd+(maxd-minb)/20,minb,maxd+(maxd-minb)/20]);

% plot the diagonal
diag = minb:(maxd-minb)/20:maxd;
plot(diag,diag,'g-');
%lifespan cutoff
%plot(diag, diag+100, 'k-')
%lsdiag = minb:(maxd-minb)/20:maxd;
%x = 0:255;
%plot(x, x+100);



%title(filename);
% xlabel('birth');
% ylabel('death');

% extract indices of those intervals which persist throughout
if plot_type == 0 
  inf_ints = find(deaths == -1);
  infd_vec = (maxd + (maxd-minb)/20)*ones(size(inf_ints));
%  plot((births(inf_ints)), infd_vec , 'rd', 'MarkerSize',10);
plot((births(inf_ints)), infd_vec , 'rd');
end

%plot the thresold
% thresold = 134;
% lth = (maxd + (maxd-minb)/20);
% plot([thresold, thresold], [thresold, lth], 'm--')
% plot( [minb, thresold], [thresold, thresold], 'm--')
% 
%  thresold = 151;
%  lth = (maxd + (maxd-minb)/20);
%  plot([thresold, thresold], [thresold, lth], 'm--')
%  plot( [minb, thresold], [thresold, thresold], 'm--')

%  thresold = 117;
%  lth = (maxd + (maxd-minb)/20);
%  plot([thresold, thresold], [thresold, lth], 'm--')
%  plot( [minb, thresold], [thresold, thresold], 'm--')
%  
%  thresold = 167;
%  lth = (maxd + (maxd-minb)/20);
%  plot([thresold, thresold], [thresold, lth], 'm--')
%  plot( [minb, thresold], [thresold, thresold], 'm--')
%  
thresold = dot_th;%128;
if thresold ~= 0
lth = (maxd + (maxd-minb)/20);
plot([thresold, thresold], [thresold, lth], 'm--', 'linewidth', 3)
plot( [minb, thresold], [thresold, thresold], 'm--', 'linewidth',3)
plot([thresold, thresold], [thresold, lth], 'm--', 'linewidth', 3)
plot( [minb, thresold], [thresold, thresold], 'm--', 'linewidth',3)
end
%set(gca, 'FontSize', 20);
xlabel('Birth Value')
ylabel('Death Value')
%set(gca, 'MarkerSize' , 10)
n = size(births);
hold off;