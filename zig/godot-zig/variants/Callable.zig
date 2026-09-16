const std: type = @import("std");

const godot: type = @import("../godot.zig");
const StringName: type = godot.StringName;
const internal: type = godot.internal;

const Callable: type = @This();

const callable_size: u64 = 16;
@"opaque": [callable_size]u8 align(8) = std.mem.zeroes([callable_size]u8),

pub fn initWithObject(instance: *anyopaque, name: *const StringName) Callable {
    var ret: Callable = .{};
    internal.callBuiltinConstructorAnytype(internal.CallableInternal.raw_bindings.constructor_2, &ret, .{ &instance, name });
    return ret;
}

pub fn deinit(self: *Callable) void {
    internal.CallableInternal.raw_bindings.destructor.?(@ptrCast(self));
    self.* = undefined;
}
