local ok, api = pcall(require, "codeium.api")
if not ok then
  return
end

if api._port_guard_applied then
  return
end

api._port_guard_applied = true

local notify_ok, notify = pcall(require, "codeium.notify")
local orig_request = api.request

function api:request(fn, payload, callback)
  if not self.port then
    if notify_ok then
      notify.warn("Codeium server not ready yet")
    end
    return
  end
  return orig_request(self, fn, payload, callback)
end
