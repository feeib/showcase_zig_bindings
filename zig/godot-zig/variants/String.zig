const std = @import("std");

const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const internal: type = godot.internal;
const StringName: type = godot.StringName;
const Variant: type = godot.Variant;

const String = @This();

const string_size: u64 = 8;
@"opaque": [string_size]u8 align(8) = std.mem.zeroes([string_size]u8),

pub fn init() String {
    var ret: String = .{};
    internal.callBuiltinConstructorAnytype(internal.StringInternal.raw_bindings.constructor_0, @ptrCast(&ret), .{});
    return ret;
}

pub fn initWithUtf8(utf8: []const u8) String {
    var ret: String = std.mem.zeroes(String);
    gde.ci.string_new_with_utf8_chars.?(@ptrCast(&ret), @ptrCast(utf8.ptr));
    return ret;
}

pub fn initWithLatin(latin: []const u8) String {
    var ret: String = std.mem.zeroes(String);
    gde.ci.string_new_with_latin1_chars.?(@ptrCast(&ret), @ptrCast(latin.ptr));
    return ret;
}

pub fn initWithScalar(scalar: anytype) String {
    switch (@typeInfo(@TypeOf(scalar))) {
        .comptime_int, .int => {
            const number: i64 = scalar;
            const base: i64 = 10;
            const capitalize_hex: i8 = 0;
            return internal.callBuiltinMethodPtrRetAnytype(String, internal.StringInternal.raw_bindings.method_num_int64, null, .{ &number, &base, &capitalize_hex });
        },
        else => {},
    }
    return std.mem.zeroes(String);
}

pub fn initFromStringName(name: *StringName) String {
    var ret: String = .{};
    internal.callBuiltinConstructorAnytype(internal.StringInternal.raw_bindings.constructor_2, @ptrCast(&ret), .{name});
    return ret;
}

pub fn length(self: *String) i64 {
    return internal.callBuiltinMethodPtrRetAnytype(i64, internal.StringInternal.raw_bindings.method_length, @ptrCast(self), .{});
}

pub fn deinit(self: *String) void {
    internal.StringInternal.raw_bindings.destructor.?(@ptrCast(self));
    self.* = undefined;
}

pub fn format(
    self: *String,
    writer: anytype,
) !void {
    const buf: []u8 = std.heap.c_allocator.alloc(u8, @intCast(self.length())) catch @panic("alloc buffer");
    defer std.heap.c_allocator.free(buf);
    _ = gde.ci.string_to_utf8_chars.?(@ptrCast(self), buf.ptr, @intCast(buf.len));
    try writer.print("{s}", .{buf});
}
