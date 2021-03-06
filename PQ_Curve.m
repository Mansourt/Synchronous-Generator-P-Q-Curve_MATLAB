%% Synchronous Generator P-Q Curve

%% Parameter Definition
Sn = 1;                 % Rated apparent power [P.U.]
PF = 0.85;              % Power Factor 
V = [1.05, 0.95, 1];    % Terminal Voltage (+-5% Voltage Variation) [P.U.]
I = Sn./V;              % Nominal Current [P.U.]
Xs = 2;                 % Synchronous Reactance

                        % P: Active Power   
                        % Q: Reactive Power
                        % Ea: Induced voltage in stator windings
                        % theta: Power factor angle
                        % delta: Load angle

%%

ColorList  = ['r','g','b'];
LineWidth0 = 2.5;

%% Synchronous Stability Limit

deltaMax = 70/180*pi;  % Maxming Load Angle
m = tan(deltaMax);     

for ii = 1:length(V)
    b = V(ii)^2/Xs*m;
    Ps = @(Q) m*Q + b;
    
    q0(ii) = -V(ii)^2/Xs;
    q1(ii) = ((I(ii)^2*V(ii)^2*m^2 + I(ii)^2*V(ii)^2 - b^2)^(1/2) - b*m)/(m^2 + 1);
    
    q = linspace(q0(ii), q1(ii), 100);
    plot(q, Ps(q), 'LineWidth',LineWidth0, 'Color',ColorList(ii));
    
    hold on
end
%% Armature Current Limit
for ii = 1:length(V)
    theta0 = acos(PF);
    theta1 = asin(q1(ii)/(V(ii)*I(ii)));
    
    the = linspace(theta1,theta0,100);
    Pa = @(theta) V(ii)*I(ii)*cos(theta);
    Qa = @(theta) V(ii)*I(ii)*sin(theta);
    
    plot(Qa(the), Pa(the), 'LineWidth', LineWidth0, 'Color',ColorList(ii));
end
%% Field Current Limit
CC = PF; 
SS = (1-PF^2)^0.5;

for ii = 1:length(V)
    Ea = sqrt((V(ii) + Xs*I(ii)*SS)^2+(Xs*I(ii)*CC)^2);
    
    delta0 = acos((V(ii) + I(ii)*Xs*SS)/Ea);
    delta = linspace(0,delta0,100);
    
    Pf = @(delta)V(ii)*Ea/Xs*sin(delta);
    Qf = @(delta)V(ii)*Ea/Xs*cos(delta) - V(ii)^2/Xs;
    hold on
    plot(Qf(delta), Pf(delta), 'LineWidth',LineWidth0, 'Color',ColorList(ii));
end


%% Chart 

SemiCircleR = 0.2:0.2:1.2;
phi = linspace(0, pi, 100);

CirX = @(phi,r) r.*cos(phi);
CirY = @(phi,r) r.*sin(phi);

for rr = SemiCircleR
    plot(CirX(phi, rr), CirY(phi, rr), 'color',[0.4, 0.4, 0.4]);
    hold on
end

PhiList = asin([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7, ...
                0.75, 0.8, 0.85, 0.9, 0.95]);

rr = linspace(0.2, 1.2, 100);

for ii = 1:length(PhiList)
    plot(CirX(PhiList(ii), rr), CirY(PhiList(ii), rr), 'color',[0.4, 0.4, 0.4]);
    hold on
end
for ii = 1:length(PhiList)
    plot(-CirX(PhiList(ii), rr), CirY(PhiList(ii), rr), 'color',[0.4, 0.4, 0.4]);
    hold on
end

% Numbers -------------------------------------------------------------
R_tags = [ 0.2,0.4,0.6,0.8,1.0,1.2];
PF_tags = [0.2,0.4,0.6,0.7,0.75,0.8,0.85,0.9,0.95];

hT = text(-0.02, -0.03, '0.0');
set(hT, 'fontweight','bold','fontsize',12);
for ii = 1:length(R_tags)
    s1 = sprintf('%0.1f', R_tags(ii));
    hT = text(R_tags(ii)-0.03,-0.03, s1);   
    set(hT, 'fontweight','bold','fontsize',12);
    hT = text(-R_tags(ii)-0.03,-0.03, s1);
    set(hT, 'fontweight','bold','fontsize',12);
    hT = text(0.01,R_tags(ii)+0.03, s1);
    set(hT, 'fontweight','bold','fontsize',12);
end

Mt1 = [0,0,0,0,0,0.01,0.01,0.01,0.01];
Mt2 = [0,0,-0.03,-0.03,-0.02,-0.02,-0.02,-0.01,-0.015];
Mr2 = [0,-0.01,-0.01,-0.02,-0.02,-0.03,-0.03,-0.04,-0.05];

for jj = 1:length(PF_tags)
    s2 = sprintf('%0.2f', PF_tags(jj));
    pf0 = PF_tags(jj) + Mt1(jj);
    r0 = 1.22;
    hT = text(r0*(1- pf0^2)^0.5, r0*pf0, s2);
    set(hT, 'fontweight','bold','fontsize',12);
    pf0 = PF_tags(jj) + Mt2(jj); 
    r0 = 1.3 + Mr2(jj);
    hT = text(-r0*(1- pf0^2)^0.5, r0*pf0, s2); 
    set(hT, 'fontweight','bold','fontsize',12);
end

set(gcf, 'Unit','normalized','Position',[0,0,1,1])
set(gca,'visible','off')
set(gcf, 'color','w');

plot([-1.3 1.4],[0 0],'k', 'LineWidth',2); hold on
plot([0 0],[0 1.4],'k','LineWidth',2.2);

hT = text(1.3, -0.04, 'Q [P.U.]');
set(hT, 'fontweight','bold','fontsize',13);
hT = text(0.02, 1.35, 'P [P.U.]');
set(hT, 'fontweight','bold','fontsize',13);

axis equal;

hT = text(-0.5,1.5,'Synchronous Generator P-Q Curve');
set(hT, 'FontSize', 18, 'FontWeight','Bold');

hL = legend(' 1.05 * Un',' 0.95 * Un',' 1.00 * Un');
set(hL, 'fontsize',12, 'fontname','courier new')



