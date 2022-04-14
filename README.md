[![View Matlab Dynamic Programming on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://de.mathworks.com/matlabcentral/fileexchange/86573-matlab-dynamic-programming)

# Synchronous Generator Capability Curve (P-Q Curve) using MATLAB

The generator operating limits is expressed in the form of the generator P-Q diagram. In other words, generator P-Q diagram
provides a safe boundary in which the generator can operate without exceeding thermal limitations.

In this publication, practical steps for drawing Generator Capability Curve using MATLAB is presented  .

Assumptions:

	* Synchronous Generator
	* Round Rotor
	* Armature Winding Resistance is neglected
	* Quantities are expressed based on Per Unit (P.U.) system
	
Parameters and Quantities definitions:

	* Sn	: Nominal Apparent Power
	* P 	: Active Power
	* Q 	: Reactive Power
	* Ea	: Induced voltage in stator windings
	* V 	: Terminal Voltage
	* I 	: Armature Current
	* PF	: Power Factor
	* Xs	: Synchronous Reactance
	* theta	: Power factor angle
	* delta : Load angle

In the following, three main limits of generator capability is presented:

## 1. Armature Current Limit

Armature Current Limitation will resulted in the following equations for P and Q:
<p align="left">
  <img src="../master/Pic/Armature_Current_Limit.png" />
</p>

	
## 2. Field Current Limit 

Field Current Limitation will resulted in the following equations for P and Q:

<p align="left">
  <img src="../master/Pic/Field_Current_Limit.png" />
</p>


## 3. Stability Limit

Stability of the turbogenerator is the ability to
stay in synchronous operation under slow load changes.

Stability limitation will resulted in the following equations for P and Q:

<p align="left">
  <img src="../master/Pic/Stability_Limit.png" />
</p>

## Usage:

Just define the required parameters as follows and run the script

``` MATLAB
%% Synchronous Generator P-Q Curve

%% Parameter Definition
Sn = 1;                 % Rated apparent power [P.U.]
PF = 0.85;              % Power Factor 
V = [1.05, 0.95, 1];    % Terminal Voltage (+-5% Voltage Variation) [P.U.]
I = Sn./V;              % Nominal Current [P.U.]
Xs = 2;                 % Synchronous Reactance

```

## Usage:
Synchronous Generator P-Q Curve:

<p align="left">
  <img src="../master/Pic/P_Q_Curve_Capability_Curve.png" />
</p>


## Contact

Email: smtoraabi@ymail.com

