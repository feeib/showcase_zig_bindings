const std: type = @import("std");

const godot: type = @import("../godot.zig");
const gde: type = godot.gde;
const misc: type = godot.misc;
const Object: type = godot.Object;
const String: type = godot.String;
const StringName: type = godot.StringName;
const Variant: type = godot.Variant;
const Callable: type = godot.Callable;
const Vector2f: type = godot.Vector2f;
const Vector2i: type = godot.Vector2i;

pub const VariantInternal = struct {
    pub var raw_bindings: struct {
        from_type_constructor: [gde.c.GDEXTENSION_VARIANT_TYPE_VARIANT_MAX]gde.c.GDExtensionVariantFromTypeConstructorFunc,
        to_type_constructor: [gde.c.GDEXTENSION_VARIANT_TYPE_VARIANT_MAX]gde.c.GDExtensionVariantFromTypeConstructorFunc,
    } = undefined;

    pub fn initializeBindings() void {
        for (1..gde.c.GDEXTENSION_VARIANT_TYPE_VARIANT_MAX) |idx| {
            VariantInternal.raw_bindings.from_type_constructor[idx] = gde.ci.get_variant_from_type_constructor.?(@as(c_uint, @intCast(idx)));
            VariantInternal.raw_bindings.to_type_constructor[idx] = gde.ci.get_variant_to_type_constructor.?(@as(c_uint, @intCast(idx)));
        }
    }
};

pub const CallableInternal = struct {
    pub var raw_bindings: struct {
        from_variant_constructor: gde.c.GDExtensionTypeFromVariantConstructorFunc,
        constructor_0: gde.c.GDExtensionPtrConstructor,
        constructor_1: gde.c.GDExtensionPtrConstructor,
        constructor_2: gde.c.GDExtensionPtrConstructor,
        destructor: gde.c.GDExtensionPtrDestructor,
    } = undefined;

    pub fn initializeBindings() void {
        CallableInternal.raw_bindings.from_variant_constructor = gde.ci.get_variant_to_type_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE);
        CallableInternal.raw_bindings.constructor_0 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE, 0);
        CallableInternal.raw_bindings.constructor_1 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE, 1);
        CallableInternal.raw_bindings.constructor_2 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE, 2);
        CallableInternal.raw_bindings.destructor = gde.ci.variant_get_ptr_destructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE);
    }

    pub fn initFromVariantConstructor(variant: *const Variant) Callable {
        const ret: Callable = {};
        Callable.raw_methods.from_variant_constructor.?(&ret, variant);
        return ret;
    }
};

pub const StringInternal = struct {
    pub var raw_bindings: struct {
        from_variant_constructor: gde.c.GDExtensionTypeFromVariantConstructorFunc,
        constructor_0: gde.c.GDExtensionPtrConstructor,
        constructor_1: gde.c.GDExtensionPtrConstructor,
        constructor_2: gde.c.GDExtensionPtrConstructor,
        constructor_3: gde.c.GDExtensionPtrConstructor,
        destructor: gde.c.GDExtensionPtrDestructor,
        method_length: gde.c.GDExtensionPtrBuiltInMethod,
        method_hash: gde.c.GDExtensionPtrBuiltInMethod,
        method_num_int64: gde.c.GDExtensionPtrBuiltInMethod,
    } = undefined;

    pub fn initializeBingings() void {
        StringInternal.raw_bindings.from_variant_constructor = gde.ci.get_variant_to_type_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING);
        StringInternal.raw_bindings.constructor_0 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, 0);
        StringInternal.raw_bindings.constructor_1 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, 1);
        StringInternal.raw_bindings.constructor_2 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, 2);
        StringInternal.raw_bindings.constructor_3 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, 3);
        StringInternal.raw_bindings.destructor = gde.ci.variant_get_ptr_destructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING);

        var name: StringName = .initWithLatin("length", true);
        StringInternal.raw_bindings.method_length = gde.ci.variant_get_ptr_builtin_method.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, @ptrCast(&name.@"opaque"), 3173160232);
        name = .initWithLatin("hash", true);
        StringInternal.raw_bindings.method_hash = gde.ci.variant_get_ptr_builtin_method.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, @ptrCast(&name.@"opaque"), 3173160232);
        name = .initWithLatin("num_int64", true);
        StringInternal.raw_bindings.method_num_int64 = gde.ci.variant_get_ptr_builtin_method.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING, @ptrCast(&name.@"opaque"), 2111271071);
    }

    pub fn initFromVariantConstructor(variant: *const Variant) String {
        const ret: String = {};
        String.raw_methods.from_variant_constructor.?(&ret, variant);
        return ret;
    }
};

pub const StringNameInternal = struct {
    pub var raw_bindings: struct {
        from_variant_constructor: gde.c.GDExtensionTypeFromVariantConstructorFunc,
        constructor_0: gde.c.GDExtensionPtrConstructor,
        constructor_1: gde.c.GDExtensionPtrConstructor,
        constructor_2: gde.c.GDExtensionPtrConstructor,
        destructor: gde.c.GDExtensionPtrDestructor,
        method_length: gde.c.GDExtensionPtrBuiltInMethod,
        method_hash: gde.c.GDExtensionPtrBuiltInMethod,
    } = undefined;

    pub fn initializeBindings() void {
        StringNameInternal.raw_bindings.from_variant_constructor = gde.ci.get_variant_to_type_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME);
        StringNameInternal.raw_bindings.constructor_0 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME, 0);
        StringNameInternal.raw_bindings.constructor_1 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME, 1);
        StringNameInternal.raw_bindings.constructor_2 = gde.ci.variant_get_ptr_constructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME, 2);
        StringNameInternal.raw_bindings.destructor = gde.ci.variant_get_ptr_destructor.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME);

        var name: StringName = .initWithLatin("length", true);
        StringNameInternal.raw_bindings.method_length = gde.ci.variant_get_ptr_builtin_method.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME, @ptrCast(&name), @intCast(3173160232));
        name = .initWithLatin("hash", true);
        StringNameInternal.raw_bindings.method_hash = gde.ci.variant_get_ptr_builtin_method.?(gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME, @ptrCast(&name), 3173160232);
    }

    pub fn initFromVariantConstructor(variant: *const Variant) String {
        const ret: StringName = {};
        StringName.raw_methods.from_variant_constructor.?(&ret, variant);
        return ret;
    }
};

pub const ObjectInternal = struct {
    pub var raw_bindings: struct {
        notification: gde.c.GDExtensionMethodBindPtr,
        emit_signal: gde.c.GDExtensionMethodBindPtr,
        connect: gde.c.GDExtensionMethodBindPtr,
    } = undefined;

    pub fn initializeBindings() void {
        var class_name: StringName = .initWithLatin("Object", false);
        defer class_name.deinit();
        var method_name: StringName = .initWithLatin("notification", false);
        ObjectInternal.raw_bindings.notification = gde.ci.classdb_get_method_bind.?(@ptrCast(&class_name), @ptrCast(&method_name), 4023243586);
        method_name.deinit();
        method_name = .initWithLatin("emit_signal", false);
        ObjectInternal.raw_bindings.emit_signal = gde.ci.classdb_get_method_bind.?(@ptrCast(&class_name), @ptrCast(&method_name), 4047867050);
        method_name.deinit();
        method_name = .initWithLatin("connect", false);
        ObjectInternal.raw_bindings.connect = gde.ci.classdb_get_method_bind.?(@ptrCast(&class_name), @ptrCast(&method_name), 1518946055);
        method_name.deinit();
    }
};

pub const NodeInternal = struct {
    pub var raw_bindings: struct {
        set_process: gde.c.GDExtensionMethodBindPtr,
        set_physics_process: gde.c.GDExtensionMethodBindPtr,
        queue_free: gde.c.GDExtensionMethodBindPtr,
        free: gde.c.GDExtensionMethodBindPtr,
        get_process_delta_time: gde.c.GDExtensionMethodBindPtr,
    } = undefined;

    pub fn initializeBindings() void {
        var class_name: StringName = .initWithLatin("Node", false);
        defer class_name.deinit();
        var method_name: StringName = .initWithLatin("set_process", false);
        NodeInternal.raw_bindings.set_process = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2586408642);
        method_name.deinit();
        method_name = .initWithLatin("set_physics_process", false);
        NodeInternal.raw_bindings.set_physics_process = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2586408642);
        method_name.deinit();
        method_name = .initWithLatin("queue_free", false);
        NodeInternal.raw_bindings.queue_free = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 3218959716);
        method_name.deinit();
        method_name = .initWithLatin("get_process_delta_time", false);
        NodeInternal.raw_bindings.get_process_delta_time = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 1740695150);
        method_name.deinit();
    }
};

pub const Node2DInternal = struct {
    pub var raw_bindings: struct {
        set_position: gde.c.GDExtensionMethodBindPtr,
    } = undefined;

    pub fn initializeBindings() void {
        var class_name: StringName = .initWithLatin("Node2D", false);
        defer class_name.deinit();
        var method_name: StringName = .initWithLatin("set_position", false);
        Node2DInternal.raw_bindings.set_position = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 743155724);
        method_name.deinit();
    }
};

pub const InputInternal = struct {
    pub var raw_bindings: struct {
        is_anything_pressed: gde.c.GDExtensionMethodBindPtr,
        get_vector: gde.c.GDExtensionMethodBindPtr,
    } = undefined;

    pub fn initializeBindings() void {
        var class_name: StringName = .initWithLatin("Input", false);
        defer class_name.deinit();
        var method_name: StringName = .initWithLatin("is_anything_pressed", false);
        InputInternal.raw_bindings.is_anything_pressed = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 36873697);
        method_name.deinit();
        method_name = .initWithLatin("get_vector", false);
        InputInternal.raw_bindings.get_vector = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2479607902);
        method_name.deinit();
    }
};

pub const RefCountedInternal = struct {
    pub var raw_bindings: struct {
        init_ref: gde.c.GDExtensionMethodBindPtr,
        reference: gde.c.GDExtensionMethodBindPtr,
        unreference: gde.c.GDExtensionMethodBindPtr,
        get_reference_count: gde.c.GDExtensionMethodBindPtr,
    } = undefined;

    pub fn initializeBindings() void {
        var class_name: StringName = .initWithLatin("RefCounted", false);
        defer class_name.deinit();
        var method_name: StringName = .initWithLatin("init_ref", false);
        RefCountedInternal.raw_bindings.init_ref = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2240911060);
        method_name.deinit();
        method_name = .initWithLatin("reference", false);
        RefCountedInternal.raw_bindings.reference = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2240911060);
        method_name.deinit();
        method_name = .initWithLatin("unreference", false);
        RefCountedInternal.raw_bindings.unreference = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 2240911060);
        method_name.deinit();
        method_name = .initWithLatin("get_reference_count", false);
        RefCountedInternal.raw_bindings.get_reference_count = gde.ci.classdb_get_method_bind.?(&class_name, &method_name, 3905245786);
        method_name.deinit();
    }
};

pub fn toVariantType(comptime T: type) gde.c.GDExtensionVariantType {
    const Child = switch (@typeInfo(T)) {
        .pointer => |p| p.child,
        else => T,
    };

    return switch (Child) {
        comptime_int => gde.c.GDEXTENSION_VARIANT_TYPE_INT,
        comptime_float => gde.c.GDEXTENSION_VARIANT_TYPE_FLOAT,

        i64 => gde.c.GDEXTENSION_VARIANT_TYPE_INT,
        f64 => gde.c.GDEXTENSION_VARIANT_TYPE_FLOAT,

        String => gde.c.GDEXTENSION_VARIANT_TYPE_STRING,
        StringName => gde.c.GDEXTENSION_VARIANT_TYPE_STRING_NAME,
        Callable => gde.c.GDEXTENSION_VARIANT_TYPE_CALLABLE,

        Vector2f => gde.c.GDEXTENSION_VARIANT_TYPE_VECTOR2,
        Vector2i => gde.c.GDEXTENSION_VARIANT_TYPE_VECTOR2I,
        gde.c.GDExtensionObjectPtr => gde.c.GDEXTENSION_VARIANT_TYPE_OBJECT,
        else => {
            if (@hasField(Child, "base") and @FieldType(Child, "base") == gde.c.GDExtensionObjectPtr) {
                return gde.c.GDEXTENSION_VARIANT_TYPE_OBJECT;
            } else {
                @compileError("unsupported type: " ++ @typeName(T));
            }
        },
    };
}

pub fn callBuiltinConstructorAnytype(
    constructor: gde.c.GDExtensionPtrConstructor,
    base: gde.c.GDExtensionTypePtr,
    args: anytype,
) void {
    var call_args: [args.len]gde.c.GDExtensionConstTypePtr = undefined;
    inline for (args, 0..) |arg, idx| {
        call_args[idx] = @ptrCast(arg);
    }

    constructor.?(base, @ptrCast(&call_args));
}

pub fn callBuiltinMethodPtrRetAnytype(
    comptime T: type,
    method: gde.c.GDExtensionPtrBuiltInMethod,
    base: gde.c.GDExtensionTypePtr,
    args: anytype,
) T {
    var ret: T = std.mem.zeroes(T);
    var call_args: [args.len]gde.c.GDExtensionConstTypePtr = undefined;
    inline for (args, 0..) |arg, idx| {
        call_args[idx] = @ptrCast(arg);
    }

    method.?(base, @ptrCast(&call_args), @ptrCast(&ret), @intCast(args.len));
    return ret;
}

pub fn ptrCallNativeMethodBindNoRetAnytype(method_bind: gde.c.GDExtensionMethodBindPtr, instance: *anyopaque, args: anytype) void {
    var call_args: [args.len]gde.c.GDExtensionConstTypePtr = undefined;
    inline for (args, 0..) |arg, idx| {
        call_args[idx] = @ptrCast(arg);
    }

    gde.ci.object_method_bind_ptrcall.?(method_bind, instance, @ptrCast(&call_args), null);
}

pub fn ptrCallNativeMethodBindRetAnytype(comptime T: type, method_bind: gde.c.GDExtensionMethodBindPtr, instance: *anyopaque, args: anytype) T {
    var ret: T = undefined;
    var call_args: [args.len]gde.c.GDExtensionConstTypePtr = undefined;

    inline for (args, 0..) |arg, idx| {
        call_args[idx] = @ptrCast(arg);
    }

    gde.ci.object_method_bind_ptrcall.?(method_bind, instance, @ptrCast(&call_args), @ptrCast(&ret));
    return ret;
}

pub fn callNativeMethodBindRetVariant(method_bind: gde.c.GDExtensionMethodBindPtr, instance: *anyopaque, args: []const *const Variant) ErrorInternal {
    var err: gde.c.GDExtensionCallError = undefined;
    var ret: Variant = undefined;
    var r: gde.c.GDExtensionInt = undefined;
    gde.ci.object_method_bind_call.?(method_bind, instance, @ptrCast(args.ptr), @intCast(args.len), @ptrCast(&ret), @ptrCast(&err));
    VariantInternal.raw_bindings.to_type_constructor[@intFromEnum(Variant.Type.int)].?(@ptrCast(&r), &ret);
    return @enumFromInt(r);
}

pub fn callNativeMethodBindRetAnytype(method_bind: gde.c.GDExtensionMethodBindPtr, instance: *anyopaque, args: anytype) ErrorInternal {
    var call_args: [args.len]*Variant = undefined;
    defer {
        for (call_args) |arg| {
            arg.deinit();
        }
    }

    inline for (args, 0..) |arg, idx| {
        var var_arg: Variant = .init(arg);
        call_args[idx] = @ptrCast(&var_arg);
    }

    var err: gde.c.GDExtensionCallError = undefined;
    var ret: Variant = undefined;
    var r: gde.c.GDExtensionInt = undefined;
    gde.ci.object_method_bind_call.?(method_bind, instance, @ptrCast(&call_args), @intCast(args.len), @ptrCast(&ret), @ptrCast(&err));
    VariantInternal.raw_bindings.to_type_constructor[@intFromEnum(Variant.Type.int)].?(@ptrCast(&r), &ret);
    return @enumFromInt(r);
}

fn makePtrCall(comptime function: anytype) fn (?*anyopaque, gde.c.GDExtensionClassInstancePtr, [*c]const gde.c.GDExtensionConstTypePtr, gde.c.GDExtensionTypePtr) callconv(.c) void {
    const Func: type = @TypeOf(function);
    const info_func: std.builtin.Type.Fn = @typeInfo(Func).@"fn";
    const Out: type = info_func.return_type orelse @compileError("generic return type not supported");
    const argc: u32 = info_func.params.len;

    return struct {
        pub fn ptrCall(
            _: ?*anyopaque, //method
            instance: gde.c.GDExtensionClassInstancePtr,
            args: [*c]const gde.c.GDExtensionConstTypePtr,
            ret: gde.c.GDExtensionTypePtr,
        ) callconv(.c) void {
            var args_tuple: std.meta.ArgsTuple(Func) = undefined;
            const Self: type = info_func.params[0].type orelse @compileError("generic self param type not supported");

            args_tuple[0] = @as(Self, @ptrCast(@alignCast(@constCast(instance.?))));

            inline for (1..argc) |idx| {
                const T: type = info_func.params[idx].type orelse @compileError("generic param type not supported");
                args_tuple[idx] = @as(*T, @ptrCast(@alignCast(@constCast(args[idx - 1])))).*;
            }

            if (Out == void) {
                @call(.auto, function, args_tuple);
            } else {
                @as(*Out, @ptrCast(@alignCast(ret))).* = @call(.auto, function, args_tuple);
            }
        }
    }.ptrCall;
}

fn makeCall(function: anytype) fn (?*anyopaque, gde.c.GDExtensionClassInstancePtr, [*c]const gde.c.GDExtensionConstTypePtr, gde.c.GDExtensionInt, gde.c.GDExtensionVariantPtr, [*c]gde.c.GDExtensionCallError) callconv(.c) void {
    const Func: type = @TypeOf(function);
    const info_func: std.builtin.Type.Fn = @typeInfo(Func).@"fn";
    const Out: type = info_func.return_type orelse @compileError("generic return type not supported");
    const argc: u32 = info_func.params.len;

    return struct {
        pub fn call(
            _: ?*anyopaque, //method
            instance: gde.c.GDExtensionClassInstancePtr,
            args: [*c]const gde.c.GDExtensionConstTypePtr,
            _: gde.c.GDExtensionInt, //argc
            ret: gde.c.GDExtensionVariantPtr,
            _: [*c]gde.c.GDExtensionCallError,
        ) callconv(.c) void {
            var args_tuple: std.meta.ArgsTuple(Func) = undefined;
            const Self: type = info_func.params[0].type orelse @compileError("generic self param type not supported");

            args_tuple[0] = @as(Self, @ptrCast(@alignCast(@constCast(instance.?))));

            inline for (1..argc) |idx| {
                const T: type = info_func.params[idx].type orelse @compileError("generic param type not supported");
                var arg: T = undefined;
                VariantInternal.raw_bindings.to_type_constructor[toVariantType(T)].?(@ptrCast(&arg), @ptrCast(@constCast(args[idx - 1])));
                args_tuple[idx] = arg;
            }

            if (Out == void) {
                @call(.auto, function, args_tuple);
            } else {
                var res: Out = @call(.auto, function, args_tuple);
                VariantInternal.raw_bindings.from_type_constructor[toVariantType(Out)].?(ret, @ptrCast(&res));
            }
        }
    }.call;
}

pub const PropertyHint = enum(u32) {
    none = 0,
    range = 1,
    @"enum" = 2,
    enum_suggestion = 3,
    exp_easing = 4,
    link = 5,
    flags = 6,
    layers_2d_render = 7,
    layers_2d_physics = 8,
    layers_2d_navigation = 9,
    layers_3d_render = 10,
    layers_3d_physics = 11,
    layers_3d_navigation = 12,
    layers_avoidance = 37,
    file = 13,
    dir = 14,
    global_file = 15,
    global_dir = 16,
    resource_type = 17,
    multiline_text = 18,
    expression = 19,
    placeholder_text = 20,
    color_no_alpha = 21,
    object_id = 22,
    type_string = 23,
    node_path_to_edited_node = 24,
    object_too_big = 25,
    node_path_valid_types = 26,
    save_file = 27,
    global_save_file = 28,
    int_is_objectid = 29,
    int_is_pointer = 30,
    array_type = 31,
    dictionary_type = 38,
    locale_id = 32,
    localizable_string = 33,
    node_type = 34,
    hide_quaternion_edit = 35,
    password = 36,
    tool_button = 39,
    oneshot = 40,
    group_enable = 42,
    input_name = 43,
    file_path = 44,
    max = 45,
};

pub const PropertyUsageFlags = enum(u32) {
    none = 0,
    storage = 2,
    editor = 4,
    internal = 8,
    checkable = 16,
    checked = 32,
    group = 64,
    category = 128,
    subgroup = 256,
    class_is_bitfield = 512,
    no_instance_state = 1024,
    restart_if_changed = 2048,
    script_variable = 4096,
    store_if_null = 8192,
    update_all_if_modified = 16384,
    script_default_value = 32768,
    class_is_enum = 65536,
    nil_is_variant = 131072,
    array = 262144,
    always_duplicate = 524288,
    never_duplicate = 1048576,
    high_end_gfx = 2097152,
    node_path_from_scene_root = 4194304,
    resource_not_persistent = 8388608,
    keying_increments = 16777216,
    deferred_set_resource = 33554432,
    editor_instantiate_object = 67108864,
    editor_basic_setting = 134217728,
    read_only = 268435456,
    secret = 536870912,
    default = 6,
};

pub const ErrorInternal = enum(u32) {
    ok = 0,
    failed = 1,
    unavailable = 2,
    unconfigured = 3,
    unauthorized = 4,
    parameter_range_error = 5,
    out_of_memory = 6,
    file_not_found = 7,
    file_bad_drive = 8,
    file_bad_path = 9,
    file_no_permission = 10,
    file_already_in_use = 11,
    file_cant_open = 12,
    file_cant_write = 13,
    file_cant_read = 14,
    file_unrecognized = 15,
    file_corrupt = 16,
    file_missing_dependencies = 17,
    file_eof = 18,
    cant_open = 19,
    cant_create = 20,
    query_failed = 21,
    already_in_use = 22,
    locked = 23,
    timeout = 24,
    cant_connect = 25,
    cant_resolve = 26,
    connection_error = 27,
    cant_acquire_resource = 28,
    cant_fork = 29,
    invalid_data = 30,
    invalid_parameter = 31,
    already_exists = 32,
    does_not_exist = 33,
    database_cant_read = 34,
    database_cant_write = 35,
    compilation_failed = 36,
    method_not_found = 37,
    link_failed = 38,
    script_failed = 39,
    cyclic_link = 40,
    invalid_declaration = 41,
    duplicate_symbol = 42,
    parse_error = 43,
    busy = 44,
    skip = 45,
    help = 46,
    bug = 47,
    printer_on_fire = 48,
};

pub const Error = error{
    Failed,
    Unavailable,
    Unconfigured,
    Unauthorized,
    ParameterRangeError,
    OutOfMemory,
    FileNotFoundError,
    FileBadDrive,
    FileBadPath,
    FileNoPermission,
    FileAlreadyInUse,
    FileCantOpen,
    FileCantWrite,
    FileCantRead,
    FileUnrecognized,
    FileCorrupt,
    FileMissingDependencies,
    FileEof,
    CantOpen,
    CantCreate,
    QueryFailed,
    AlreadyInUse,
    Locked,
    Timeout,
    CantConnect,
    CantResolve,
    ConnectionError,
    CantAcquireResource,
    CantFork,
    InvalidData,
    InvalidParameter,
    AlreadyExists,
    DoesNotExist,
    DatabaseCantRead,
    DatabaseCantWrite,
    CompilationFailed,
    MethodNotFound,
    LinkFailed,
    ScriptFailed,
    CyclicLink,
    InvalidDeclaration,
    DuplicateSymbol,
    ParseError,
    Busy,
    Skip,
    Help,
    Bug,
    PrinterOnFire,
};

pub fn errorInternalWrap(err: ErrorInternal) Error!void {
    return switch (err) {
        .ok => {},
        .failed => error.Failed,
        .unavailable => error.Unavailable,
        .unconfigured => error.Unconfigured,
        .unauthorized => error.Unauthorized,
        .parameter_range_error => error.ParameterRangeError,
        .out_of_memory => error.OutOfMemory,
        .file_not_found => error.FileNotFoundError,
        .file_bad_drive => error.FileBadDrive,
        .file_bad_path => error.FileBadPath,
        .file_no_permission => error.FileNoPermission,
        .file_already_in_use => error.FileAlreadyInUse,
        .file_cant_open => error.FileCantOpen,
        .file_cant_write => error.FileCantWrite,
        .file_cant_read => error.FileCantRead,
        .file_unrecognized => error.FileUnrecognized,
        .file_corrupt => error.FileCorrupt,
        .file_missing_dependencies => error.FileMissingDependencies,
        .file_eof => error.FileEof,
        .cant_open => error.CantOpen,
        .cant_create => error.CantCreate,
        .query_failed => error.QueryFailed,
        .already_in_use => error.AlreadyInUse,
        .locked => error.Locked,
        .timeout => error.Timeout,
        .cant_connect => error.CantConnect,
        .cant_resolve => error.CantResolve,
        .connection_error => error.ConnectionError,
        .cant_acquire_resource => error.CantAcquireResource,
        .cant_fork => error.CantFork,
        .invalid_data => error.InvalidData,
        .invalid_parameter => error.InvalidParameter,
        .already_exists => error.AlreadyExists,
        .does_not_exist => error.DoesNotExist,
        .database_cant_read => error.DatabaseCantRead,
        .database_cant_write => error.DatabaseCantWrite,
        .compilation_failed => error.CompilationFailed,
        .method_not_found => error.MethodNotFound,
        .link_failed => error.LinkFailed,
        .script_failed => error.ScriptFailed,
        .cyclic_link => error.CyclicLink,
        .invalid_declaration => error.InvalidDeclaration,
        .duplicate_symbol => error.DuplicateSymbol,
        .parse_error => error.ParseError,
        .busy => error.Busy,
        .skip => error.Skip,
        .help => error.Help,
        .bug => error.Bug,
        .printer_on_fire => error.PrinterOnFire,
    };
}

fn createPropertyFull(
    variant_type: gde.c.GDExtensionVariantType,
    name: *StringName,
    hint: PropertyHint,
    hint_string: *String,
    class_name: *StringName,
    usage_flags: PropertyUsageFlags,
) gde.c.GDExtensionPropertyInfo {
    const info: gde.c.GDExtensionPropertyInfo = .{
        .type = variant_type,
        .name = @ptrCast(name),
        .hint = @intFromEnum(hint),
        .hint_string = @ptrCast(hint_string),
        .class_name = @ptrCast(class_name),
        .usage = @intFromEnum(usage_flags),
    };

    return info;
}

pub fn bindMembers(T: type) void {
    if (!@hasDecl(T, "GodotExport")) return;

    const struct_name: []const u8 = misc.typeName(T);
    if (@hasField(@TypeOf(T.GodotExport), "methods")) {
        inline for (T.GodotExport.methods) |method| {
            const method_name: []const u8 = misc.fnName(T, method.func);
            bindMethod(struct_name, method_name, method.func, method.args);
        }
    }

    if (@hasField(@TypeOf(T.GodotExport), "properties")) {
        inline for (T.GodotExport.properties) |property| {
            const getter_name: []const u8 = misc.fnName(T, property.getter);
            const setter_name: []const u8 = misc.fnName(T, property.setter);
            const PropertyType: type = @typeInfo(@TypeOf(property.getter)).@"fn".return_type orelse @compileError("generic return type not supported");
            bindProperty(struct_name, property.name, toVariantType(PropertyType), getter_name, setter_name, property.hint, property.hints, property.usage);
        }
    }

    if (@hasField(@TypeOf(T.GodotExport), "signals")) {
        inline for (T.GodotExport.signals) |signal| {
            bindSignal(struct_name, signal.name, signal.args);
        }
    }
}

fn bindMethod(
    struct_name: []const u8,
    name: []const u8,
    function: anytype,
    comptime args: anytype,
) void {
    const func: type = @TypeOf(function);
    const info_func: std.builtin.Type.Fn = @typeInfo(func).@"fn";
    const return_type: type = info_func.return_type orelse @compileError("generic return type not supported");

    var string_name_name: StringName = .initWithLatin("", false);
    defer string_name_name.deinit();
    var string_hint_string: String = .initWithUtf8("");
    defer string_hint_string.deinit();
    var string_name_struct_name: StringName = .initWithLatin(struct_name, false);
    defer string_name_struct_name.deinit();
    var string_name_method_name: StringName = .initWithLatin(name, false);
    defer string_name_method_name.deinit();

    const has_return: bool = if (return_type == void) false else true;
    var string_name_args: [args.len]StringName = undefined;
    var args_info: [args.len]gde.c.GDExtensionPropertyInfo = undefined;
    var metadata_args: [args.len]gde.c.GDExtensionClassMethodArgumentMetadata = undefined;

    defer {
        for (&string_name_args) |*sna| {
            sna.deinit();
        }
    }

    inline for (args, 0..) |arg, idx| {
        string_name_args[idx] = .initWithLatin(arg.name, false);
        args_info[idx] = createPropertyFull(toVariantType(arg.type), &string_name_args[idx], .none, &string_hint_string, &string_name_name, .default);
        metadata_args[idx] = gde.c.GDEXTENSION_METHOD_ARGUMENT_METADATA_NONE;
    }

    const call_func: gde.c.GDExtensionClassMethodCall = makeCall(function);
    const ptrcall_func: gde.c.GDExtensionClassMethodPtrCall = makePtrCall(function);

    var return_value_info: gde.c.GDExtensionPropertyInfo = if (has_return) createPropertyFull(toVariantType(return_type), &string_name_name, .none, &string_hint_string, &string_name_name, .none) else undefined;

    const method_info: gde.c.GDExtensionClassMethodInfo = .{
        .name = @ptrCast(&string_name_method_name),
        .method_userdata = @ptrCast(@constCast(&function)),
        .call_func = call_func,
        .ptrcall_func = ptrcall_func,
        .method_flags = gde.c.GDEXTENSION_METHOD_FLAGS_DEFAULT,
        .has_return_value = @intFromBool(has_return),
        .return_value_info = @ptrCast(&return_value_info),
        .return_value_metadata = gde.c.GDEXTENSION_METHOD_ARGUMENT_METADATA_NONE,
        .arguments_info = @ptrCast(&args_info),
        .arguments_metadata = @ptrCast(&metadata_args),
        .argument_count = @intCast(args.len),
    };

    gde.ci.classdb_register_extension_class_method.?(gde.library, &string_name_struct_name, &method_info);
    std.log.debug("bindMethod: {s}, {s}", .{ struct_name, name });
}

fn bindProperty(
    class_name: []const u8,
    name: []const u8,
    @"type": gde.c.GDExtensionVariantType,
    getter_name: []const u8,
    setter_name: []const u8,
    hint: PropertyHint,
    hint_string: []const u8,
    usage: PropertyUsageFlags,
) void {
    var string_name_name: StringName = .initWithLatin(name, false);
    defer string_name_name.deinit();
    var string_name_class_name: StringName = .initWithLatin(class_name, false);
    defer string_name_class_name.deinit();
    var string_name_getter_name: StringName = .initWithLatin(getter_name, false);
    defer string_name_getter_name.deinit();
    var string_name_setter_name: StringName = .initWithLatin(setter_name, false);
    defer string_name_setter_name.deinit();
    var string_hint_string: String = .initWithLatin(hint_string);
    defer string_hint_string.deinit();
    var string_name_empty: StringName = .initWithLatin("", false);
    defer string_name_empty.deinit();

    const info: gde.c.GDExtensionPropertyInfo = createPropertyFull(@"type", &string_name_name, hint, &string_hint_string, &string_name_empty, usage);

    gde.ci.classdb_register_extension_class_property.?(gde.library, &string_name_class_name, &info, &string_name_setter_name, &string_name_getter_name);

    std.log.debug("bindProperty: {s}, {s}", .{ class_name, name });
}

fn bindSignal(class_name: []const u8, name: []const u8, comptime args: anytype) void {
    var string_name_class_name: StringName = .initWithLatin(class_name, false);
    defer string_name_class_name.deinit();
    var string_name_name: StringName = .initWithLatin(name, false);
    defer string_name_name.deinit();
    var string_name_empty: StringName = .initWithLatin("", false);
    defer string_name_empty.deinit();
    var string_empty: String = .initWithLatin("");
    defer string_empty.deinit();

    var string_name_args: [args.len]StringName = undefined;
    var args_info: [args.len]gde.c.GDExtensionPropertyInfo = undefined;

    defer {
        for (&string_name_args) |*sna| {
            sna.deinit();
        }
    }

    inline for (args, 0..) |arg, idx| {
        string_name_args[idx] = .initWithLatin(arg.name, false);
        args_info[idx] = createPropertyFull(toVariantType(arg.type), &string_name_args[idx], .none, &string_empty, &string_name_empty, .default);
    }

    gde.ci.classdb_register_extension_class_signal.?(gde.library, &string_name_class_name, &string_name_name, &args_info, @intCast(args.len));
    std.log.debug("bindSignal: {s}, {s}", .{ class_name, name });
}
