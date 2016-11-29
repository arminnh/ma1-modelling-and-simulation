function [ x ] = SN_logYields( s )
%SN_LOGYIELDS returns log yields of the given vector
    x = log( s(2:length(s)) ./ s(1:length(s)-1) );
end