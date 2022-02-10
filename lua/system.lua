local tableBag = {};
local db;
local dbPatch = "db/data.db";

local function initiateDb()
    db = dbConnect("sqlite", dbPatch);
    dbExec(db, "CREATE TABLE IF NOT EXISTS bags (playerSerial VARCHAR(32), playerBag TEXT)");
    if not db then
        error("[DB - INVENTORY SYSTEM] Couldn't connect to database'");
    else
        outputDebugString("[DB - INVENTORY SYSTEM] initiate.");
        dbQuery(function(qh)
            local results = dbPoll(qh, -1);
            for i,v in pairs(results) do
                tableBag[v.playerSerial] = {bag = fromJSON(v.playerBag)};
            end;
        end, db, "SELECT * FROM bags");
    end;
end;

local function initiateBag(_, acc)
    if not isGuestAccount(acc) then
        local pSerial = getPlayerSerial(source);
        setElementData(source, "bag", tableBag[pSerial].bag or {});
    end;
end;

local function closeBag()
    local pBag = getElementData(source, "bag") or {};
    local pSerial = getPlayerSerial(source);
    setElementData(source, "bag", nil);
    tableBag[pSerial] = {bag = pBag};
end;

local function stopBag()
    for i,v in pairs(tableBag) do
        dbExec(db, "INSERT OR IGNORE INTO bags (playerSerial, playerBag) VALUES (?,?)", i, toJSON(v.bag));
        dbExec(db, "UPDATE bags SET playerBag = ? WHERE playerSerial = ?", toJSON(v.bag), i);
    end;
end;

addEventHandler("onResourceStart", resourceRoot, initiateDb);
addEventHandler("onPlayerLogin", root, initiateBag);
addEventHandler("onPlayerQuit", root, closeBag);
addEventHandler("onResourceStop", root, stopBag);








--CANCEL LOGOUT EVENT--
aclSetRight(aclGet ( "Default") , "command.logout" , false); aclSave();