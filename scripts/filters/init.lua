local a = core.filter.add
a("collision", { "collision", "position.x", "position.y", "position.rotation" })
a("dynamic_collision", { "_collision", "collision.dynamic" })
a("static_collision", { "_collision", "-_dynamic_collision" })
a("move", { "position", "mover" })
a("wiskers", { "position", "wiskers" })