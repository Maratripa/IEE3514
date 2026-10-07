function retardo(pulso, canal)
    return length(pulso) + argmax(abs.(canal)) - 1
end
