const godot: type = @import("godot.zig");
const gde: type = godot.gde;
const StringName: type = godot.StringName;
const Variant: type = godot.Variant;

pub fn print(args: anytype) void {
    var call_args: [args.len]gde.c.GDExtensionConstVariantPtr = undefined;
    inline for (args, 0..) |arg, idx| {
        call_args[idx] = @ptrCast(&arg);
    }

    var name: StringName = .initWithLatin("print", true);
    // var ret: Variant = .init();
    const function: gde.c.GDExtensionPtrUtilityFunction = gde.ci.variant_get_ptr_utility_function.?(@ptrCast(&name), 2648703342);
    function.?(null, @ptrCast(&call_args), @intCast(args.len));
}
