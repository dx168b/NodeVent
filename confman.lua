--*************************************************************
--*                   Configuration manager V2                *
--*************************************************************
-- ADAPTED FOR ESP8266 NodeMCU

-- Main table of "confman" module
local confman = {};

--*************************************************************
--*                     Private functions                     *
--*************************************************************
local function ParseTbl(tbl, tbLvl, wrStr)
	local tabLevel = tbLvl.."\t";
	
	for key, value in pairs(tbl)
	do
		if(type(value) == "table")
		then
			-- type = table
			if(type(key) ~= "number")
			then
				wrStr = wrStr..tabLevel..key.." =\n"..tabLevel.."{\n";
			else
				wrStr = wrStr..tabLevel.."{\n";
			end
			wrStr = ParseTbl(value, tabLevel, wrStr);
			wrStr = wrStr..tabLevel.."},\n";
		elseif(type(value) == "string")
		then
			-- type = string
			if(type(key) ~= "number")
			then
				wrStr = wrStr..tabLevel..key.." = \""..string.gsub(value, "\n", "\\n").."\",\n";
			else
				wrStr = wrStr..tabLevel.."\""..string.gsub(value, "\n", "\\n").."\",\n";
			end
			
		elseif(type(value) == "boolean")
		then
			-- type = bool
			local var = "false";
			
			if(value == true)
			then 
				var = "true";
			end
			
			if(type(key) ~= "number")
			then
				wrStr = wrStr..tabLevel..key.." = "..var..",\n";
			else
				wrStr = wrStr..tabLevel..var..",\n";
			end
			
		elseif(type(value) == "number")
		then
			-- type = number
			if(type(key) ~= "number")
			then
				wrStr = wrStr..tabLevel..key.." = "..value..",\n";
			else
				wrStr = wrStr..tabLevel..value..",\n";
			end
		else
			-- type = other (func, userdata, etc)
		end
		
	end
	
	return wrStr;
end

--*************************************************************
--*                        Constants                          *
--*************************************************************

-- SaveConfig return values
confman.OPERATION_OK = 0;
confman.ERROR_CREATE_FILE = -1;
confman.ERROR_PARSE_TABLE = -2;
confman.ERROR_INPUT_DATA = -3;

--*************************************************************
--*                   Public functions                        *
--*************************************************************
---------------------------------------------------------------
-- Function SaveConfig(filePath, inputTable, pParam)
-- Arguments:
-- 1 arg - File path string
-- 2 arg - Table to parse (NOT USERDATA!)
-- 3 arg - reserved
-- Return:
-- 1 value:
-- 		OPERATION_OK
--		ERROR_PARSE_TABLE
--		ERROR_CREATE_FILE
--		ERROR_INPUT_DATA
function confman.SaveConfig(filePath, inputTable, pParam)

	if(type(inputTable) == "table")
	then
		local fileOut = file.open(filePath, "w");
		
		if(fileOut ~= nil)
		then
			local wrString = ParseTbl(inputTable, "", "return\n{\n");
			
			if((wrString ~= nil) and (type(wrString) == "string"))
			then
				wrString = wrString.."};\n";
				fileOut:write(wrString);
				file.close(fileOut);
				collectgarbage("collect");
				return confman.OPERATION_OK;
			else
				file.close(fileOut);
				collectgarbage("collect");
				return confman.ERROR_PARSE_TABLE;
			end
		else
			collectgarbage("collect");
			return confman.ERROR_CREATE_FILE;
		end
	else
		return confman.ERROR_INPUT_DATA;
	end
end

---------------------------------------------------------------
-- Function PrintConfig(inputTable, printFunc)
-- Arguments:
-- 1 arg - Table to parse (NOT USERDATA!)
-- 3 arg - function for print string
-- 2 arg - table name to print
-- Return:
-- 1 value:
-- 		OPERATION_OK
--		ERROR_PARSE_TABLE
--		ERROR_INPUT_DATA
function confman.PrintConfig(inputTable, printFunc, tableName)
	if((printFunc == nil) or (type(printFunc) ~= "function"))
	then
		printFunc = print;
	end
	
	local wrString = "";
	
	if(type(inputTable) == "table")
	then
		if((tableName ~= nil) and (type(tableName) == "string"))
		then
			wrString = ParseTbl(inputTable, "", tableName.." =\n{\n");
		else
			wrString = ParseTbl(inputTable, "", "table =\n{\n");
		end
			
		if((wrString ~= nil) and (type(wrString) == "string"))
		then
			wrString = wrString.."};\n";
			printFunc(wrString);
			collectgarbage("collect");
			return confman.OPERATION_OK;
		else
			printFunc("Error parse table");
			collectgarbage("collect");
			return confman.ERROR_PARSE_TABLE;
		end
	else
		return confman.ERROR_INPUT_DATA;
	end
end

---------------------------------------------------------------
-- Function LoadConfig(filePath)
-- Arguments:
-- 1 arg - File path string
-- Return:
-- 1 value:
-- 		nil - error load
--		table - load success
function confman.LoadConfig(filePath)
	local resFunc, err = loadfile(filePath);
	
	if(resFunc == nil) then 
		print("Confman ERROR: "..err);
		collectgarbage("collect");
		return nil;
	else
		if(type(resFunc) == "function") then
			print("Confman NOTIFY: File \""..filePath.."\" loaded success.")
			return resFunc();
		else
			print("Confman ERROR: Result is not a function!");
			collectgarbage("collect");
			return nil;
		end
	end
end

---------------------------------------------------------------
-- End of module
return confman;
