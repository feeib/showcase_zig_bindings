const std: type = @import("std");

const godot: type = @import("../godot.zig");
const internal: type = godot.internal;
const Variant: type = godot.Variant;
const Callable: type = godot.Callable;
const gde: type = godot.gde;
const mixins: type = godot.internal;
const StringName: type = godot.StringName;

const Object: type = @This();

pub const notification_postinitialize = 0;
pub const notification_predelete = 1;
pub const notification_extension_reloaded = 2;

pub fn notification(
    instance: anytype,
    what: i64,
    reversed: bool,
) void {
    var what_encoded: i64 = @intCast(what);
    var reversed_encoded: i8 = @intCast(@intFromBool(reversed));
    internal.ptrCallNativeMethodBindNoRetAnytype(internal.ObjectInternal.raw_bindings.notification, instance.base.?, .{ &what_encoded, &reversed_encoded });
}

pub fn connect(
    instance: anytype,
    name: *StringName,
    callable: *Callable,
    flags: i64,
) internal.Error!void {
    var flags_encoded: i64 = flags;
    const err: internal.ErrorInternal = internal.callNativeMethodBindRetAnytype(internal.ObjectInternal.raw_bindings.connect, instance.base.?, .{ name, callable, &flags_encoded });
    return internal.errorInternalWrap(err);
}

pub fn emitSignal(
    instance: anytype,
    name: *StringName,
    args: anytype,
) internal.Error!void {
    var call_args: [args.len + 1]*Variant = undefined;
    var var_arg0: Variant = .init(name);
    call_args[0] = @ptrCast(&var_arg0);

    defer {
        for (call_args) |arg| {
            arg.deinit();
        }
    }

    inline for (args, 1..) |arg, idx| {
        var var_arg: Variant = .init(arg);
        call_args[idx] = @ptrCast(&var_arg);
    }

    const err: internal.ErrorInternal = internal.callNativeMethodBindRetVariant(internal.ObjectInternal.raw_bindings.emit_signal, instance.base.?, @ptrCast(&call_args));
    return internal.errorInternalWrap(err);
}
