% File: test_thorlabszstage.m
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 21.02.2021

% Description: small test script to check basic functionality

T = ThorlabsZStage();

serialNumbers = T.List_Devices();
T.Home();

currPos = T.pos

T.Disconnect();
clear T;