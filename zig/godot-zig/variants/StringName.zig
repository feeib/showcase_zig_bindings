const std: type = @import("std");

const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const internal: type = godot.internal;
const String: type = godot.String;

const StringName: type = @This();

const string_name_size: u64 = 8;
@"opaque": [string_name_size]u8 align(8) = std.mem.zeroes([string_name_size]u8),

pub fn init() StringName {
    var ret: StringName = std.mem.zeroes(StringName);
    internal.callBuiltinConstructorAnytype(internal.StringNameInternal.raw_bindings.constructor_0, @ptrCast(&ret), .{});
    return ret;
}

pub fn initWithLatin(
    latin: []const u8,
    static: bool,
) StringName {
    var ret: StringName = std.mem.zeroes(StringName);
    gde.ci.string_name_new_with_latin1_chars.?(@ptrCast(&ret), @ptrCast(latin.ptr), @intCast(@intFromBool(static)));
    return ret;
}

pub fn length(self: *StringName) i64 {
    return internal.callBuiltinMethodPtrRetAnytype(i64, internal.StringNameInternal.raw_bindings.method_length, @ptrCast(self), .{});
}

pub fn hash(self: *StringName) i64 {
    return internal.callBuiltinMethodPtrRetAnytype(i64, internal.StringNameInternal.raw_bindings.method_hash, @ptrCast(self), .{});
}

pub fn deinit(self: *StringName) void {
    internal.StringNameInternal.raw_bindings.destructor.?(@ptrCast(self)); // todo
    self.* = undefined;
}

pub fn format(
    self: StringName,
    writer: anytype,
) !void {
    var str: String = .initFromStringName(@ptrCast(@constCast(&self)));
    defer str.deinit();
    const buf: []u8 = std.heap.c_allocator.alloc(u8, @intCast(str.length())) catch @panic("alloc buffer");
    defer std.heap.c_allocator.free(buf);
    _ = gde.ci.string_to_utf8_chars.?(@ptrCast(&str), buf.ptr, @intCast(buf.len));
    try writer.print("{s}", .{buf});
}
