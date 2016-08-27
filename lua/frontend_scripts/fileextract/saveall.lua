-- save.lua
--
-- Save ALL HTTP payloads seen 
--
--
TrisulPlugin = {

  id = {
    name = "saveall",
    description = "save all files to a directory ",
    author = "Unleash",
    version_major = 1,
    version_minor = 0,
  },



  onload = function()
  	os.execute("mkdir -p /tmp/kk")
  end,


  -- 
  -- Monitor attaches itself to file extraction module(s)
  -- gets called at various stages, can control and add stats etc
  --
  filex_monitor  = {


    -- save all content to /tmp/kk 
    --
    onfile_http  = function ( engine, timestamp, flowkey, path, req_header, resp_header, length )
       local fn = path:match("^.+/(.+)$")
       if fn then
           T.async:schedule( 
                {
                    data = "cp "..path.."  /tmp/kk/"..fn,

                    onexecute = function( indata) 
						require "os";
						os.execute(indata)
                    end,

                    oncomplete = function( indata, outdata)

                    end,
                }
           )
       end
    end,

 }

}

