function retardo(pulso, canal)
    return length(pulso) + argmax(abs.(Canal)) - 1
end
