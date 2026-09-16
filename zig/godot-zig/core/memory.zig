const godot: type = @import("../godot.zig");
const gde: type = godot.gde;

pub fn memdelete(instance: *anyopaque) void {
    gde.ci.object_destroy.?(instance);
}
