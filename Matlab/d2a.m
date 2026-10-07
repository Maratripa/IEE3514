function s_an = d2a(s, Nup, Pulso)
  % zero-stuffing
  % s(1) - (Nup - 1)*0 - s(2) - ...
  
  stuffed = zeros(1, length(s)*Nup);
  stuffed(1:Nup:end) = s;


  s_an = conv(stuffed, Pulso);
end
