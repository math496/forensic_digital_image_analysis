function [  ] = LuminanceLevelTechnique( imagearg, thresh )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

im2bw( imread(imagearg), thresh );

end

