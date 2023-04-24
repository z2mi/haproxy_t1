core.register_fetches("concat2", function(txn, var1, var2)
    return tostring(var1) .. tostring(var2)
end)


local function customstats(applet)


    local response = ""
    for _ ,fe in pairs(core.frontends) do
        if ( fe.stktable ~= nill ) then
            for key, value in pairs(fe.stktable:dump({})) do
                if ( value ~= nil ) then
                    response = response .. string.format([[
                    # HELP haproxy_path_req_count_last_day number of request for a path in last day
                    # TYPE haproxy_path_req_count_last_day counter
                    haproxy_path_req_count_last_day{path=%s} %d
                   ]], key, tonumber(value.http_req_cnt) )
                end
            end
        end

    end
    
    applet:set_status(200)
    applet:add_header("cache-control", "no-cache")
    applet:add_header("content-length", string.len(response))
    applet:add_header("content-type", "text/plain")
    applet:start_response()
    applet:send(response)
end

core.register_service("custom-stats", "http", customstats)