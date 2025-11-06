local HttpService = game:GetService('HttpService');
local JSONDecode = function(v) return HttpService:JSONDecode(v); end;
local req = (request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request))
	
local ScriptBlox = { Server = 'https://scriptblox.com' }
	
function ScriptBlox:GetPath(Path: string)
	local GetJSONDataFromServerPath = req({ Url = ScriptBlox.Server .. Path, Method = 'GET'});
	
	if GetJSONDataFromServerPath.Success then
		local Success, Result = pcall(JSONDecode, GetJSONDataFromServerPath.Body);
        local Check = Success and Result and Result.result and Result.result.scripts;

		if Check then
			return Result.result.scripts
		else
			warn(`Could not decode JSON -> {data}`)
		end
	else
		warn(`Failed to send a request\nStatusCode -> {result.StatusCode}\nBody -> {result.Body}`);
	end
	
	return {
		Result = {
			AmountOfPages = 1,
			ScriptsActive = {}
		}
	}
end
	
	
function ScriptBlox:Search(SearchQueue: string, Page: number, UntilStopped: number)
	return ScriptBlox:GetPath('/api/script/search?q=' .. SearchQueue .. '&mode=free&max=' .. tostring(UntilStopped) .. '&page=' .. tostring(Page));
end
