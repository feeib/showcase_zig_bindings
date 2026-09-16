const std: type = @import("std");

pub fn typeName(comptime T: type) []const u8 {
    var iter: std.mem.SplitBackwardsIterator(u8, .scalar) = std.mem.splitBackwardsScalar(u8, @typeName(T), '.');
    return iter.first();
}

pub fn fnName(comptime T: type, comptime F: anytype) []const u8 {
    inline for (@typeInfo(T).@"struct".decls) |decl| {
        const field = @field(T, decl.name);
        if (@TypeOf(field) == @TypeOf(F) and field == F) return decl.name;
        // if (@field(T, decl.name) == F) return decl.name;
    }

    comptime unreachable;
}
