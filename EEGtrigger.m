PscyDegaultSetup(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Triggering
%settings

portNum = 0; %Choose device port to use 0=A, 1=B
triggerValue = 2;

%find device
daqInd=DaqDeviceIndex;  %Scans USB-HID device list, returns index number for the USB DAQ.
HIDDevices=PsychHID('Devices');    %not generally used, but good for debugging if device is not found by DaqDeviceIndex.m
initialize device
DaqDConfigPort(daqInd(1),0,0); % set digital port A's mode to output
DaqDConfigPort(daqInd(1),1,0); % same for B
DaqDOut(daqInd(1),0,0);	%set A and B to zero
DaqDOut(daqInd(1),1,0);

DaqDOut(daqInd(1),portNum,triggerValue);
DaqDOut(daqInd(1),portNum,0);
