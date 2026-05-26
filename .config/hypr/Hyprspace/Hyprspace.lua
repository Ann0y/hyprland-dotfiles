local M = {}

local ENV_PLUGIN_PATH = os.getenv("HYPRSPACE_PLUGIN_PATH")
local MODULE_DIR = (debug.getinfo(1, "S").source or ""):match("^@(.+)/[^/]+$")
local LOCAL_PLUGIN_PATH = MODULE_DIR and (MODULE_DIR .. "/Hyprspace.so") or nil

local state = {
    mode = "auto",
    plugin_path = nil,
    hooks_registered = false,
}

local function file_exists(path)
    if type(path) ~= "string" or path == "" then
        return false
    end

    local file = io.open(path, "r")
    if not file then
        return false
    end

    file:close()
    return true
end

local function shell_quote(value)
    return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function plugin_loaded()
    return hl.plugin and hl.plugin.Hyprspace and type(hl.plugin.Hyprspace.overview) == "function"
end

local function plugin_paths()
    local paths = {}
    local seen = {}

    local function add(path)
        if type(path) ~= "string" or path == "" or seen[path] then
            return
        end

        seen[path] = true
        table.insert(paths, path)
    end

    if state.mode == "manual" then
        add(state.plugin_path)
    end

    add(ENV_PLUGIN_PATH)
    add(LOCAL_PLUGIN_PATH)

    return paths
end

local function resolve_plugin_path()
    for _, path in ipairs(plugin_paths()) do
        if file_exists(path) then
            return path
        end
    end

    return nil
end

local function ensure_plugin_loaded()
    if plugin_loaded() then
        return true
    end

    local path = resolve_plugin_path()
    if path then
        hl.exec_cmd("hyprctl plugin load " .. shell_quote(path))
        if plugin_loaded() then
            return true
        end
    end

    -- hyprpm: enabled plugins may not be loaded yet when Lua config runs
    hl.exec_cmd("hyprpm reload")
    return plugin_loaded()
end

local function build_config()
    return {
        plugin = {
            hyprspace = {
                panel_color = 0x00000000,
                panel_border_color = 0x00000000,
                workspace_active_background = 0xb8333333,
                workspace_inactive_background = 0xde1a1a1a,
                workspace_active_border = 0xb0aaaaaa,
                workspace_inactive_border = 0x55333333,

                panel_height = 50,
                workspace_margin = 10,
                reserved_area = 35,
                workspace_border_size = 1,

                center_aligned = true,
                on_bottom = false,
                draw_active_workspace = true,
                hide_real_layers = true,
                affect_strut = false,

                auto_drag = true,
                auto_scroll = true,
                exit_on_click = true,
                exit_on_switch = false,

                disable_gestures = true,
                swipe_fingers = 3,
                swipe_distance = 300,
                swipe_force_speed = 30,
                swipe_cancel_ratio = 0.5,
                click_release_threshold_ms = 200,
            },
        },
    }
end

local function apply_config()
    if not plugin_loaded() then
        return false
    end

    hl.config(build_config())
    return true
end

local function sync_plugin()
    ensure_plugin_loaded()
    return apply_config()
end

local function dispatch_overview(action)
    local command = action or "toggle"
    local valid = {
        toggle = true,
        open = true,
        close = true,
        toggle_all = true,
        open_all = true,
        close_all = true,
    }

    if not valid[command] then
        return false
    end

    if command:sub(-4) == "_all" then
        hl.exec_cmd("hyprctl dispatch overview:" .. command:sub(1, -5) .. " all")
    else
        hl.exec_cmd("hyprctl dispatch overview:" .. command)
    end

    return true
end

local function schedule_sync(delay_ms, attempts)
    hl.timer(function()
        if sync_plugin() or attempts <= 1 then
            return
        end

        schedule_sync(delay_ms, attempts - 1)
    end, { timeout = delay_ms, type = "oneshot" })
end

local function register_hooks()
    if state.hooks_registered then
        return
    end

    hl.on("hyprland.start", function()
        schedule_sync(150, 6)
    end)

    hl.on("config.reloaded", function()
        schedule_sync(150, 4)
    end)

    state.hooks_registered = true
end

function M.apply_config()
    return sync_plugin()
end

function M.reload()
    local applied = sync_plugin()
    hl.exec_cmd("hyprctl reload")
    return applied
end

function M.overview(action)
    local command = action or "toggle"

    sync_plugin()

    if plugin_loaded() then
        hl.plugin.Hyprspace.overview(command)
        return true
    end

    return dispatch_overview(command)
end

function M.toggle()
    return M.overview("toggle")
end

function M.setup(opts)
    state.mode = "auto"
    state.plugin_path = nil

    if type(opts) == "table" and type(opts.plugin_path) == "string" and opts.plugin_path ~= "" then
        state.mode = "manual"
        state.plugin_path = opts.plugin_path
    end

    register_hooks()
    schedule_sync(150, 3)
end

return M
