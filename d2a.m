function s_an = d2a(s, Nup, Pulso)
  % zero-stuffing
  % s(1) - (Nup - 1)*0 - s(2) - ...
  
  stuffed(1:Nup:Nup * length(s) - 1) = s;


  s_an = conv(stuffed, Pulso);
end
