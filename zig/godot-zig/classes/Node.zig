const std: type = @import("std");

const godot: type = @import("../godot.zig");
const internal: type = godot.internal;
const mixins: type = godot.mixins;
const Object: type = godot.Object;
const t: type = godot.types;

const Node: type = @This();

pub const notification_enter_tree = 10;
pub const notification_exit_tree = 11;
pub const notification_moved_in_parent = 12;
pub const notification_ready = 13;
pub const notification_paused = 14;
pub const notification_unpaused = 15;
pub const notification_physics_process = 16;
pub const notification_process = 17;
pub const notification_parented = 18;
pub const notification_unparented = 19;
pub const notification_scene_instantiated = 20;
pub const notification_drag_begin = 21;
pub const notification_drag_end = 22;
pub const notification_path_renamed = 23;
pub const notification_child_order_changed = 24;
pub const notification_internal_process = 25;
pub const notification_internal_physics_process = 26;
pub const notification_post_enter_tree = 27;
pub const notification_disabled = 28;
pub const notification_enabled = 29;
pub const notification_reset_physics_interpolation = 2001;
pub const notification_editor_pre_save = 9001;
pub const notification_editor_post_save = 9002;
pub const notification_wm_mouse_enter = 1002;
pub const notification_wm_mouse_exit = 1003;
pub const notification_wm_window_focus_in = 1004;
pub const notification_wm_window_focus_out = 1005;
pub const notification_wm_close_request = 1006;
pub const notification_wm_go_back_request = 1007;
pub const notification_wm_size_changed = 1008;
pub const notification_wm_dpi_change = 1009;
pub const notification_vp_mouse_enter = 1010;
pub const notification_vp_mouse_exit = 1011;
pub const notification_wm_position_changed = 1012;
pub const notification_os_memory_warning = 2009;
pub const notification_translation_changed = 2010;
pub const notification_wm_about = 2011;
pub const notification_crash = 2012;
pub const notification_os_ime_update = 2013;
pub const notification_application_resumed = 2014;
pub const notification_application_paused = 2015;
pub const notification_application_focus_in = 2016;
pub const notification_application_focus_out = 2017;
pub const notification_text_server_changed = 2018;
pub const notification_accessibility_update = 3000;
pub const notification_accessibility_invalidate = 3001;

pub fn setProcess(
    instance: anytype,
    enable: bool,
) void {
    var enable_encoded: i8 = @intCast(@intFromBool(enable));
    internal.ptrCallNativeMethodBindNoRetAnytype(internal.NodeInternal.raw_bindings.set_process, instance.base.?, .{&enable_encoded});
}

pub fn setPhysicsProcess(
    instance: anytype,
    enable: bool,
) void {
    var enable_encoded: i8 = @intCast(@intFromBool(enable));
    internal.ptrCallNativeMethodBindNoRetAnytype(internal.NodeInternal.raw_bindings.set_physics_process, instance.base.?, .{&enable_encoded});
}

pub fn getProcessDeltaTime(instance: anytype) f64 {
    return internal.ptrCallNativeMethodBindRetAnytype(f64, internal.NodeInternal.raw_bindings.get_process_delta_time, instance.base.?, .{});
}

pub fn queueFree(
    instance: anytype,
) void {
    internal.ptrCallNativeMethodBindNoRetAnytype(internal.NodeInternal.raw_bindings.queue_free, instance.base.?, .{});
}
