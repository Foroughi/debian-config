




function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end


local localNvimExits , err = exists(vim.fn.getcwd() .. "/.nvim/local-init.lua")
if localNvimExits then

         
        local oldpath = package.path;

        package.path = vim.fn.getcwd() .. "/.nvim/?.lua;" .. oldpath;

        require("local-init");
else
   require("keys")
   require("options")

   require("plugins")
end
