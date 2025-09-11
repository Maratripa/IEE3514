function [s_i, s_q] = qammod(mensaje, M)
  switch M
    case 2
      s_i = 2*mensaje + 1;
      s_q = zeros(1, length(mensaje));
    case 4
      s_i = mensaje(1:2:length(mensaje));
      s_q = mensaje(2:2:length(mensaje));

      s_i = (2*s_i - 1) / sqrt(2);
      s_q = (2*s_q - 1) / sqrt(2);
    case 16
      bit_matrix = reshape(mensaje, 4, []);
      
      group_i = bit_matrix(1:2, :);
      group_q = bit_matrix(3:4, :);

      decimal_i = [2 1] * group_i;
      decimal_q = [2 1] * group_q;

      constellation = [-3 -1 3 1];

      s_i = constellation(decimal_i + 1) / sqrt(10);
      s_q = constellation(decimal_q + 1) / sqrt(10);
    case 64
      bit_matrix = reshape(mensaje, 6, []);

      group_i = bit_matrix(1:3, :);
      gropu_q = bit_matrix(4:6, :);

      decimal_i = [4 2 1] * group_i;
      decimal_q = [4 2 1] * group_q;

      constellation = [-7 -5 -1 -3 7 5 1 3];

      s_i = constellation(decimal_i + 1) / sqrt(42);
      s_q = constellation(decimal_q + 1) / sqrt(42);
    otherwise
      error("Error. M (%d) no es un valor M-ario soportado.", M);
  end
end
