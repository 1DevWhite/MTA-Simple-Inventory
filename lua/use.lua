function getItem(player, id)
    if not isGuestAccount(getPlayerAccount(player)) and bagItem[id] then
        local bag = getElementData(player, "bag");
        if bag[id] then
            return bag[id];
        else
            return nil;
        end;
    else
        outputDebugString("ERRO AO VERIFICAR O ITEM, VERIFIQUE O SE O PLAYER ESTA ONLINE, ID, QUANTIA");
    end;
end;

function giveItem(player, id, ammount)
   if not isGuestAccount(getPlayerAccount(player)) and bagItem[id] and ammount > 0 then
    local bag = getElementData(player, "bag");
        if getItem(player, id) then 
            bag[id] = {name = bagItem[id].name , description = bagItem[id].description, price = bagItem[id].price, data = bagItem[id].data, ammount = bag[id].ammount + ammount}; return true;
        else
            bag[id] = {name = bagItem[id].name , description = bagItem[id].description, price = bagItem[id].price, data = bagItem[id].data, ammount = ammount}; return true;
        end;
        setElementData(player, "bag", bag);
    else
        outputDebugString("ERRO AO ENVIAR O ITEM, VERIFIQUE O SE O PLAYER ESTA ONLINE, ID, QUANTIA");
   end;
end;

function takeItem(player, id, ammount or 1)
    if not isGuestAccount(getPlayerAccount(player)) and bagItem[id].ammount > 0 then
        local bag = getElementData(player, "bag");
        if getItem[id] then
            local nAmmount = bag[id].ammount - ammount;
            if nAmmount > 0 then 
                bag[id] = {name = bagItem[id].name , description = bagItem[id].description, price = bagItem[id].price, data = bagItem[id].data, ammount = nAmmount}; return true;
            elseif nAmmount == 0 then
                bag[id] = nil; return true;
            else return false; end;
        end;
    else
        outputDebugString("ERRO AO TIRAR O ITEM, VERIFIQUE O SE O PLAYER ESTA ONLINE, ID, QUANTIA");
    end;
end;